//
//  ViewControllerManager.m
//  YLKit
//
//  Created by Yeonluu on 16/3/9.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "UINavigationController+YLPop.h"
#import "AppDelegate.h"

@implementation UINavigationController (dismiss)

- (BOOL)dismisspPresentedViewControllerAnimated:(BOOL)animated {
    if (self.presentedViewController) {
        if ([self.presentedViewController isKindOfClass:[UINavigationController class]]) {
            [[(UINavigationController *)self.presentedViewController viewControllers][0] dismissViewControllerAnimated:NO completion:nil];
        }
        else {
            [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        }
        return YES;
    }
    return NO;
}

@end

@implementation UINavigationController (Pop)

- (void)popToViewControllerAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    if (index >= self.viewControllers.count-1) {
        [self popViewControllerAnimated:animated];
    }
    else {
        [self popToViewController:self.viewControllers[index] animated:animated];
    }
}

- (void)popToViewControllerAtReverseIndex:(NSUInteger)reverseIndex animated:(BOOL)animated
{
    [self popToViewControllerAtIndex:self.viewControllers.count-1-reverseIndex animated:animated];
}

- (BOOL)popToViewControllerWithClass:(Class)aClass animated:(BOOL)animated
{
    __block BOOL isSuccess = NO;
    __weak typeof(self) weakSelf = self;
    [self.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass: aClass]) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf popToViewController:obj animated:YES];
            isSuccess = YES;
            *stop = YES;
        }
    }];
    return isSuccess;
}

- (void)popToViewControllerAtReverseIndex:(NSUInteger)reverseIndex from:(UIViewController *)currentViewController animated:(BOOL)animated
{
    NSUInteger currentIndex = [self.viewControllers indexOfObject:currentViewController];
    if (!currentViewController || currentIndex == NSNotFound) {
        currentIndex = self.viewControllers.count-1;
    }
    
    [self popToViewControllerAtIndex:currentIndex-reverseIndex animated:animated];
}

- (void)popToPreviousViewControllerFrom:(UIViewController *)currentViewController animated:(BOOL)animated
{
    [self popToViewControllerAtReverseIndex:1 from:currentViewController animated:animated];
}

- (UIViewController *)getPreviousViewController:(NSInteger)previousIndex
{
    if (previousIndex < 0) {
        previousIndex = 0;
    }
    return self.viewControllers[self.viewControllers.count-1-previousIndex];
}

@end
