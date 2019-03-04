//
//  UIResponder+YLFirstResponder.h
//  YLKit
//
//  Created by Yeonluu on 15/12/8.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (YLFirstResponder)

/**
 *  获取当前的视图控制器
 */
- (UIViewController *)currentViewController;

/**
 *  获取当前的导航控制器
 */
- (UINavigationController *)currentNavigationContoller;

@end
