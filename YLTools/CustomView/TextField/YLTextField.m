//
//  YLTextField.m
//  YLTools
//
//  Created by Yeonluu on 2016/11/22.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "YLTextField.h"
#import "UITextField+YLExtension.h"
#import "UITextField+YLMobile.h"

#define MaxNameLength  10
#define MaxPhoneLength 13

@interface YLTextField () <UITextFieldDelegate>

@end

@implementation YLTextField

- (instancetype)init
{
    if (self = [super init]) {
        _enabledColor = [UIColor blackColor];
        _disabledColor = [UIColor lightGrayColor];
    }
    return self;
}

- (instancetype)initWithType:(YLTextType)type fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder title:(NSString *)title
{
    if (self = [self init]) {
        self.textColor = textColor;
        self.enabledColor = textColor;
        self.font = [UIFont systemFontOfSize:fontSize];
        self.placeholder = placeholder;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeyDone;
        self.maxTextLength = 20;
        self.title = [title clearWhiteSpace];;
        self.type = type;
        self.delegate = self;
    }
    return self;
}

+ (instancetype)textFieldWithType:(YLTextType)type fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder title:(NSString *)title
{
    return [[self alloc] initWithType:type fontSize:fontSize textColor:textColor placeholder:placeholder title:title];
}

- (void)setType:(YLTextType)type
{
    _type = type;
    if (type == YLTextTypeName) { // 姓名
        self.keyboardType = UIKeyboardTypeDefault;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        self.maxTextLength = MaxNameLength;
    }
    else if (type == YLTextTypeNumber || type == YLTextTypeMobile) { // 数字
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.maxTextLength = MaxPhoneLength;
    }
    else if (type == YLTextTypeLettersNumber) { // 字母和数字
        self.keyboardType = UIKeyboardTypeASCIICapable;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    else if (type == YLTextTypePrice) { // 金额
        self.keyboardType = UIKeyboardTypeDecimalPad;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.maxPriceAmount = 200000;
    }
    else {
        self.keyboardType = UIKeyboardTypeDefault;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
    }
    
    [self addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}


- (void)textFieldEditingChanged:(UITextField *)textField
{
    if (self.type == YLTextTypeMobile) { // 手机
        [textField verifyMobile];
    }
    else if (self.type == YLTextTypePrice) { // 金额
        if ([textField.text doubleValue] > self.maxPriceAmount) {
            textField.text = [NSString stringWithFormat:@"%.2f", self.maxPriceAmount];
        }
    }
    else { // 其他
        [textField verifyMaxLength:self.maxTextLength];
    }
    if (self.textEditingChangedBlock) {
        self.textEditingChangedBlock(textField.text);
    }
}

#pragma mark -  UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string.length) { // 删除
        return YES;
    }
    else if (self.type == YLTextTypePrice) { // 金额
        if (textField.text.doubleValue >= self.maxPriceAmount && !range.length) {
            return NO;
        }
        return [textField shouldChangePriceWithReplacementString:string];
    }
    
    if (range.location >= self.maxTextLength) {
        return NO;
    }
    else if (self.type == YLTextTypeMobile || self.type == YLTextTypeNumber) { // 数字
        unichar single = [string characterAtIndex:0];
        if (single < '0' || single > '9') {
            return NO;
        }
    }
    else if (self.type == YLTextTypeLettersNumber) { // 字母数字
        return [textField shouldChangeLettersNumberWithReplacementString:string];
    }
    return YES;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Helper

- (BOOL)isValidText
{
    if (!self.title.length) {
        return YES;
    }
    // 校验是否为空
    if (!self.isCloseEmptyVerify && [self verifyEmptyWithType:self.title]) {
        return NO;
    }

    // 校验手机号码格式
    if (self.type == YLTextTypeMobile) {
        if (![[self.text clearWhiteSpace] isMobile]) {
            NSLog(@"请输入正确的11位手机号");
            return NO;
        }
    }
    return YES;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (!enabled) {
        self.textColor = _disabledColor;
    }
    else {
        self.textColor = _enabledColor;
    }
}


@end
