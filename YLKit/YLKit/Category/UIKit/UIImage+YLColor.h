//
//  UIImage+YLColor.h
//  Recite_en
//
//  Created by Yeonluu on 15/5/24.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLColor)

/**
 根据颜色生成图片
 
 @param color 颜色
 */
+ (UIImage *)imageWithColor:(UIColor*)color;

/**
 根据颜色生成图片

 @param color 颜色
 @param size  图片尺寸
 */
+ (UIImage *)imageWithColor:(UIColor* )color size:(CGSize)size;

@end
