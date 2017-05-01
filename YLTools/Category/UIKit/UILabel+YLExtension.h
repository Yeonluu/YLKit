//
//  UILabel+YLExtension.h
//  YLTools
//
//  Created by Yeonluu on 15/8/17.
//  Copyright © 2015年 Yeonluu All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YLExtension)

+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color;

+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text;

+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color;

+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text;


/**
 *  HelveticaNeue-Bold
 */
+ (instancetype)labelWithFontName:(NSString *)name size:(CGFloat)size textColor:(UIColor *)color;

@end
