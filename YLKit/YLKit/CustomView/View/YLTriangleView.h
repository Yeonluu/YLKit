//
//  YLTriangleView.h
//  YLKit
//
//  Created by Yeonluu on 15/11/5.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>
// 正三角形宽高比 1：sqrt(3)/2
#define TriangleAspectRatio (sqrt(3)/2)

typedef NS_ENUM(NSUInteger, TriangleOrientationType) {
    TriangleOrientationTypeUp,    // 朝上
    TriangleOrientationTypeRight, // 朝右
    TriangleOrientationTypeDown,  // 朝下
    TriangleOrientationTypeLeft,  // 朝左
};

@interface YLTriangleView : UIView

/**
 *  朝向 ：上 右 下 左  默认朝上
 */
@property (nonatomic, assign) TriangleOrientationType orientation;


/**
 *  创建三角形视图
 *
 *  @param orientation 朝向 ：上 右 下 左
 */
- (instancetype)initWithOrientation:(TriangleOrientationType)orientation;

@end
