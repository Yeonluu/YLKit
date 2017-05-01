//
//  YLHorizontalButton.h
//  YLTools
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HImageAlignmentType) {
    HImageAlignmentTypeLeft,    // 图片居左
    HImageAlignmentTypeRight    // 图片居右
};

typedef NS_ENUM(NSUInteger, ContentAlignmentType) {
    ContentAlignmentLeft,      // 整体居左
    ContentAlignmentCenter,    // 整体居中
    ContentAlignmentRight      // 整体居右
};

@interface YLHorizontalButton : UIButton

/**
 *  图片对齐方式 默认居左
 */
@property (nonatomic, assign) HImageAlignmentType imageType;

/**
 *  内容对齐方式 默认居中
 */
@property (nonatomic, assign) ContentAlignmentType contentType;

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
 *  快速创建水平布局按钮
 */
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color;


@end
