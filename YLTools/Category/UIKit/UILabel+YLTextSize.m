//
//  UILabel+TextSize.m
//  YLTools
//
//  Created by Yeonluu on 16/1/8.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "UILabel+YLTextSize.h"
#import "NSString+YLSize.h"

@implementation UILabel (YLTextSize)

- (CGFloat)textWidth
{
    return [self.text getWidthWithFont:self.font height:self.frame.size.height];
}

- (CGFloat)textHeight
{
    return [self.text getHeightWithFont:self.font width:self.frame.size.width];
}

- (CGFloat)attributedTextWidth
{
    return [self attributedTextWidthForHeight:self.frame.size.height];
}

- (CGFloat)attributedTextHeight
{
    return [self attributedTextHeightForWidth:self.frame.size.width];
}

- (CGFloat)attributedTextWidthForHeight:(CGFloat)height
{
    CGSize strSize = [self.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil].size;
    return ceilf(strSize.width);
}

- (CGFloat)attributedTextHeightForWidth:(CGFloat)width
{
    CGSize strSize = [self.attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil].size;
    return ceilf(strSize.height);
}

- (void)adjustsFontSizeWhenTextExceedWidth
{
    self.adjustsFontSizeToFitWidth = [self textWidth] > self.frame.size.width;
}

- (void)adjustsFontSizeWhenTextExceedHeight
{
    self.adjustsFontSizeToFitWidth = [self textHeight] > self.frame.size.width;
}

- (void)adjustsFontSizeWhenAttributedTextExceedWidth
{
    self.adjustsFontSizeToFitWidth = [self attributedTextWidth] > self.frame.size.width;
}

- (void)adjustsFontSizeWhenAttributedTextExceedHeight
{
    self.adjustsFontSizeToFitWidth = [self attributedTextHeight] > self.frame.size.width;
}

@end
