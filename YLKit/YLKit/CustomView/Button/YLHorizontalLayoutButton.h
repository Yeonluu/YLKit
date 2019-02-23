//
//  YLHorizontalLayoutButton.h
//  YLKit
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HButtonImageAlignment) {
    HButtonImageAlignmentLeft,    // 图片居左
    HButtonImageAlignmentRight    // 图片居右
};

typedef NS_ENUM(NSUInteger, HButtonContentAlignment) {
    HButtonContentAlignmentLeft,      // 整体居左
    HButtonContentAlignmentCenter,    // 整体居中
    HButtonContentAlignmentRight      // 整体居右
};

@interface YLHorizontalLayoutButton : UIButton

/**
 *  HorizontalLayoutButton 构造方法
 *  快速创建水平布局按钮
 */
+ (instancetype)horizontalButtonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color;

/**
 *  HorizontalLayoutButton 构造方法
 *  快速创建带选中状态的水平布局按钮
 */
+ (instancetype)horizontalButtonWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title font:(CGFloat)font color:(UIColor *)color;

/**
 *  图片对齐方式 默认居左
 */
@property (nonatomic, assign) HButtonImageAlignment imageType;

/**
 *  内容对齐方式 默认居中
 */
@property (nonatomic, assign) HButtonContentAlignment contentType;

/**
 *  图片和文字的间距 默认为5
 */
@property (nonatomic, assign) CGFloat space;

/**
 *  内容距左边的距离 默认为0 若设置此属性 则contentType失效 优先级:leftOffset>rightOffset
 */
@property (nonatomic, assign) CGFloat leftOffset;

/**
 *  内容距右边的距离 默认为0 若设置此属性 则contentType失效 优先级:leftOffset>rightOffset
 */
@property (nonatomic, assign) CGFloat rightOffset;

/**
 固定图片大小
 */
@property (nonatomic, assign) CGSize fixedImageSize;


@end
