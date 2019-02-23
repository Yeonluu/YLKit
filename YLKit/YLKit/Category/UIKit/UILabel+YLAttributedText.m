//
//  UILabel+YLAttributedText.m
//  YLKit
//
//  Created by Yeonluu on 16/8/17.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "UILabel+YLAttributedText.h"
#import <objc/runtime.h>

NSString * const originalFontKey = @"originalFontKey";

@implementation UILabel (YLAttributedText)

- (void)setOriginalFont:(UIFont *)originalFont {
    objc_setAssociatedObject(self, &originalFontKey, originalFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)originalFont {
    return objc_getAssociatedObject(self, &originalFontKey);
}

- (void)setAttributeText:(NSString *)text font:(UIFont *)font color:(UIColor *)color range:(NSRange)range
{
    if (range.length+range.location > text.length) {
        range = NSMakeRange(0, 0);
    }
    if (!self.attributedText.length) {
        self.originalFont = self.font;
    }
    if (!self.originalFont) {
        NSRange r = NSMakeRange(0, 1);
        self.originalFont = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:&r];
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:self.originalFont ? @{NSFontAttributeName:self.originalFont} : nil];
    if (font) {
        [attrStr addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    self.attributedText = attrStr;
}

- (void)setAttributeText:(NSString *)text font:(UIFont *)font range:(NSRange)range
{
    [self setAttributeText:text font:font color:nil range:range];
}

- (void)setAttributeText:(NSString *)text color:(UIColor *)color range:(NSRange)range
{
    [self setAttributeText:text font:nil color:color range:range];
}


- (void)addAttributeText:(NSString *)text font:(UIFont *)font color:(UIColor *)color range:(NSRange)range
{
    if (range.length+range.location > text.length) {
        range = NSMakeRange(0, 0);
    }
    
    NSMutableAttributedString *appendStr = [[NSMutableAttributedString alloc] initWithString:text attributes:self.originalFont ? @{NSFontAttributeName:self.originalFont} : nil];
    if (font) {
        [appendStr addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color) {
        [appendStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attrStr appendAttributedString:appendStr];
    self.attributedText = attrStr;
}

#pragma mark - 设置行距

- (void)setAttributeText:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    if (!text) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = self.textAlignment;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:self.font}];
    self.attributedText = attrStr;
}

- (void)setAttributeText:(NSString *)text lineHeight:(CGFloat)lineHeight
{
    if (!text) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.alignment = self.textAlignment;
    CGFloat baselineOffset = (lineHeight-self.font.lineHeight)/4;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: self.font, NSBaselineOffsetAttributeName: @(baselineOffset)}];
    self.attributedText = attrStr;
}


#pragma mark - 设置删除线

- (void)setStrikethroughText:(NSString *)text
{
    [self setStrikethroughText:text range:NSMakeRange(0, text.length)];
}

- (void)setStrikethroughText:(NSString *)text range:(NSRange)range
{
    if (!text) {
        return;
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@0} range:range];
    self.attributedText = attrStr;
}


#pragma mark - 设置下划线

- (void)setUnderlineText:(NSString *)text
{
    self.attributedText = [[NSAttributedString alloc] initWithString: text attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
}
    
- (void)setUnderlineText:(NSString *)text range:(NSRange)range
{
    if (!text) {
        return;
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    self.attributedText = attrStr;
}


@end
