//
//  YLSelectButton.m
//  YLKit
//
//  Created by Yeonluu on 2017/8/15.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "YLSelectButton.h"
#import "UIButton+YLInit.H"

@implementation YLSelectButton

+ (instancetype)selectButtonWithTarget:(id)target action:(SEL)action image:(NSString *)imageNamed selectedImage:(NSString *)selectedImagNamed
{
    YLSelectButton *button = [self buttonWithTarget:target action:action image:imageNamed];
    if (selectedImagNamed.length) {
        [button setImage:[UIImage imageNamed:selectedImagNamed] forState:UIControlStateSelected];
    }
    return button;
}

+ (instancetype)selectButtonWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)size color:(UIColor *)color selectedColor:(UIColor *)selectedColor
{
    YLSelectButton *button = [self buttonWithTarget:target action:action title:title font:size color:color];
    if (selectedColor) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    return button;
}

#pragma mark - Helper

- (void)setNormalImage:(NSString *)imageNamed selectedImage:(NSString *)selectedImageNamed
{
    [self setImageNamed:imageNamed forState:UIControlStateNormal];
    [self setImageNamed:selectedImageNamed forState:UIControlStateSelected];
}

- (void)setImageNamed:(NSString *)imageNamed forState:(UIControlState)state
{
    [self setImage:imageNamed.length ? [UIImage imageNamed:imageNamed] : nil forState:state];
}

- (void)setNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

- (void)setNormalTitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedTitleColor
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (void)setNormalAttributedTitle:(NSAttributedString *)title selectedAttributedTitle:(NSAttributedString *)selectedTitle
{
    [self setAttributedTitle:title forState:UIControlStateNormal];
    [self setAttributedTitle:selectedTitle forState:UIControlStateSelected];
}


- (void)setHighlighted:(BOOL)highlighted
{
    // Do nothing
}

@end
