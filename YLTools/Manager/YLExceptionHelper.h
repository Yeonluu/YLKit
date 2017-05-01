//
//  YLExceptionHelper.h
//  YLTools
//
//  Created by Yeonluu on 2017/3/10.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLExceptionHelper : NSObject

/**
 处理奔溃信息

 @param exception 捕获的奔溃
 */
+ (void)handleException:(NSException *)exception;


/**
 保存错误日志到本地
 */
+ (void)saveErrorLog;

/**
 上传错误日志到服务器
 */
+ (void)uploadErrorLog;

@end
