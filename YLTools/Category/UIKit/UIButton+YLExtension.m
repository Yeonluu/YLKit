//
//  UIButton+YLExtension.m
//
//  Created by Yeonluu on 15/1/21.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UIButton+YLExtension.h"
#import "UIView+YLFrame.h"

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
        [button setTitleColor:color];
    }
    return button;
}

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size backgroundColor:(UIColor *)color cornerRadius:(CGFloat)radius
{
    UIButton *button = [self buttonWithTarget:target action:action title:title];
    [button setBackgroundColor:color];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds = YES;
    return button;
}

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth
{
    UIButton *button = [self buttonWithTarget:target action:action title:title font:size color:color];
    button.layer.cornerRadius = radius;
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = color.CGColor;
    return button;
}

#pragma mark - 快速创建图标按钮

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image
{
    UIButton *button = [self buttonWithTarget:target action:action title:nil];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.size = button.currentBackgroundImage.size;
    return button;
}

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage;
{
    UIButton *button = [self buttonWithTarget:target action:action image:image];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    return button;
}

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UIButton *button = [self buttonWithTarget:target action:action image:image];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return button;
}

#pragma mark - 设置图片

- (void)setImage:(NSString *)image
{
    [self setImage:image.length ? [UIImage imageNamed:image] : nil forState:UIControlStateNormal];
}

- (void)setImage:(NSString *)image highlightedImage:(NSString *)highlightedImage
{
    [self setImage:image.length ? [UIImage imageNamed:image] : nil forState:UIControlStateNormal];
    [self setImage:highlightedImage.length ? [UIImage imageNamed:highlightedImage] : nil forState:UIControlStateHighlighted];
}

- (void)setBackgroundImage:(NSString *)image highlightedImage:(NSString *)highlightedImage
{
    [self setBackgroundImage:image.length ? [UIImage imageNamed:image] : nil forState:UIControlStateNormal];
    [self setBackgroundImage:highlightedImage.length ? [UIImage imageNamed:highlightedImage] : nil forState:UIControlStateHighlighted];
}

- (void)setSelectedImage:(NSString *)selectedImage
{
    [self setImage:selectedImage.length ? [UIImage imageNamed:selectedImage] : nil forState:UIControlStateSelected];
}

- (void)setSelectedBackgroundImage:(NSString *)selectedImage
{
    [self setBackgroundImage:selectedImage.length ? [UIImage imageNamed:selectedImage] : nil forState:UIControlStateSelected];
}

#pragma mark - 设置文字

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

- (void)setAttributedTitle:(NSAttributedString *)title
{
    [self setAttributedTitle:title forState:UIControlStateNormal];
    [self setAttributedTitle:title forState:UIControlStateHighlighted];
}

- (void)setUnderlineWithBoldFont:(CGFloat)size
{
    if (!self.titleLabel.text) {
        return;
    }
    UIFont *font = size ? [UIFont boldSystemFontOfSize:size] : self.titleLabel.font;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle), NSForegroundColorAttributeName:self.titleLabel.textColor, NSFontAttributeName:font}];
    [self setAttributedTitle:attrStr forState:UIControlStateNormal];
}

@end
