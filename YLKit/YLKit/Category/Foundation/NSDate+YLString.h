//
//  NSDate+YLString.h
//  YLKit
//
//  Created by Yeonluu on 2016/11/8.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YLString)

/**
 *  获取指定样式的时间字符串
 *
 *  @param format 格式化类型样式
 */
- (NSString *)stringWithDateFormat:(NSString *)format;


/** 
 *  时:分
 */
- (NSString *)timeString;

/**
 *  时:分:秒
 */
- (NSString *)fullTimeString;

/**
 *  月-日
 */
- (NSString *)dateString;

/** 
 *  年-月-日
 */
- (NSString *)fullDateString;

/** 
 *  年-月-日 时:分
 */
- (NSString *)fullDateAndTimeString;

/**
 *  年-月-日 时:分:秒
 */
- (NSString *)fullDateAndFullTimeString;

/**
 *  前天~后天/(年-)月-日
 */
- (NSString *)dayString;

/**
 *  前天~后天/(年-)月-日 时:分
 */
- (NSString *)dayAndTimeString;

/**
 *  前天~后天/(年-)月-日 时:分:秒
 */
- (NSString *)dayAndFullTimeString;

/**
 *  周日~周一
 */
- (NSString *)weekdayString;

/**
 *  前天~今天/月-日
 */
- (NSString *)chartDayString;

/**
 *  是否为同一天
 */
- (BOOL)isSameDayAsOtherDate:(NSDate *)date;

/**
 *  获取格式化时间
 *
 *  @param dateString 日期字符串
 *  @param format     格式化类型样式
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

@end
