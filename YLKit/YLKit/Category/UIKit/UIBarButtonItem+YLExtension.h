//
//  UIBarButtonItem+YLExtension.h
//  YLKit
//
//  Created by Yeonluu on 2017/10/10.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YLExtension)

/**
 创建左侧图片按钮项
 */
+ (instancetype)leftItemWithImageNamed:(NSString *)named target:(id)target action:(SEL)action;

/**
 创建右侧图片按钮项
 */
+ (instancetype)rightItemWithImageNamed:(NSString *)named target:(id)target action:(SEL)action;

/**
 创建右侧文字按钮项
 */
+ (instancetype)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
