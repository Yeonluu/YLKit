//
//  UITextField+YLExtension.h
//  YLKit
//
//  Created by Yeonluu on 15/12/10.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+YLCheck.h"

@interface UITextField (YLExtension)

/**
 快速构造方法
 
 @param fontSize      字体大小
 @param textColor     文本颜色
 @param placeholder   占位文字
 @param keyboardType  键盘类型
 @param returnKeyType 返回按钮类型
 @param delegate      代理
 @param target        事件处理对象
 @param action        内容改变事件
 */
+ (instancetype)textFieldWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType delegate:(id<UITextFieldDelegate>)delegate target:(id)target action:(SEL)action;


#pragma mark - 校验

/**
 *  校验最大长度
 *
 *  @param maxLength 最大长度
 */
- (void)checkMaxLength:(NSInteger)maxLength;

/**
 *  校验表情，若有直接删除
 */
- (void)checkEmoji;

/**
 *  校验中文，若有直接删除
 */
- (void)checkChinese;

/**
 *  校验中文和空格，若有直接删除
 */
- (void)checkChineseAndSpace;

/**
 *  校验开头空格，若有直接删除
 */
- (void)checkPrefixSpace;

/**
 *  校验空串
 *
 *  @param error 错误提示
 *
 *  @return 是否为空
 */
- (BOOL)checkEmptyWithError:(NSString *)error;

/**
 *  校验空串
 *
 *  @param type 错误提示 (请输入type)
 *
 *  @return 是否为空
 */
- (BOOL)checkEmptyWithType:(NSString *)type;


/**
 *  输入时格式化手机号 处理光标位置
 */
- (void)formatMobile;

/**
 *  输入金额情况下校验
 *
 *  @param string 替换字符
 *
 *  @return 是否替换
 */
- (BOOL)shouldChangePriceWithReplacementString:(NSString *)string;


@end
