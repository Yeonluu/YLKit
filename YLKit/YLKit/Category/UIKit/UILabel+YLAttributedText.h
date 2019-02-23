//
//  UILabel+YLAttributedtext.h
//  YLKit
//
//  Created by Yeonluu on 16/8/17.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+YLTextSize.h"

@interface UILabel (YLAttributedText)

/**
 *  设置富文本
 *
 *  @param text      字符串
 *  @param font      字体
 *  @param color     颜色
 *  @param range     范围
 */
- (void)setAttributeText:(NSString *)text font:(UIFont *)font color:(UIColor *)color range:(NSRange)range;

/**
 *  设置富文本 字体
 *
 *  @param text   字符串
 *  @param font   字体
 *  @param range  范围
 */
- (void)setAttributeText:(NSString *)text font:(UIFont *)font range:(NSRange)range;


/**
 *  设置富文本 颜色
 *
 *  @param text   字符串
 *  @param color  颜色
 *  @param range  范围
 */
- (void)setAttributeText:(NSString *)text color:(UIColor *)color range:(NSRange)range;



/**
 *  在原有的富文本上添加富文本
 *
 *  @param text      字符串
 *  @param font      字体
 *  @param color     颜色
 *  @param range     范围
 */
- (void)addAttributeText:(NSString *)text font:(UIFont *)font color:(UIColor *)color range:(NSRange)range;

#pragma mark - 行距

/**
 *  设置带行距的文本
 *
 *  @param text        字符串
 *  @param lineSpacing 行距
 */
- (void)setAttributeText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;

/**
 *  设置带行高的文本
 *
 *  @param text       字符串
 *  @param lineHeight 行高
 */
- (void)setAttributeText:(NSString *)text lineHeight:(CGFloat)lineHeight;


#pragma mark - 删除线

/**
 *  设置带删除线的文本
 *
 *  @param text 字符串
 */
- (void)setStrikethroughText:(NSString *)text;

/**
 *  设置范围带删除线的文本
 *
 *  @param text  字符串
 *  @param range 范围
 */
- (void)setStrikethroughText:(NSString *)text range:(NSRange)range;


#pragma mark - 下划线

/**
 *  设置带下划线的文本
 *
 *  @param text 字符串
 */
- (void)setUnderlineText:(NSString *)text;


/**
 *  设置范围带下划线的文本
 *
 *  @param text  字符串
 *  @param range 范围
 */
- (void)setUnderlineText:(NSString *)text range:(NSRange)range;


@end
