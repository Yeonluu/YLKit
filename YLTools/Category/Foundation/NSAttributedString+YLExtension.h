//
//  NSAttributedString+YLExtension.h
//  YLTools
//
//  Created by Yeonluu on 16/1/5.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (YLExtension)

/**
 *  范围富文本
 *
 *  @param string 字符串
 *  @param font   字体
 *  @param color  颜色
 *  @param range  富文本的范围
 */
+ (NSAttributedString *)stringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color range:(NSRange)range;

/**
 *  带行距的富文本
 *
 *  @param string      字符串
 *  @param lineSpacing 行距
 */
+ (NSAttributedString *)stringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing;


@end
