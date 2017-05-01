//
//  UILabel+YLExtension.m
//  YLTools
//
//  Created by Yeonluu on 15/8/17.
//  Copyright © 2015年 Yeonluu All rights reserved.
//

#import "UILabel+YLExtension.h"

@implementation UILabel (YLExtension)

+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    return label;
}

+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text
{
    UILabel *label = [self labelWithFontSize:size textColor:color];
    label.text = text;
    return label;
}

+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:size];
    label.textColor = color;
    return label;
}

+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text
{
    UILabel *label = [self labelWithBoldFontSize:size textColor:color];
    label.text = text;
    return label;
}


+ (instancetype)labelWithFontName:(NSString *)name size:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:name size:size];
    label.textColor = color;
    return label;
}

@end
