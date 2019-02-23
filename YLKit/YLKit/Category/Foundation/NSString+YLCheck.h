//
//  NSString+YLCheck.h
//  YLKit
//
//  Created by Yeonluu on 15/10/21.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YLCheck)


#pragma mark - Emoji

/**
 * 字符串是否全为emoji
 */
- (BOOL)isEmoji;

/**
 * 字符串是否含有emoji
 */
- (BOOL)containsEmoji;

/**
 * 删除字符串中的emoji
 *
 * @return 结果字符串
 */
- (NSString *)deleteEmoji;

#pragma mark - Chinese

/**
 * 字符串是否全为中文
 */
- (BOOL)isChinese;

/**
 * 字符串是否含有中文
 */
- (BOOL)containsChinese;

/**
 * 删除字符串中的中文
 *
 * @return 结果字符串
 */
- (NSString *)deleteChinese;

/**
 * 字符串是否含有中文或空格
 */
- (BOOL)containsChineseAndSpace;

/**
 * 删除字符串中的中文和空格
 *
 * @return 结果字符串
 */
- (NSString *)deleteChineseAndSpace;


#pragma mark - Mobile

/**
 *  是否为正确的手机号
 */
- (BOOL)isMobile;

/**
 *  是否为错误的手机号 自动提示错误
 */
- (BOOL)isErrorMobile;

/**
 *  格式化手机号
 */
- (NSString *)formatMobile;


#pragma mark - Other

/**
 *  是否为金额类型 两位小数
 */
- (BOOL)isPirce;

/**
 *  是否为一位小数
 */
- (BOOL)isOneDecimal;

/**
 *  是否为数字
 */
- (BOOL)isNumber;

/**
 *  是否为字母或数字
 */
- (BOOL)isLettersNumber;

/**
 *  是否为有效的Email
 */
- (BOOL)isEmail;

/**
 *  清除空格
 */
- (NSString *)deleteSpace;

@end
