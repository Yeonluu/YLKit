//
//  NSString+YLSize.m
//  YLTools
//
//  Created by Yeonluu on 15/10/9.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "NSString+YLSize.h"

@implementation NSString (YLSize)

- (CGSize)getSizeWithFont:(UIFont *)font size:(CGSize)size
{
    CGSize strSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return CGSizeMake(ceilf(strSize.width), ceilf(strSize.height));
}


- (CGFloat)getWidthWithFont:(UIFont *)font height:(CGFloat)height
{
    return [self getSizeWithFont:font size:CGSizeMake(MAXFLOAT, height)].width;
}


- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    return [self getSizeWithFont:font size:CGSizeMake(width, MAXFLOAT)].height;
}


- (CGSize)getSizeWithAttributes:(NSDictionary *)attributes size:(CGSize)size
{
    CGSize strSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    return CGSizeMake(ceilf(strSize.width), ceilf(strSize.height));
}


- (CGFloat)getWidthWithAttributes:(NSDictionary *)attrs height:(CGFloat)height
{
    return [self getSizeWithAttributes:attrs size:CGSizeMake(MAXFLOAT, height)].width;
}


- (CGFloat)getHeightWithAttributes:(NSDictionary *)attrs width:(CGFloat)width
{
    return [self getSizeWithAttributes:attrs size:CGSizeMake(width, MAXFLOAT)].height;
}


+ (NSDictionary *)attributesWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    return attributes;
}


@end
