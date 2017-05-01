//
//  UITextField+YLExtension.m
//  YLTools
//
//  Created by Yeonluu on 15/12/10.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UITextField+YLExtension.h"

@implementation UITextField (YLExtension)


+ (instancetype)textFieldWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType delegate:(id<UITextFieldDelegate>)delegate target:(id)target action:(SEL)action
{
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = textColor;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.placeholder = placeholder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = returnKeyType;
    if (returnKeyType == UIKeyboardTypeNumberPad || returnKeyType == UIKeyboardTypePhonePad || returnKeyType == UIKeyboardTypeDecimalPad) {
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    textField.keyboardType = keyboardType;
    textField.delegate = delegate;
    if (target && action) {
        [textField addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
    }
    return textField;
}


- (void)verifyMaxLength:(NSInteger)maxLength
{
    NSString *toBeString = self.text;
    // 获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > maxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1) {
                self.text = [toBeString substringToIndex:maxLength];
            }
            else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}


- (BOOL)verifyEmptyWithError:(NSString *)error
{
    if (!self.text.length) {
        if (error.length) {
            NSLog(@"%@", error);
        }
        return YES;
    }
    return NO;
}


- (BOOL)verifyEmptyWithType:(NSString *)type
{
    NSString *error = [NSString stringWithFormat:@"请填写%@", type];
    return [self verifyEmptyWithError:error];
}


- (BOOL)shouldChangePriceWithReplacementString:(NSString *)string
{
    unichar single = [string characterAtIndex:0];
    if (single >= '0' && single <= '9')
    {
        if ([self.text rangeOfString:@"."].length) { // 有小数点的情况
            NSInteger selectedLocation = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
            NSInteger pointLocation = [self.text rangeOfString:@"."].location;
            if (selectedLocation <= pointLocation) { // 在小数点前输入
                return YES;
            }
            if (self.text.length - pointLocation <= 2) { // 小数点后不足两位
                return YES;
            }
            return NO;
        }
        else {
            return YES;
        }
    }
    if (single == '.') {
        if ([self.text rangeOfString:@"."].length) {
            return NO;
        }
        else {
            return YES;
        }
    }
    return NO;
}

- (BOOL)shouldChangeLettersNumberWithReplacementString:(NSString *)string
{
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}


@end
