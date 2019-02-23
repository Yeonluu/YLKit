//
//  UIImageView+YLExtension.m
//  YLKit
//
//  Created by Yeonluu on 2017/5/3.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "UIImageView+YLExtension.h"

@implementation UIImageView (YLExtension)

+ (instancetype)imageNamed:(NSString *)named
{
    return [[self alloc] initWithImage:[UIImage imageNamed:named]];
}

@end
