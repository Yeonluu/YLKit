//
//  UILabel+YLInit.h
//  YLKit
//
//  Created by Yeonluu on 15/8/17.
//  Copyright © 2015年 Yeonluu All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YLInit)

/**
 构造方法 快速创建常规体标签

 @param size  常规体字号
 @param color 文本颜色
 */
+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color;

/**
 构造方法 快速创建常规体标签
 
 @param size  常规体字号
 @param color 文本颜色
 @param text  文本内容
 */
+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text;

/**
 构造方法 快速创建中等字体标签
 
 @param size  中等字号
 @param color 文本颜色
 */
+ (instancetype)labelWithMediumFontSize:(CGFloat)size textColor:(UIColor *)color;

/**
 构造方法 快速创建粗体标签
 
 @param size  粗体字号
 @param color 文本颜色
 */
+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color;

/**
 构造方法 快速创建粗体标签
 
 @param size  粗体字号
 @param color 文本颜色
 @param text  文本内容
 */
+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text;


+ (instancetype)roundCornerLabelWithFont:(CGFloat)size color:(UIColor *)color text:(NSString *)text radius:(CGFloat)radius;

+ (instancetype)roundCornerLabelWithBoldFont:(CGFloat)size color:(UIColor *)color text:(NSString *)text radius:(CGFloat)radius;


@end
