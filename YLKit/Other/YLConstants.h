//
//  YLConstants.h
//  YLKit
//
//  Created by Yeonluu on 15/8/5.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//


/****************************** 商家版 ******************************/

// SYSTEM
#define SYSTEM_VERSION       [[UIDevice currentDevice].systemVersion doubleValue]
#define SCREEN_BOUNDS        ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH         ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_WIDTH_HALF    SCREEN_WIDTH/2.0
#define SCREEN_WIDTH_QUARTER SCREEN_WIDTH/4.0
#define SCREEN_HEIGHT        ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_IS_NARROW     (SCREEN_WIDTH == 320)  // 是否小屏
#define SCREEN_WIDTH_SCALE   (SCREEN_WIDTH/375)
#define SCREEN_HEIGHT_SCALE  (SCREEN_HEIGHT/667)

#define SCREEN_STATUS_HEIGHT  (DEVICE_IPHONEX ? 44 : 20)        // 状态栏高度
#define SCREEN_NAV_HEIGHT     (44 + SCREEN_STATUS_HEIGHT)       // 导航栏高度
#define SCREEN_BOTTOM_HEIGHT  (DEVICE_IPHONEX ? 34 : 0)         // 底部高度
#define SCREEN_TAB_HEIGHT     (49 + SCREEN_BOTTOM_HEIGHT)       // 控制栏高度
#define SCREEN_VIEW_HEIGHT    (SCREEN_HEIGHT-SCREEN_NAV_HEIGHT) // 内容视图高度
#define SCREEN_SAFE_HEIGHT    (SCREEN_VIEW_HEIGHT-SCREEN_BOTTOM_HEIGHT) // 安全视图高度

#define OPERATE_BAR_HEIGHT    45 // 操作栏高度
#define OPERATE_BOTTOM_HEIGHT (45 + SCREEN_BOTTOM_HEIGHT) // 操作栏底部高度

#define DEVICE_IOS10     (SYSTEM_VERSION >= 10.0)
#define DEVICE_IOS11     (SYSTEM_VERSION >= 11.0)
#define DEVICE_IOS12     (SYSTEM_VERSION >= 12.0)

#define DEVICE_IPHONE4   (SCREEN_HEIGHT == 480)
#define DEVICE_IPHONE5   (SCREEN_HEIGHT == 568)
#define DEVICE_IPHONE6   (SCREEN_HEIGHT == 667)
#define DEVICE_IPHONE6P  (SCREEN_HEIGHT == 736)
#define DEVICE_IPHONEX   (SCREEN_HEIGHT >= 812)
#define DEVICE_IPAD      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define ONE_PHYSICAL_PX  1.f/[UIScreen mainScreen].scale

// HELP

// 获取Documents目录      iTunes会自动备份
#define DocumentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]
// 获取Library/Caches目录 iTunes不会自动备份
#define CachePath(name)    [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]


#define AdjustmentScrollView(scrollView) \
if (@available(iOS 11.0, *)) {scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;}

#define AdjustmentTableView(tableView) \
if (SCREEN_HEIGHT == 812) {[tableView setContentInset:UIEdgeInsetsMake(0, 0, 34, 0)];}

// MAX
#define MaxNameLength       10
#define MaxPhoneLength      13
#define MaxPriceAmount      200000
#define MaxTextViewLength   200


