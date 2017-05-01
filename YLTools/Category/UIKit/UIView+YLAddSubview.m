//
//  UIView+YLAddSubview.m
//  YLTools
//
//  Created by Yeonluu on 15/10/13.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UIView+YLAddSubview.h"

@implementation UIView (YLAddSubview)

- (void)addSubviews:(NSArray *)subviews
{
    for (UIView *view in subviews) {
        [self addSubview:view];
    }
}

@end
