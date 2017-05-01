//
//  MercConstants.h
//  YLTools
//
//  Created by Yeonluu on 15/8/5.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//


// SYSTEM

#define APP_VERSION      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion doubleValue]
#define SCREEN_BOUNDS    ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH     ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_IS_NARROW     (SCREEN_WIDTH == 320)  // 是否小屏
#define SCREEN_WIDTH_SCALE   (SCREEN_WIDTH/375)
#define SCREEN_HEIGHT_SCALE  (SCREEN_HEIGHT/667)

#define DEVICE_IOS10     (SYSTEM_VERSION >= 10.0)
#define DEVICE_IPHONE4   (SCREEN_HEIGHT == 480)
#define DEVICE_IPHONE5   (SCREEN_HEIGHT == 568)
#define DEVICE_IPHONE6   (SCREEN_HEIGHT == 667)
#define DEVICE_IPHONE6P  (SCREEN_HEIGHT == 736)
#define DEVICE_IPAD      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define ONE_PHYSICAL_PX  1.f/[UIScreen mainScreen].scale


// 获取Documents目录      iTunes会自动备份
#define DocumentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]
// 获取Library/Caches目录 iTunes不会自动备份
#define CachePath(name)    [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]


#define FormatString(string,args...) [NSString stringWithFormat:string,args]


