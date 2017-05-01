//
//  YLVerticalButton.h
//  YLTools
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VImageAlignmentType) {
    VImageAlignmentTypeTop,     // 图片居上
    VImageAlignmentTypeBottom   // 图片居下
};

@interface YLVerticalButton : UIButton

/**
 *  图片对齐方式 默认居上
 */
@property (nonatomic, assign) VImageAlignmentType imageType;

/**
 *  图片到顶部的距离 或 图片到文字的距离 默认为5
 */
@property (nonatomic, assign) CGFloat imageTopSpace;

/**
 *  文字到顶部的距离 或 文字到图片的距离 默认为5
 */
@property (nonatomic, assign) CGFloat titleTopSpace;

/**
 *  快速创建垂直布局按钮 YLVerticalButton
 */
- (instancetype)initWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color;

@end
