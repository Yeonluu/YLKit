//
//  YLAddressBookManager.m
//  YLTools
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "YLAddressBookManager.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>
#import "NSString+YLRegex.h"
#import "UIImage+YLColor.h"
#import "YLSingleton.h"

@interface YLAddressBookManager() <ABPeoplePickerNavigationControllerDelegate, CNContactPickerDelegate, CNContactViewControllerDelegate>
/**
 选择联系人回调 name:姓名 phone:电话
 */
@property (nonatomic, copy) void(^selectedPersonBlock)(NSString *name, NSString *phone);

/** 是否需要校验手机号 */
@property (assign, nonatomic, getter=isNeedCheckMobile) BOOL needCheckMobile;

@end

@implementation YLAddressBookManager

SingletonM(Manager)

+ (void)showInViewController:(UIViewController *)viewController needCheckMobile:(BOOL)needCheckMobile selectedPersonBlock:(void (^)(NSString *, NSString *))selectedPersonBlock
{
    [[YLAddressBookManager sharedManager] showInViewController:viewController needCheckMobile:needCheckMobile selectedPersonBlock:selectedPersonBlock];
}

- (void)showInViewController:(UIViewController *)viewController needCheckMobile:(BOOL)needCheckMobile selectedPersonBlock:(void (^)(NSString *, NSString *))selectedPersonBlock
{
    self.selectedPersonBlock = selectedPersonBlock;
    self.needCheckMobile = needCheckMobile;
    if ([UIDevice currentDevice].systemVersion.doubleValue < 9.0) {
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        peoplePicker.displayedProperties = @[@(kABPersonPhoneProperty)];
        [viewController presentViewController:peoplePicker animated:YES completion:nil];
    }
    else {
        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
        [viewController presentViewController:contactPicker animated:YES completion:nil];
    }
}

#pragma mark - iOS9及以后 用 CNContactPickerDelegate

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    NSString *selectedName = [[NSString stringWithFormat:@"%@%@", contactProperty.contact.familyName, contactProperty.contact.givenName] clearWhiteSpace];
    NSString *selectedPhone = [contactProperty.value stringValue];
    selectedPhone = [selectedPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if (!selectedName.length) {
        NSRegularExpression *regex = [NSRegularExpression
                                      regularExpressionWithPattern:@"contact name=(.*?),"
                                      options:0 error:nil];
        NSTextCheckingResult* match = [regex firstMatchInString:contactProperty.description options:0 range:NSMakeRange(0, [contactProperty.description length])];
        NSRange range = [match rangeAtIndex:1];
        selectedName = [contactProperty.description substringWithRange:range];
    }
    
    if (self.isNeedCheckMobile) {
        if (![selectedPhone isMobile]) {
            NSLog(@"请选择正确的11位手机号");
            selectedPhone = nil;
        }
        else {
            selectedPhone = [selectedPhone formatMobile];
        }
    }
    if (self.selectedPersonBlock) {
        self.selectedPersonBlock(selectedName, selectedPhone);
    }
    picker.delegate = nil;
}

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact
{
    
}

- (BOOL)contactViewController:(CNContactViewController *)viewController shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property
{
    return YES;
}

#pragma mark - iOS8 用 ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    [self peoplePickerDidSelectPersonHandler:person identifier:identifier];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    peoplePicker.delegate = nil;
}


- (void)peoplePickerDidSelectPersonHandler:(ABRecordRef)person identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
    
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    firstName = firstName ? : @"" ;
    NSString *lastName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    lastName = lastName ? : @"";
    NSString *selectedName = [[NSString stringWithFormat:@"%@%@", lastName, firstName] clearWhiteSpace];
    
    NSString *selectedPhone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
    selectedPhone = [selectedPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if (self.isNeedCheckMobile) {
        if (![selectedPhone isMobile]) {
            NSLog(@"请选择正确的11位手机号");
            selectedPhone = nil;
        }
        else {
            selectedPhone = [selectedPhone formatMobile];
        }
    }
    if (self.selectedPersonBlock) {
        self.selectedPersonBlock(selectedName, selectedPhone);
    }
}


@end
