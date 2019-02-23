//
//  YLVerticalLayoutButton.h
//  YLKit
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VButtonImageAlignment) {
    VButtonImageAlignmentTop,     // 图片居上
    VButtonImageAlignmentBottom   // 图片居下
};

@interface YLVerticalLayoutButton : UIButton

/**
 *  VerticalLayoutButton 构造方法
 *  快速创建垂直布局按钮
 */
+ (instancetype)verticalButtonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title font:(CGFloat)font color:(UIColor *)color;

/**
 *  图片对齐方式 默认居上
 */
@property (nonatomic, assign) VButtonImageAlignment imageType;

/**
 *  图片到顶部的距离 或 图片到文字的距离 默认为5
 */
@property (nonatomic, assign) CGFloat imageTopSpace;

/**
 *  文字到顶部的距离 或 文字到图片的距离 默认为5 文本高度自带2+间距
 */
@property (nonatomic, assign) CGFloat titleTopSpace;

@end
