//
//  UINavigationController+YLPop.h
//  YLKit
//
//  Created by Yeonluu on 16/3/9.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (dismiss)

/**
 dismiss可能Presented的视图控制器
 
 @param animated 动画
 @return 是否成功
 */
- (BOOL)dismisspPresentedViewControllerAnimated:(BOOL)animated;

@end


@interface UINavigationController (pop)

/**
 pop到指定序列的控制器
 
 @param index 序列
 @param animated 动画
 */
- (void)popToViewControllerAtIndex:(NSUInteger)index animated:(BOOL)animated;


/**
 pop到指定反向序列的控制器
 
 @param reverseIndex 反向序列 1为上一层 以此类推
 @param animated 动画
 */
- (void)popToViewControllerAtReverseIndex:(NSUInteger)reverseIndex animated:(BOOL)animated;

/**
 pop到指定类型的控制器

 @param aClass 控制器类型
 @param animated 动画
 */
- (BOOL)popToViewControllerWithClass:(Class)aClass animated:(BOOL)animated;


/**
 pop到当前控制器的上一个控制器
 
 @param currentViewController 当前控制器
 @param animated 动画
 */
- (void)popToPreviousViewControllerFrom:(UIViewController *)currentViewController animated:(BOOL)animated;


/**
 获取之前的控制器
 
 @param previousIndex 序列 0表示当前层 1表示上一层 依此类推
 */
- (UIViewController *)getPreviousViewController:(NSInteger)previousIndex;

@end
