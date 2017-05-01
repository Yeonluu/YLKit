//
//  UIButton+YLExtension.h
//
//  Created by Yeonluu on 15/1/21.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YLExtension)

/**
 *  创建普通文字按钮
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color;
/**
 *  创建带圆角的纯色背景文字按钮
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size backgroundColor:(UIColor *)color cornerRadius:(CGFloat)radius;
/**
 *  创建带圆角的线框背景文字按钮
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth;


/**
 *  创建普通图标按钮
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image;
/**
 *  创建带普通状态和高亮状态的图标按钮
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage;
/**
 *  创建带普通状态和选中状态的图标按钮
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage;


/**
 *  设置本地普通图标
 */
- (void)setImage:(NSString *)image;
/**
 *  设置本地普通图标和高亮图标
 */
- (void)setImage:(NSString *)image highlightedImage:(NSString *)highlightedImage;
/**
 *  设置本地选中图标
 */
- (void)setSelectedImage:(NSString *)selectedImage;
/**
 *  设置本地普通背景图和高亮背景图
 */
- (void)setBackgroundImage:(NSString *)backgroundImage highlightedImage:(NSString *)highlightedImage;
/**
 *  设置本地选中背景图
 */
- (void)setSelectedBackgroundImage:(NSString *)selectedImage;

/**
 *  设置普通和高亮标题
 */
- (void)setTitle:(NSString *)title;
/**
 *  设置普通和高亮字体颜色
 */
- (void)setTitleColor:(UIColor *)color;
/**
 *  设置普通和高亮富文本标题
 */
- (void)setAttributedTitle:(NSAttributedString *)title;

/**
 设置下划线
 @param size 粗字体字号，设<=0时则取按钮当前字体
 */
- (void)setUnderlineWithBoldFont:(CGFloat)size;

@end
