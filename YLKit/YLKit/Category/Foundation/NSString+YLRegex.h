//  NSString+YLRegex.h
//  YLKit
//
//  Created by Yeonluu on 15/12/5.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YLRegex)

/**
 *  是否为有效的手机号
 */
- (BOOL)isMobile;

/**
 *  是否为有效的数字串
 */
- (BOOL)isNumber;

/**
 *  是否为有效的Email
 */
- (BOOL)isEmail;

/**
 *  格式化手机号
 */
- (NSString *)formatMobile;

/**
 *  清除空格
 */
- (NSString *)clearWhiteSpace;

@end
