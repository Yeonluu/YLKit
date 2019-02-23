//
//  VerticalLayoutButton.m
//  YLKit
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLVerticalLayoutButton.h"
#import "UILabel+YLTextSize.h"

@interface YLVerticalLayoutButton()
@property (nonatomic, assign) CGSize titleSize;
@property (nonatomic, assign) CGSize imageSize;
@end

@implementation YLVerticalLayoutButton

+ (instancetype)verticalButtonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color
{
    return [[self alloc] initWithTarget:target action:action image:image title:title font:font color:color];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color
{
    if (self = [self initWithFrame:(CGRectZero)]) {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:font];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageTopSpace = 5.f;
    self.titleTopSpace = 5.f;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageTop = self.imageTopSpace;
    if (self.imageType == VButtonImageAlignmentBottom) {
        imageTop += self.titleTopSpace+self.titleSize.height;
    }
    return CGRectMake((contentRect.size.width-self.imageSize.width)/2, imageTop, self.imageSize.width, self.imageSize.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleTop = self.titleTopSpace;
    if (self.imageType == VButtonImageAlignmentTop) {
        titleTop += self.imageTopSpace+self.imageSize.height;
    }
    return CGRectMake(0, titleTop, contentRect.size.width, self.titleSize.height);
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    if (state == UIControlStateNormal) {
        self.imageSize = image.size;
        [self layoutSubviews];
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
  
    if (state == UIControlStateNormal) {
        self.titleSize = CGSizeMake(self.titleLabel.textWidth, self.titleLabel.textHeight);
        [self layoutSubviews];
    }
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state
{
    [super setAttributedTitle:title forState:state];
    
    if (state == UIControlStateNormal) {
        self.titleSize = CGSizeMake(self.titleLabel.attributedTextWidth, self.titleLabel.textHeight);
        [self layoutSubviews];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (self.frame.size.width > 0) {
        [self layoutSubviews];
    }
}


@end
