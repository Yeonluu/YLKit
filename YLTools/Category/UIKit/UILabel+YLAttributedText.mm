//
//  UILabel+YLAttributedText.m
//  YLTools
//
//  Created by Yeonluu on 16/8/17.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "UILabel+YLAttributedText.h"
#import "UILabel+YLTextSize.h"
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
    if (range.length == 0) {
        range = NSMakeRange(0, text.length);
    }
    if (!self.attributedText) {
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

- (void)setAttributeText:(NSString *)text font:(UIFont *)font color:(UIColor *)color range:(NSRange)range isAdjusts:(BOOL)isAdjusts
{
    [self setAttributeText:text font:font color:color range:range];
    if (isAdjusts) {
        [self adjustsFontSizeWhenAttributedTextExceedWidth];
    }
}

- (void)setAttributeText:(NSString *)text font:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attrStr;
}

- (void)setAttributeText:(NSString *)text color:(UIColor *)color range:(NSRange)range
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attrStr;
}

- (void)setAttributeText:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    if (!text) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:self.font}];
    self.attributedText = attrStr;
    
}

- (void)setStrikethroughText:(NSString *)text
{
    if (!text) {
        return;
    }
    self.attributedText = [[NSAttributedString alloc] initWithString: text attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
}

- (void)setStrikethroughText:(NSString *)text range:(NSRange)range
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    self.attributedText = attrStr;
}

- (void)setUnderlineText:(NSString *)text
{
    if (!text) {
        return;
    }
    self.attributedText = [[NSAttributedString alloc] initWithString: text attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
}
    
- (void)setUnderlineText:(NSString *)text range:(NSRange)range
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    self.attributedText = attrStr;
}


@end
