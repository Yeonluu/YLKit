//
//  UIView+YLBorder.m
//  YLKit
//
//  Created by Yeonluu on 2019/4/29.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UIView+YLBorder.h"

@implementation UIView (YLBorder)

/// 添加虚线框
///
/// - Parameters:
///   - color: 颜色
///   - cornerRadius: 圆角
- (CAShapeLayer *)addDashedBorderWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    return [self addDashedBorderWithColor:color lineWidth:1 lineDashPattern:@[@2, @4] cornerRadius:cornerRadius];
}

/// 添加虚线框
///
/// - Parameters:
///   - color: 颜色
///   - lineWidth: 线宽
///   - lineDashPattern: 线间距
///   - cornerRadius: 圆角
/// - Returns: 虚线框图层
- (CAShapeLayer *)addDashedBorderWithColor:(UIColor *)color lineWidth:(CGFloat)lineWidth lineDashPattern:(NSArray *)lineDashPattern cornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    CAShapeLayer *dashedLayer = [CAShapeLayer dashedLayerWithFrame:self.bounds color:color lineWidth:lineWidth lineDashPattern:lineDashPattern cornerRadius:cornerRadius];
    [self.layer addSublayer:dashedLayer];
    return dashedLayer;
}


/// 添加单边圆角
///
/// - Parameters:
///   - corners: 单边方向
///   - cornerRadius: 圆角
/// - Returns: 单边圆角图层
- (CAShapeLayer *)addRoundedBordersWithCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    self.layer.mask = maskLayer;
    return maskLayer;
}

/// 添加单个边框
///
/// - Parameters:
///   - edges: 单边方向
///   - color: 颜色
///   - inset: 缩进
///   - lineWidth: 线宽
/// - Returns: 单个边框图层
- (NSArray *)addBordersWithEdges:(UIRectEdge)edges color:(UIColor *)color inset:(CGFloat)inset lineWidth:(CGFloat)lineWidth {

    __block NSMutableArray *borders = [NSMutableArray array];
    UIView * (^addBorder)(NSArray *) = ^(NSArray *formats){
        UIView *border = [[UIView alloc] initWithFrame:CGRectZero];
        border.backgroundColor = color;
        border.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:border];
        
        NSMutableArray *constraints = [NSMutableArray array];
        [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:obj options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{@"inset": @(inset), @"thickness": @(lineWidth)} views:@{@"border": border}]];
        }];
        [self addConstraints:constraints];
        [borders addObject:border];
        return border;
    };
    
    if (edges & UIRectEdgeTop || edges & UIRectEdgeAll) {
        addBorder(@[@"V:|-0-[border(==thickness)]", @"H:|-inset-[border]-inset-|"]);
    }
    if (edges & UIRectEdgeBottom || edges & UIRectEdgeAll) {
        addBorder(@[@"V:[border(==thickness)]-0-|", @"H:|-inset-[border]-inset-|"]);

    }
    if (edges & UIRectEdgeLeft || edges & UIRectEdgeAll) {
        addBorder(@[@"V:|-inset-[border]-inset-|", @"H:|-0-[border(==thickness)]"]);

    }
    if (edges & UIRectEdgeRight || edges & UIRectEdgeAll) {
        addBorder(@[@"V:|-inset-[border]-inset-|", @"H:[border(==thickness)]-0-|"]);
    }
    return borders;
}


@end

@implementation CAShapeLayer (Dashed)

/// 获取虚线框图层
///
/// - Parameters:
///   - frame: 位置
///   - color: 颜色
///   - lineWidth: 线宽
///   - lineDashPattern: 线间距
///   - cornerRadius: 圆角
/// - Returns: 虚线框图层
+ (CAShapeLayer *)dashedLayerWithFrame:(CGRect)frame color:(UIColor *)color lineWidth:(CGFloat)lineWidth lineDashPattern:(NSArray *)lineDashPattern cornerRadius:(CGFloat)cornerRadius {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.strokeColor = color.CGColor;
    layer.fillColor = nil;
    layer.lineWidth = lineWidth;
    layer.lineDashPattern = lineDashPattern ? lineDashPattern : @[@2, @4];
    layer.lineCap = kCALineCapSquare;
    layer.lineJoin = kCALineJoinRound;
    layer.path = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    layer.name = @"DashedLayer";
    return layer;
}


- (void)fillPath {
    if (self.superlayer) {
        self.path = [UIBezierPath bezierPathWithRoundedRect:self.superlayer.bounds cornerRadius:self.superlayer.cornerRadius].CGPath;
    }
}


@end

