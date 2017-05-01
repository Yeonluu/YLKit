//
//  YLHorizontalButton.m
//  YLTools
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLHorizontalButton.h"
#import "UILabel+YLTextSize.h"

@interface YLHorizontalButton ()
@property (nonatomic, assign) CGSize titleSize;
@property (nonatomic, assign) CGSize imageSize;
@end

@implementation YLHorizontalButton

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color
{
    YLHorizontalButton *button = [[YLHorizontalButton alloc] init];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
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
    self.contentType = ContentAlignmentCenter;
    self.space = 5.f;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.frame.size.width <= 0) {
        return CGRectZero;
    }
    CGFloat imageX = 0;
    // 图片在左
    if (self.imageType == HImageAlignmentTypeLeft) {
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
    if (self.frame.size.width <= 0) {
        return CGRectZero;
    }
    CGFloat width = self.frame.size.width, imageW = _imageSize.width, titleW = _titleSize.width;
    // 空白边距
    CGFloat margin = width - _space - imageW - titleW;

    CGFloat titleX = 0;
    // 图片在左
    if (self.imageType == HImageAlignmentTypeLeft) {
        if (self.leftOffset != 0) {
            titleX = _leftOffset + imageW + _space;
        }
        else if (self.rightOffset != 0) {
            titleX = width - titleW - _rightOffset;
        }
        else {
            switch (self.contentType) {
                case ContentAlignmentLeft:
                    titleX = imageW + _space;
                    break;
                case ContentAlignmentCenter:
                    titleX = margin / 2 + imageW + _space;
                    break;
                case ContentAlignmentRight:
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
                case ContentAlignmentLeft:
                    titleX = 0;
                    break;
                case ContentAlignmentCenter:
                    titleX = margin / 2;
                    break;
                case ContentAlignmentRight:
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
    self.imageSize = image.size;
    [super setImage:image forState:state];
    [self layoutSubviews];
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
    self.titleSize = CGSizeMake(self.titleLabel.attributedTextWidth, self.titleLabel.textHeight);
    [self layoutSubviews];
}

@end
