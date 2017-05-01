//
//  UITextField+YLExtension.h
//  YLTools
//
//  Created by Yeonluu on 15/12/10.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YLExtension)

/**
 快速构造方法
 
 @param fontSize      字体大小
 @param textColor     文本颜色
 @param placeholder   占位文字
 @param keyboardType  键盘类型
 @param returnKeyType 返回按钮类型
 @param delegate      代理
 @param target        目标对象
 @param action        内容改变事件
 */
+ (instancetype)textFieldWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType delegate:(id<UITextFieldDelegate>)delegate target:(id)target action:(SEL)action;


/**
 *  校验最大长度
 *
 *  @param maxLength 最大长度
 */
- (void)verifyMaxLength:(NSInteger)maxLength;


/**
 *  校验空串
 *
 *  @param error 错误提示
 *
 *  @return 是否为空
 */
- (BOOL)verifyEmptyWithError:(NSString *)error;


/**
 *  校验空串
 *
 *  @param type 错误提示 (请填写type)
 *
 *  @return 是否为空
 */
- (BOOL)verifyEmptyWithType:(NSString *)type;


/**
 *  输入金额情况下校验
 *
 *  @param string 替换字符
 *
 *  @return 是否替换
 */
- (BOOL)shouldChangePriceWithReplacementString:(NSString *)string;


/**
 *  输入字母数字情况下校验
 *
 *  @param string 替换字符
 *
 *  @return 是否替换
 */
- (BOOL)shouldChangeLettersNumberWithReplacementString:(NSString *)string;


@end
