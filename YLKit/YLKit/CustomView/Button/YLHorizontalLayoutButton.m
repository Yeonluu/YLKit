//
//  YLHorizontalLayoutButton.m
//  YLKit
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLHorizontalLayoutButton.h"
#import "UILabel+YLTextSize.h"

@interface YLHorizontalLayoutButton ()
@property (nonatomic, assign) CGSize titleSize;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) BOOL hasSelectedImage;
@end

@implementation YLHorizontalLayoutButton

+ (instancetype)horizontalButtonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color
{
    return [[self alloc] initWithTarget:target action:action image:image selectedImage:nil title:title font:font color:color];
}

+ (instancetype)horizontalButtonWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title font:(CGFloat)font color:(UIColor *)color
{
    return [[self alloc] initWithTarget:target action:action image:image selectedImage:selectedImage title:title font:font color:color];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title font:(CGFloat)font color:(UIColor *)color
{
    if (self = [self init]) {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        if (selectedImage.length) {
            [self setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
        }
        [self setTitleColor:color forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:font];
        [self setTitle:title forState:UIControlStateNormal];
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
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.contentType = HButtonContentAlignmentCenter;
    self.space = 5.f;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
//    if (self.frame.size.width <= 0) {
//        return CGRectZero;
//    }
    CGFloat imageX = 0;
    // 图片在左
    if (self.imageType == HButtonImageAlignmentLeft) {
        imageX = self.titleLabel.frame.origin.x - self.space - self.imageSize.width;
    }
    // 图片在右
    else {
        imageX = CGRectGetMaxX(self.titleLabel.frame) + self.space;
    }
    return CGRectMake(imageX, (self.frame.size.height - self.imageSize.height) / 2, self.imageSize.width, self.imageSize.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
//    if (self.frame.size.width <= 0) {
//        return CGRectZero;
//    }
    CGFloat width = self.frame.size.width, imageW = _imageSize.width, titleW = _titleSize.width;
    // 空白边距
    CGFloat margin = width - _space - imageW - titleW;

    CGFloat titleX = 0;
    // 图片在左
    if (self.imageType == HButtonImageAlignmentLeft) {
        if (self.leftOffset != 0) {
            titleX = _leftOffset + imageW + _space;
        }
        else if (self.rightOffset != 0) {
            titleX = width - titleW - _rightOffset;
        }
        else {
            switch (self.contentType) {
                case HButtonContentAlignmentLeft:
                    titleX = imageW + _space;
                    break;
                case HButtonContentAlignmentCenter:
                    titleX = margin / 2 + imageW + _space;
                    break;
                case HButtonContentAlignmentRight:
                    titleX = width - titleW;
                    break;
                default:
                    break;
            }
        }
    }
    // 图片在右
    else {
        if (self.leftOffset != 0) {
            titleX = _leftOffset;
        }
        else if (self.rightOffset != 0) {
            titleX = margin - _rightOffset;
        }
        else {
            switch (self.contentType) {
                case HButtonContentAlignmentLeft:
                    titleX = 0;
                    break;
                case HButtonContentAlignmentCenter:
                    titleX = margin / 2;
                    break;
                case HButtonContentAlignmentRight:
                    titleX = margin;
                    break;
                default:
                    break;
            }
        }
    }
    return CGRectMake(titleX, (self.frame.size.height - _titleSize.height) / 2, _titleSize.width, _titleSize.height);
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    if (state == UIControlStateNormal) {
        if (self.fixedImageSize.width == 0) {
            self.imageSize = image.size;
        }
        [self layoutSubviews];
    }
    else if (state == UIControlStateSelected) {
        self.hasSelectedImage = image != nil;
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

- (void)setHighlighted:(BOOL)highlighted
{
    if (!self.hasSelectedImage) {
        [super setHighlighted:highlighted];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (self.frame.size.width > 0) {
        [self layoutSubviews];
    }
}

- (void)setFixedImageSize:(CGSize)fixedImageSize
{
    _fixedImageSize = fixedImageSize;
    _imageSize = fixedImageSize;
}

@end
