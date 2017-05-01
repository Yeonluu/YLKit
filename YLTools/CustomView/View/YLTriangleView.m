//
//  YLTriangleView.m
//  YLTools
//
//  Created by Yeonluu on 15/11/5.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLTriangleView.h"

@implementation YLTriangleView
{
    UIImageView *_imageView;
}

- (instancetype)initWithOrientation:(TriangleOrientationType)orientation
{
    if (self = [super init]) {
        _orientation = orientation;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[self triangleImage]];
        _imageView.tag = self.orientation-4;
        [self addSubview:_imageView];
    }
}


- (UIImage *)triangleImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0);
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    super.backgroundColor = [UIColor clearColor];
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    
    CGPoint points[3];
    
    switch (self.orientation) {
        case TriangleOrientationTypeUp:
            points[0] = CGPointMake(width, height);
            points[1] = CGPointMake(0, height);
            points[2] = CGPointMake(width/2, 0);
            break;
        case TriangleOrientationTypeDown:
            points[0] = CGPointMake(0, 0);
            points[1] = CGPointMake(width, 0);
            points[2] = CGPointMake(width/2, height);
            break;
        case TriangleOrientationTypeLeft:
            points[0] = CGPointMake(width, 0);
            points[1] = CGPointMake(width, height);
            points[2] = CGPointMake(0, height/2);
            break;
        case TriangleOrientationTypeRight:
            points[0] = CGPointMake(0, height);
            points[1] = CGPointMake(0, 0);
            points[2] = CGPointMake(width, height/2);
            break;
        default:
            break;
    }
    CGContextAddLines(context, points, 3);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    if (_imageView) {
        _imageView.image = [self triangleImage];
    }
}

- (void)setOrientation:(TriangleOrientationType)orientation
{
    _orientation = orientation;
    _imageView.transform = CGAffineTransformMakeRotation((orientation-_imageView.tag)*M_PI_2);
}

@end
