//
//  NSString+YLSize.h
//  YLTools
//
//  Created by Yeonluu on 15/10/9.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (YLSize)

/**
 *  获取文本宽度
 *
 *  @param font   字体
 *  @param height 限制高度
 *
 *  @return 文本宽度
 */
- (CGFloat)getWidthWithFont:(UIFont *)font height:(CGFloat)height;


/**
 *  获取文本高度
 *
 *  @param font  字体
 *  @param width 限制宽度
 *
 *  @return 文本高度
 */
- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width;


/**
 *  获取富文本高度
 *
 *  @param attrs  属性字典
 *  @param height 限制高度
 *
 *  @return 富文本高度
 */
- (CGFloat)getWidthWithAttributes:(NSDictionary *)attrs height:(CGFloat)height;


/**
 *  获取富文本宽度
 *
 *  @param attrs 属性字典
 *  @param width 限制宽度
 *
 *  @return 富文本宽度
 */
- (CGFloat)getHeightWithAttributes:(NSDictionary *)attrs width:(CGFloat)width;


/**
 *  行距的属性字典
 *
 *  @param font        字体
 *  @param lineSpacing 行距
 */
+ (NSDictionary *)attributesWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;


@end
