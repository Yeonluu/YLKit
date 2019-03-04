//
//  NSAttributedString+YLInit.h
//  YLKit
//
//  Created by Yeonluu on 16/1/5.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (YLInit)

/**
 *  范围富文本
 *
 *  @param string 字符串
 *  @param font   字体
 *  @param color  颜色
 *  @param range  富文本的范围
 */
+ (instancetype)stringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color range:(NSRange)range;

/**
 *  范围富文本
 *
 *  @param string 字符串
 *  @param font   字体
 *  @param color  颜色
 */
+ (instancetype)stringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

/**
 *  带行距的富文本
 *
 *  @param string      字符串
 *  @param lineSpacing 行距
 */
+ (instancetype)stringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing;


/**
 *  带行高的富文本
 *
 *  @param string      字符串
 *  @param lineHeight  行高
 */
+ (instancetype)stringWithString:(NSString *)string lineHeight:(CGFloat)lineHeight font:(UIFont *)font;

@end
