//
//  YLAlertManager.h
//  YLTools
//
//  Created by Yeonluu on 2016/11/1.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLAlertManager : NSObject


/**
 显示有"确定"和"取消"按钮的完整Alert
 
 @param title          标题
 @param message        内容信息
 @param submitTitle    确定按钮标题
 @param submitBlock    确定事件回调
 @param cancelTitle    取消按钮标题
 @param cancelBlock    取消事件回调
 @param viewController 所在视图控制器 传nil表示使用UIAlerView，否则为UIAlertController
 */
+ (void)showTitle:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock inViewController:(UIViewController *)viewController;


/**
 显示有"确定"和"取消"按钮的Alert 其中"取消"按钮按默认样式展示
 
 @param title          标题
 @param message        内容信息
 @param submitTitle    确定按钮标题
 @param submitBlock    确定事件回调
 @param viewController 所在视图控制器 传nil表示使用UIAlerView
 */
+ (void)showTitle:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock inViewController:(UIViewController *)viewController;


/**
 显示只有"取消"按钮的Alert
 
 @param title          标题
 @param message        内容信息
 @param cancelTitle    取消按钮标题
 @param cancelBlock    取消事件回调
 @param viewController 所在视图控制器 传nil表示使用UIAlerView
 */
+ (void)showTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock inViewController:(UIViewController *)viewController;


/**
 显示带有输入框的Alert
 
 @param configurationHandler textFiled的布局设置block
 @param title                标题
 @param submitTitle          取消按钮标题
 @param submitBlock          取消事件回调
 @param viewController       所在视图控制器 传nil表示使用UIAlerView
 */
+ (void)showTextFieldWithConfigurationHandler:(void(^)(UITextField *textField))configurationHandler title:(NSString *)title submitTitle:(NSString *)submitTitle submitBlock:(void(^)(NSString *text))submitBlock inViewController:(UIViewController *)viewController;


/**
 释放正在显示的Alert
 */
+ (void)dismissAlert;

@end
