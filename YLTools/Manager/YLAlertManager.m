//
//  YLAlertManager.m
//  YLTools
//
//  Created by Yeonluu on 2016/11/1.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "YLAlertManager.h"
#import "YLSingleton.h"

@interface YLAlertManager ()
@property (nonatomic, strong) UIAlertController *alertController;
@end

@implementation YLAlertManager

SingletonM(Manager);

+ (void)showTitle:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void (^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelBlock inViewController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [YLAlertManager sharedManager].alertController = alertController;
    
    // 取消按钮一定有
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (cancelBlock) {
            cancelBlock();
        }
        [YLAlertManager sharedManager].alertController = nil;
    }];
    [alertController addAction:cancelAction];
    
    if (submitTitle.length) {
        UIAlertAction *submitAction = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (submitBlock) {
                submitBlock();
            }
            [YLAlertManager sharedManager].alertController = nil;
        }];
        [alertController addAction:submitAction];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


+ (void)showTitle:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void (^)())submitBlock inViewController:(UIViewController *)viewController
{
    [self showTitle:title message:message submitTitle:submitTitle submitBlock:submitBlock cancelTitle:@"取消" cancelBlock:nil inViewController:viewController];
}


+ (void)showTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelBlock inViewController:(UIViewController *)viewController
{
    [self showTitle:title message:message submitTitle:nil submitBlock:nil cancelTitle:cancelTitle cancelBlock:cancelBlock inViewController:viewController];
}

+ (void)showTextFieldWithConfigurationHandler:(void(^)(UITextField *textField))configurationHandler title:(NSString *)title submitTitle:(NSString *)submitTitle submitBlock:(void(^)(NSString *text))submitBlock inViewController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [YLAlertManager sharedManager].alertController = alertController;
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        if (configurationHandler) {
            configurationHandler(textField);
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [YLAlertManager sharedManager].alertController = nil;
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [YLAlertManager sharedManager].alertController = nil;
        if (submitBlock) {
            submitBlock([alertController.textFields[0] text]);
        }
    }];
    [alertController addAction:submitAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


+ (void)dismissAlert
{
    if ([YLAlertManager sharedManager].alertController) {
        [[YLAlertManager sharedManager].alertController dismissViewControllerAnimated:YES completion:nil];
        [YLAlertManager sharedManager].alertController = nil;
    }
}

@end
