//
//  UITextField+YLMobile.h
//  YLTools
//
//  Created by Yeonluu on 15/11/24.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+YLRegex.h"
#import "UITextField+YLExtension.h"

//#define MaxPhoneLength 13

@interface UITextField (YLMobile)

- (void)verifyMobile;

@end
