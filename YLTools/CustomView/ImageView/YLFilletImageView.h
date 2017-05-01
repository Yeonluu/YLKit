//
//  YLFilletImageView.h
//  YLTools
//
//  Created by Yeonluu on 15/9/9.
//  Copyright © 2015年 Yeonluu All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLFilletImageView : UIImageView


/**
 *  创建带圆角的图片控件
 *  @param radius 圆角半径 默认为8
 */
- (instancetype)initWithRadius:(CGFloat)radius;


/**
 *  创建带圆角边框的图片控件
 *  @param radius      圆角半径 默认为8
 *  @param borderWidth 边框大小
 *  @param borderColor 边框颜色
 */
- (instancetype)initWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**
 *  创建圆形图片控件
 */
+ (instancetype)roundImageView;


/**
 *  是否圆形图控件
 */
@property (nonatomic, assign, getter=isRoundStyle) BOOL roundStyle;


@end
