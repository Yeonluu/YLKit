//
//  NSAttributedString+YLExtension.m
//  YLTools
//
//  Created by Yeonluu on 16/1/5.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "NSAttributedString+YLExtension.h"

@implementation NSAttributedString (YLExtension)


+ (NSAttributedString *)stringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color range:(NSRange)range
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    if (font) {
        [attrStr addAttributes:@{NSFontAttributeName:font} range:range];
    }
    if (color) {
        [attrStr addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    }
    return attrStr;
}

+ (NSAttributedString *)stringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    return attrStr;
}

@end
