//
//  UIResponder+YLFirstResponder.m
//  YLKit
//
//  Created by Yeonluu on 15/12/8.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UIResponder+YLFirstResponder.h"

@implementation UIResponder (YLFirstResponder)

- (UIViewController *)currentViewController
{
    UIViewController *controller = (UIViewController *)[self objectInResponder:self.nextResponder class:[UIViewController class]];
    return controller;
}

- (UINavigationController *)currentNavigationContoller
{
    UINavigationController *controller = (UINavigationController *)[self objectInResponder:self.nextResponder class:[UINavigationController class]];
    return controller;
}

- (UIViewController *)controlerByClass:(Class)mClass
{
    UIViewController *controller = (UIViewController *)[self objectInResponder:self.nextResponder class:mClass];
    return controller;
}

- (UIResponder *)objectInResponder:(UIResponder *)responder class:(Class)class{
    if ([responder isKindOfClass:class]) {
        return responder;
    } else {
        return [self objectInResponder:responder.nextResponder class:class];
    }
}

@end
