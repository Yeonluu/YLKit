//
//  YLAlertManager.h
//  YLKit
//
//  Created by Yeonluu on 2016/11/1.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^VoidBlock)(void);
@interface YLAlertManager : NSObject

/**
 显示有"确定"和"取消"按钮的完整Alert
 
 @param message        内容信息
 @param submitTitle    确定按钮标题
 @param submitBlock    确定事件回调
 @param cancelTitle    取消按钮标题
 @param cancelBlock    取消事件回调
 */
+ (void)showMessage:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(VoidBlock)submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(VoidBlock)cancelBlock;


/**
 显示有"确定"和"取消"按钮的Alert 其中"取消"按钮按默认样式展示
 
 @param message        内容信息
 @param submitTitle    确定按钮标题
 @param submitBlock    确定事件回调
 */
+ (void)showMessage:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(VoidBlock)submitBlock;


/**
 显示只有"取消"按钮的Alert
 
 @param message        内容信息
 @param cancelTitle    取消按钮标题
 @param cancelBlock    取消事件回调
 */
+ (void)showMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(VoidBlock)cancelBlock;


/**
 显示带有输入框的Alert
 
 @param configurationHandler textField的布局设置block
 @param title                标题
 @param submitTitle          取消按钮标题
 @param submitBlock          取消事件回调
 */
+ (void)showTextFieldWithConfigurationHandler:(void(^)(UITextField *textField))configurationHandler title:(NSString *)title submitTitle:(NSString *)submitTitle submitBlock:(void(^)(NSString *text))submitBlock;


/**
 释放正在显示的Alert
 */
+ (void)dismissAlert;


/**
 是否正在显示Alert
 */
+ (BOOL)isShowAlert;

@end
