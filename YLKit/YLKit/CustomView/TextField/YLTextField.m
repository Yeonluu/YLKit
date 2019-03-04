//
//  YLTextField.m
//  YLKit
//
//  Created by Yeonluu on 2016/11/22.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "YLTextField.h"
#import "UITextField+YLCheck.h"

@interface YLTextField () <UITextFieldDelegate>
// 控制输入长度时，单纯用textFieldEditingChanged会导致中文输入时被截断，单纯用shouldChangeCharactersInRange又有些情况下不走这个方法
@end

@implementation YLTextField
#define MaxPhoneLength 13
- (instancetype)init
{
    if (self = [super init]) {
        _enabledColor = [UIColor blackColor];
        _disabledColor = [UIColor grayColor];
        _maxTextLength = 20;
        _maxValue = -1;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeyDone;
        [self addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self setup];
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
        self.title = [title deleteSpace];
        self.textType = type;
        if (type == YLTextTypeNone) {
            self.enabled = NO;
        }
    }
    return self;
}


+ (instancetype)textFieldWithType:(YLTextType)type fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder title:(NSString *)title
{
    return [[self alloc] initWithType:type fontSize:fontSize textColor:textColor placeholder:placeholder title:title];
}

- (void)setup
{
    self.delegate = self;
}

- (void)setTextType:(YLTextType)textType
{
    _textType = textType;
    if (textType == YLTextTypeNone) {
        return;
    }
    
    if (textType == YLTextTypeName) { // 姓名
        self.keyboardType = UIKeyboardTypeDefault;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
    }
    else if (textType == YLTextTypeNumber || textType == YLTextTypeMobile) { // 数字
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.maxTextLength = MaxPhoneLength;
    }
    else if (textType == YLTextTypeLettersNumber) { // 字母和数字
        self.keyboardType = UIKeyboardTypeASCIICapable;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    else if (textType == YLTextTypePrice) { // 金额
        self.keyboardType = UIKeyboardTypeDecimalPad;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    else if (textType == YLTextTypeASCII) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    else {
        self.keyboardType = UIKeyboardTypeDefault;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
    }
}

#pragma mark - Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string.length) { // 删除
        return YES;
    }
    
    NSString *replacedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.textType == YLTextTypePrice) { // 金额
        unichar single = [string characterAtIndex:0];
        if ((single < '0' || single > '9' ) && single != '.') {
            return NO;
        }
        return replacedString.isPirce;
    }
    else if (replacedString.length > self.maxTextLength) {
        return NO;
    }
    else if (self.textType == YLTextTypeMobile || self.textType == YLTextTypeNumber) { // 数字
        unichar single = [string characterAtIndex:0];
        if (single < '0' || single > '9') {
            return NO;
        }
    }
    else if (self.textType == YLTextTypeLettersNumber && ![string isLettersNumber]) { // 字母数字
        return NO;
    }
    else { // 其他
        if (self.textType == YLTextTypeASCII) {
            if ([string containsChinese] || [string isEqualToString:@" "]) {
                return NO;
            }
        }
        else if (range.location == 0 && [string isEqualToString:@" "]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldEditingChanged:(UITextField *)textField
{
    if (self.textType == YLTextTypeMobile) { // 手机
        [textField formatMobile];
    }
    else if (self.textType == YLTextTypePrice) { // 金额
        if (textField.text.doubleValue > self.maxValue) {
            textField.text = [NSString stringWithFormat:@"%.2f", self.maxValue];
        }
    }
    else if (self.textType == YLTextTypeNumber) { // 数额
        if (self.maxValue >= 0 && textField.text.doubleValue > self.maxValue) {
            textField.text = [NSString stringWithFormat:@"%.0f", self.maxValue];
        }
    }
    else { // 其他
        if (self.textType == YLTextTypeASCII) {
            [textField checkChineseAndSpace];
        }
        else {
            [textField checkPrefixSpace];
        }
        [textField checkMaxLength:self.maxTextLength];
    }
    if (self.textEditingChangeBlock) {
        self.textEditingChangeBlock(textField.text);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textEditingDidEndBlock) {
        self.textEditingDidEndBlock(textField.text);
    }
}
#pragma mark - Helper

- (BOOL)isValidText
{
    if (!self.title.length) {
        return YES;
    }
    // 校验是否为空
    if (!self.isEmptyable && [self checkEmptyWithType:self.title]) {
        return NO;
    }
    // 校验手机号格式
    if (self.textType == YLTextTypeMobile) {
        if ([self.text deleteSpace].isErrorMobile) {
            return NO;
        }
    }
    return YES;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (!enabled && self.textType != YLTextTypeNone) {
        self.textColor = _disabledColor;
    }
    else {
        self.textColor = _enabledColor;
    }
}


@end
