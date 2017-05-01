//
//  YLExceptionHelper.m
//  YLTools
//
//  Created by Yeonluu on 2017/3/10.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "YLExceptionHelper.h"
#import "YLSingleton.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

// 用log没法看具体条数，还是用plist
#define kFileErrorLog [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"errorLog.plist"]

@interface YLExceptionHelper ()
/**
 *  当前错误日志列表
 */
@property (nonatomic, strong) NSMutableArray *currentErrors;

@end

@implementation YLExceptionHelper

SingletonM(Helper)

+ (void)handleException:(NSException *)exception
{
    // 异常的名称
    NSString *name = [exception name];
    // 异常的原因
    NSString *reason = [exception reason];
    // 异常的堆栈信息
    NSArray *stackSymbols = [exception callStackSymbols];
    
    // 打印日志
    NSMutableDictionary *logInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"exception":name,@"reason":reason,@"stack":stackSymbols}];
    NSLog(@"⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n%@", logInfo);
    // 添加日志
    logInfo[@"time"] = [NSDate date];
    logInfo[@"systemVersion"] = [UIDevice currentDevice].systemVersion;
    logInfo[@"appVersion"] = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    [[YLExceptionHelper sharedHelper].currentErrors addObject:logInfo];
}


#pragma mark - 保存日志到本地
+ (void)saveErrorLog
{
    NSMutableArray *currentErrors = [YLExceptionHelper sharedHelper].currentErrors;
    if (!currentErrors.count) return;
    
    // 有日志信息
    NSMutableArray *localErrors = [NSMutableArray arrayWithContentsOfFile:kFileErrorLog];
    if (!localErrors) {
        NSDictionary *infoDict = @{@"Device":self.deviceType,
                                   @"uuid":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
                                   };
        localErrors = [NSMutableArray arrayWithObject:infoDict];
    }
    [localErrors addObjectsFromArray:currentErrors];
    // 双重写入
    if (![localErrors writeToFile:kFileErrorLog atomically:YES]) {
        [localErrors writeToFile:kFileErrorLog atomically:YES];
    }
}

#pragma mark - 上传日志到服务器213

+ (void)uploadErrorLog
{
#if TARGET_IPHONE_SIMULATOR
    return;
#else
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self uploadLogFile];
        }
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }];
#endif
}

+ (void)uploadLogFile
{
    // 获取本地日志地址
    // NSURL *fileUrl = [NSURL fileURLWithPath:kFileErrorLog];
    
    //TODO：上传本地错误日志，mimeType为"application/xml"
    
    // 上传成功删除本地日志文件
    // [[NSMutableArray array] writeToFile:kFileErrorLog atomically:YES];
}

#pragma mark - Helper

+ (NSString *)deviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    NSDictionary *dict = @{@"iPhone9,1":@"iPhone 7",
                           @"iPhone9,2":@"iPhone 7 Plus",
                           @"iPhone8,1":@"iPhone 6s",
                           @"iPhone8,2":@"iPhone 6s Plus",
                           @"iPhone8,4":@"iPhone SE",
                           @"iPhone7,1":@"iPhone 6 Plus",
                           @"iPhone7,2":@"iPhone 6",
                           @"iPhone6,1":@"iPhone 5s",
                           @"iPhone6,2":@"iPhone 5s",
                           @"iPhone5,3":@"iPhone 5c",
                           @"iPhone5,4":@"iPhone 5c",
                           @"iPhone5,1":@"iPhone 5",
                           @"iPhone5,2":@"iPhone 5",
                           @"iPhone4,1":@"iPhone 4S",
                           @"iPhone3,1":@"iPhone 4",
                           @"iPhone3,2":@"iPhone 4",
                           @"iPhone3,3":@"iPhone 4"};
    NSString *deviceType = dict[platform];
    return deviceType ? deviceType : @"Other";
}

- (NSMutableArray *)currentErrors
{
    if (!_currentErrors) {
        _currentErrors = [[NSMutableArray alloc] init];
    }
    return _currentErrors;
}



@end
