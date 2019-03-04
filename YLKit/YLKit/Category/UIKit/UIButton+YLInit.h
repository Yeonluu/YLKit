//
//  UIButton+YLInit.h
//
//  Created by Yeonluu on 15/1/21.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YLInit)

/**
 创建普通文字按钮

 @param target 事件处理对象
 @param action 点击事件
 @param title  标题
 @param size   字号
 @param color  字色
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color;

/**
 创建带圆角的线框背景文字按钮 默认cornerRadius=4，borderWidth=1，borderColor=font
 Color
 
 @param target 事件处理对象
 @param action 点击事件
 @param title  标题
 @param size   字号
 @param color  字色
 */
+ (instancetype)roundCornerButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color;

/**
 创建带圆角的纯色背景文字按钮 默认titleColor=whiteColor，cornerRadius=4

 @param target 事件处理对象
 @param action 点击事件
 @param title  标题
 @param size   字号
 @param backgroundColor 背景颜色
 */
+ (instancetype)roundCornerButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size backgroundColor:(UIColor *)backgroundColor;

/**
 创建普通图标按钮

 @param target      事件处理对象
 @param action      点击事件
 @param imageNamed  本地图片名
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)imageNamed;


#pragma mark - 设置图标

/**
 *  设置本地普通图标
 */
- (void)setNormalImage:(NSString *)imageNamed;

/**
 * 设置本地高亮图标
 */
- (void)setHighlightedImage:(NSString *)imageNamed;


#pragma mark - 设置标题

/**
 *  设置普通状态下的文本
 */
- (void)setNormalTitle:(NSString *)title;

/**
 *  设置普通状态下的文本颜色
 */
- (void)setNormalTitleColor:(UIColor *)color;

/**
 设置当前文本的下划线
 @param size 粗字体字号，设<=0时则取按钮当前字体
 */
- (void)setUnderlineWithBoldFont:(CGFloat)size;

/**
 设置带下划线的文本
 @param text 文本内容
 */
- (void)setUnderlineWithText:(NSString *)text;

@end
