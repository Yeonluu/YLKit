//
//  UIImage+YLColor.m
//  YLTools
//
//  Created by Yeonluu on 15/5/24.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UIImage+YLColor.h"

@implementation UIImage (YLColor)

+ (UIImage* )imageWithColor:(UIColor* )color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
