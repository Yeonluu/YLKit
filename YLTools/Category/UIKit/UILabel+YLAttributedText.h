//
//  UILabel+YLAttributedtext.h
//  YLTools
//
//  Created by Yeonluu on 16/8/17.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YLAttributedText)

/**
 *  原始的字体 (初始化创建时设置的字体，以便未被设置的文本也能维持字体，这样在计算textSize时才不会出错) 
 */
@property (nonatomic, strong) UIFont *originalFont;

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
 *  设置富文本
 *
 *  @param text      字符串
 *  @param font      字体
 *  @param color     颜色
 *  @param range     范围  
 *  @param isAdjusts 文本过长时是否自适应字体
 */
- (void)setAttributeText:(NSString *)text font:(UIFont *)font color:(UIColor *)color range:(NSRange)range isAdjusts:(BOOL)isAdjusts;


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
 *  设置带行距的文本
 *
 *  @param text        字符串
 *  @param lineSpacing 行距
 */
- (void)setAttributeText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;


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
