//
//  UIBarButtonItem+YLInit.m
//  YLKit
//
//  Created by Yeonluu on 2017/10/10.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "UIBarButtonItem+YLInit.h"
#import "YLConstants.h"

@implementation UIBarButtonItem (YLInit)

+ (instancetype)leftItemWithImageNamed:(NSString *)named target:(id)target action:(SEL)action
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:named] style:UIBarButtonItemStylePlain target:target action:action];
    if (DEVICE_IOS11) {
        leftItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, -100);
    }
    return leftItem;
}

+ (instancetype)rightItemWithImageNamed:(NSString *)named target:(id)target action:(SEL)action
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: named] style: UIBarButtonItemStylePlain target:target action: action];
    if (DEVICE_IOS11) {
        rightItem.imageInsets = UIEdgeInsetsMake(0, -50, 0, 0);
    }
    return rightItem;
}

+ (instancetype)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:DEVICE_IOS11 ? [NSString stringWithFormat:@"    %@", title] : title style:UIBarButtonItemStylePlain target: target action: action];
    return rightItem;
}


@end
