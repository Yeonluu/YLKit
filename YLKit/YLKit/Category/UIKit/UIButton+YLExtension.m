//
//  UIButton+YLExtension.m
//
//  Created by Yeonluu on 15/1/21.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UIButton+YLExtension.h"

@implementation UIButton (YLExtension)

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark - 快速创建文字按钮

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color
{
    UIButton *button = [self buttonWithTarget:target action:action title:title];
    if (size) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    return button;
}

+ (instancetype)roundCornerButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color
{
    UIButton *button = [self buttonWithTarget:target action:action title:title font:size color:color];
    button.layer.cornerRadius = 4;
    button.layer.borderWidth = 1;
    button.layer.borderColor = color.CGColor;
    return button;
}


+ (instancetype)roundCornerButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [self buttonWithTarget:target action:action title:title font:size color:nil];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    [button setBackgroundColor:backgroundColor];
    return button;
}


#pragma mark - 快速创建图标按钮

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)imageNamed
{
    UIButton *button = [self buttonWithTarget:target action:action title:nil];
    if (imageNamed.length) {
        [button setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    }
    return button;
}

#pragma mark - 设置图片

- (void)setNormalImage:(NSString *)imageNamed
{
    [self setImageNamed:imageNamed forState:UIControlStateNormal];
}

- (void)setHighlightedImage:(NSString *)imageNamed
{
    [self setImageNamed:imageNamed forState:UIControlStateHighlighted];
}

- (void)setImageNamed:(NSString *)imageNamed forState:(UIControlState)state
{
    [self setImage:imageNamed.length ? [UIImage imageNamed:imageNamed] : nil forState:state];
}

#pragma mark - 设置文字

- (void)setNormalTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setNormalTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setUnderlineWithBoldFont:(CGFloat)size
{
    if (!self.titleLabel.text) {
        return;
    }
    UIFont *font = size ? [UIFont boldSystemFontOfSize:size] : self.titleLabel.font;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle), NSForegroundColorAttributeName:self.currentTitleColor, NSFontAttributeName:font}];
    [self setAttributedTitle:attrStr forState:UIControlStateNormal];
}

- (void)setUnderlineWithText:(NSString *)text
{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle), NSForegroundColorAttributeName:self.currentTitleColor, NSFontAttributeName:self.titleLabel.font}];
    [self setAttributedTitle:attrStr forState:UIControlStateNormal];
}

@end
