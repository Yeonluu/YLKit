//
//  NSString+Size.m
//  YLKit
//
//  Created by Yeonluu on 15/10/9.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "NSString+YLSize.h"

@implementation NSString (Size)

//NSStringDrawingUsesLineFragmentOrigin = 1 << 0,
// 整个文本将以每行组成的矩形为单位计算整个文本的尺寸
//NSStringDrawingUsesFontLeading = 1 << 1,
// 使用字体的行间距来计算文本占用的范围，即每一行的底部到下一行的底部的距离计算
//NSStringDrawingUsesDeviceMetrics = 1 << 3,
// 将文字以图像符号计算文本占用范围，而不是以字符计算。也即是以每一个字体所占用的空间来计算文本范围
//NSStringDrawingTruncatesLastVisibleLine
// 当文本不能适合的放进指定的边界之内，则自动在最后一行添加省略符号。如果NSStringDrawingUsesLineFragmentOrigin没有设置，则该选项不生效

- (CGSize)getSizeWithFont:(UIFont *)font limitSize:(CGSize)size
{
    CGSize strSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil].size;
    return CGSizeMake(ceilf(strSize.width), ceilf(strSize.height));
}

- (CGFloat)getWidthWithFont:(UIFont *)font limitHeight:(CGFloat)height
{
    return [self getSizeWithFont:font limitSize:CGSizeMake(MAXFLOAT, height)].width;
}


- (CGFloat)getHeightWithFont:(UIFont *)font limitWidth:(CGFloat)width
{
    return [self getSizeWithFont:font limitSize:CGSizeMake(width, MAXFLOAT)].height;
}

@end


@implementation NSAttributedString (Size)

- (CGFloat)getWidthWithLimitHeight:(CGFloat)height
{
    return [self getSizeWithLimitSize:CGSizeMake(height, MAXFLOAT)].width;
}

- (CGFloat)getHeightWithLimitWidth:(CGFloat)width
{
    return [self getSizeWithLimitSize:CGSizeMake(width, MAXFLOAT)].height;
}

- (CGSize)getSizeWithLimitSize:(CGSize)size
{
    CGSize strSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil].size;
    return CGSizeMake(ceilf(strSize.width), ceilf(strSize.height));
}

@end
