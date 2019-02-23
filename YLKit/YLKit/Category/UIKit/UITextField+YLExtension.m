//
//  UITextField+YLExtension.m
//  YLKit
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

#pragma mark - 校验

- (void)checkMaxLength:(NSInteger)maxLength
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

- (void)checkEmoji
{
    if ([self.text containsEmoji]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
//            [HUDManager showTips:@"暂不支持输入表情"];
        });
        self.text = [self.text deleteEmoji];
    }
}

- (void)checkChinese
{
    if (self.text.containsChinese) {
        self.text = [self.text deleteChinese];
    }
}

- (void)checkChineseAndSpace
{
    if (self.text.containsChineseAndSpace) {
        self.text = [self.text deleteChineseAndSpace];
    }
}

- (void)checkPrefixSpace
{
    if ([self.text hasPrefix:@" "]) {
        UITextPosition *position = [self positionFromPosition:self.selectedTextRange.start offset:0];
        self.text = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.selectedTextRange = [self textRangeFromPosition:position toPosition:position];
    }
}

- (BOOL)checkEmptyWithError:(NSString *)error
{
    if (!self.text.length) {
        if (error.length) {
//            [HUDManager showError:error];
        }
        return YES;
    }
    return NO;
}

- (BOOL)checkEmptyWithType:(NSString *)type
{
    NSString *error = [NSString stringWithFormat:@"请输入%@", [type deleteSpace]];
    return [self checkEmptyWithError:error];
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

- (void)formatMobile
{
    static NSString *lastText;
    
    UITextRange *range = self.selectedTextRange;
    self.text = [self.text formatMobile];
    if (self.text.length > 13) {
        self.text = [self.text substringToIndex:13];
    }
    NSInteger startOffset = [self offsetFromPosition:self.beginningOfDocument toPosition:range.start];
    if (startOffset == 4 || startOffset == 9) {
        NSInteger offset =  (self.text.length > lastText.length) ? 1 : -1;  
        UITextPosition *position = [self positionFromPosition:range.start offset:offset];
        self.selectedTextRange = [self textRangeFromPosition:position toPosition:position];
    }
    else {
        self.selectedTextRange = range;
    }
    lastText = self.text;
}

@end
