//
//  UILabel+YLExtension.m
//  YLKit
//
//  Created by Yeonluu on 15/8/17.
//  Copyright © 2015年 Yeonluu All rights reserved.
//

#import "UILabel+YLExtension.h"

@implementation UILabel (YLExtension)

- (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text
{
    if (self = [super init]) {
        self.font = font;
        self.textColor = color;
        self.text = text;
    }
    return self;
}


+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color
{
    return [self labelWithFontSize:size textColor:color text:nil];
}

+ (instancetype)labelWithFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text
{
    return [[self alloc] initWithFont:[UIFont systemFontOfSize:size] textColor:color text:text];
}

+ (instancetype)labelWithMediumFontSize:(CGFloat)size textColor:(UIColor *)color
{
    return [[self alloc] initWithFont:[UIFont systemFontOfSize:size weight:UIFontWeightMedium] textColor:color text:nil];
}

+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color
{
    return [self labelWithBoldFontSize:size textColor:color text:nil];
}

+ (instancetype)labelWithBoldFontSize:(CGFloat)size textColor:(UIColor *)color text:(NSString *)text
{
    return [[self alloc] initWithFont:[UIFont boldSystemFontOfSize:size] textColor:color text:text];
}

+ (instancetype)roundCornerLabelWithFont:(CGFloat)size color:(UIColor *)color text:(NSString *)text radius:(CGFloat)radius
{
    UILabel *label = [UILabel labelWithFontSize:size textColor:color text:text];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = radius;
    label.layer.borderWidth = 1;
    label.layer.borderColor = color.CGColor;
    label.layer.masksToBounds = YES;
    return label;
}

+ (instancetype)roundCornerLabelWithBoldFont:(CGFloat)size color:(UIColor *)color text:(NSString *)text radius:(CGFloat)radius
{
    UILabel *label = [UILabel roundCornerLabelWithFont:size color:color text:text radius:radius];
    label.font = [UIFont boldSystemFontOfSize:size];
    return label;
}


@end
