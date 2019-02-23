//
//  NSAttributedString+YLExtension.m
//  YLKit
//
//  Created by Yeonluu on 16/1/5.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "NSAttributedString+YLExtension.h"

@implementation NSAttributedString (YLExtension)


+ (instancetype)stringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color range:(NSRange)range
{
    if (range.location+range.length > string.length) {
        return nil;
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    if (font) {
        [attrStr addAttributes:@{NSFontAttributeName:font} range:range];
    }
    if (color) {
        [attrStr addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    }
    return attrStr;
}


+ (instancetype)stringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color
{
    return [self stringWithString:string font:font color:color range:NSMakeRange(0, string.length)];
}


+ (instancetype)stringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    return attrStr;
}

+ (instancetype)stringWithString:(NSString *)string lineHeight:(CGFloat)lineHeight font:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = lineHeight;
    CGFloat baselineOffset = (lineHeight-font.lineHeight)/4;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: font, NSBaselineOffsetAttributeName: @(baselineOffset)}];
    return attrStr;
}


@end
