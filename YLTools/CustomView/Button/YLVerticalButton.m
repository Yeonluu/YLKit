//
//  YLVerticalButton.m
//  YLTools
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLVerticalButton.h"
#import "UILabel+YLTextSize.h"

@interface YLVerticalButton()
@property (nonatomic, assign) CGSize titleSize;
@property (nonatomic, assign) CGSize imageSize;
@end

@implementation YLVerticalButton

- (instancetype)initWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color
{
    if (self = [self init]) {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
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
    if (self.imageType == VImageAlignmentTypeBottom) {
        imageTop += self.titleTopSpace+self.titleSize.height;
    }
    return CGRectMake((contentRect.size.width-self.imageSize.width)/2, imageTop, self.imageSize.width, self.imageSize.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleTop = self.titleTopSpace;
    if (self.imageType == VImageAlignmentTypeTop) {
        titleTop += self.imageTopSpace+self.imageSize.height;
    }
    return CGRectMake(0, titleTop, contentRect.size.width, self.titleSize.height);
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    self.imageSize = image.size;
    [super setImage:image forState:state];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    self.titleSize = CGSizeMake(self.titleLabel.textWidth, self.titleLabel.textHeight);
    [self layoutSubviews];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state
{
    [super setAttributedTitle:title forState:state];
    self.titleSize = CGSizeMake(self.titleLabel.attributedTextWidth, self.titleLabel.attributedTextHeight);
    [self layoutSubviews];
}

@end
