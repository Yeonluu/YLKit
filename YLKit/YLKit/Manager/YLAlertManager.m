//
//  YLAlertManager.m
//  YLKit
//
//  Created by Yeonluu on 2016/11/1.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "YLAlertManager.h"
#import "YLSingleton.h"

@implementation UIAlertController (show)

- (void)show
{
    UIWindow *win = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    win.rootViewController = vc;
    win.windowLevel = UIWindowLevelAlert + 1;
    [win makeKeyAndVisible];
    [vc presentViewController:self animated:YES completion:nil];
}
@end

@interface YLAlertManager ()
@property (nonatomic, strong) UIAlertController *alertController;
@end

@implementation YLAlertManager

SingletonM(Manager);

+ (void)showMessage:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(VoidBlock)submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(VoidBlock)cancelBlock
{
    [YLAlertManager dismissAlert];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [YLAlertManager sharedManager].alertController = alertController;
    
    // 取消按钮一定有
    [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (cancelBlock) {
            cancelBlock();
        }
        [YLAlertManager sharedManager].alertController = nil;
    }]];
    
    if (submitTitle.length) {
        [alertController addAction:[UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (submitBlock) {
                submitBlock();
            }
            [YLAlertManager sharedManager].alertController = nil;
        }]];
    }
    [alertController show];
}


+ (void)showMessage:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(VoidBlock)submitBlock
{
    [self showMessage:message submitTitle:submitTitle submitBlock:submitBlock cancelTitle:@"取消" cancelBlock:nil];
}

+ (void)showMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(VoidBlock)cancelBlock
{
    [self showMessage:message submitTitle:nil submitBlock:nil cancelTitle:cancelTitle cancelBlock:cancelBlock];
}

+ (void)showTextFieldWithConfigurationHandler:(void(^)(UITextField *textField))configurationHandler title:(NSString *)title submitTitle:(NSString *)submitTitle submitBlock:(void(^)(NSString *text))submitBlock
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
    [alertController show];
}


+ (void)dismissAlert
{
    if ([YLAlertManager sharedManager].alertController) {
        [[YLAlertManager sharedManager].alertController dismissViewControllerAnimated:YES completion:nil];
        [YLAlertManager sharedManager].alertController = nil;
    }
}

+ (BOOL)isShowAlert
{
    return [YLAlertManager sharedManager].alertController != nil;
}

@end

