//
//  YLAddressBookManager.h
//  YLKit
//
//  Created by Yeonluu on 16/1/4.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLAddressBookManager : NSObject

/**
 调出通讯录

 @param viewController     所在视图控制器
 @param needCheckMobile    是否需要校验手机号码
 @param selectedPersonBlock 选择成功联系人回调
 */
+ (void)showInViewController:(UIViewController *)viewController needCheckMobile:(BOOL)needCheckMobile selectedPersonBlock:(void(^)(NSString *name, NSString *phone))selectedPersonBlock;

@end
