//
//  UIView+YLBorder.h
//  YLKit
//
//  Created by Yeonluu on 2019/4/29.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YLBorder)

/// 添加虚线框
///
/// - Parameters:
///   - color: 颜色
///   - cornerRadius: 圆角
- (CAShapeLayer *)addDashedBorderWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/// 添加虚线框
///
/// - Parameters:
///   - color: 颜色
///   - lineWidth: 线宽
///   - lineDashPattern: 线间距
///   - cornerRadius: 圆角
/// - Returns: 虚线框图层
- (CAShapeLayer *)addDashedBorderWithColor:(UIColor *)color lineWidth:(CGFloat)lineWidth lineDashPattern:(NSArray *)lineDashPattern cornerRadius:(CGFloat)cornerRadius;


/// 添加单边圆角
///
/// - Parameters:
///   - corners: 单边方向
///   - cornerRadius: 圆角
/// - Returns: 单边圆角图层
- (CAShapeLayer *)addRoundedBordersWithCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

/// 添加单个边框
///
/// - Parameters:
///   - edges: 单边方向
///   - color: 颜色
///   - inset: 缩进
///   - lineWidth: 线宽
/// - Returns: 单个边框图层
- (NSArray *)addBordersWithEdges:(UIRectEdge)edges color:(UIColor *)color inset:(CGFloat)inset lineWidth:(CGFloat)lineWidth;

@end
    
@interface CAShapeLayer (Dashed)

/// 获取虚线框图层
///
/// - Parameters:
///   - frame: 位置
///   - color: 颜色
///   - lineWidth: 线宽
///   - lineDashPattern: 线间距
///   - cornerRadius: 圆角
/// - Returns: 虚线框图层
+ (CAShapeLayer *)dashedLayerWithFrame:(CGRect)frame color:(UIColor *)color lineWidth:(CGFloat)lineWidth lineDashPattern:(NSArray *)lineDashPattern cornerRadius:(CGFloat)cornerRadius;

/**
 重新绘制图层
 */
- (void)fillPath;

@end


NS_ASSUME_NONNULL_END
