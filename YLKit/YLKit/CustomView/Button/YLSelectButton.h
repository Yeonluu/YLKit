//
//  YLSelectButton.h
//  YLKit
//
//  Created by Yeonluu on 2017/8/15.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLSelectButton : UIButton

/**
 SelectButton 构造方法
 
 @param target            事件处理对象
 @param action            点击事件
 @param imageNamed        本地图片名
 @param selectedImagNamed 选中状态下的本地图片名
 */
+ (instancetype)selectButtonWithTarget:(id)target action:(SEL)action image:(NSString *)imageNamed selectedImage:(NSString *)selectedImagNamed;

/**
 SelectButton 构造方法
 
 @param target        事件处理对象
 @param action        点击事件
 @parma title         标题
 @parma size          字号
 @param color         字色
 @param selectedColor 选中状态下的字色
 */
+ (instancetype)selectButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color selectedColor:(UIColor *)selectedColor;


/**
 设置普通和选中状态本地图标
 */
- (void)setNormalImage:(NSString *)imageNamed selectedImage:(NSString *)imageNamed;

/**
 设置普通和选中状态标题颜色
 */
- (void)setNormalTitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedTitleColor;

/**
 设置普通和选中状态标题
 */
- (void)setNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle;

/**
 设置普通和选中状态富文本标题
 */
- (void)setNormalAttributedTitle:(NSAttributedString *)title selectedAttributedTitle:(NSAttributedString *)selectedTitle;

@end
