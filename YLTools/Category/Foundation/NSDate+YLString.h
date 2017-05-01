//
//  NSDate+YLString.h
//  YLTools
//
//  Created by Yeonluu on 2016/11/8.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YLString)


/**
 *  获取格式化时间
 *
 *  @param dateString 日期字符串
 *  @param format     格式化类型样式
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

/**
 *  获取指定样式的时间字符串
 *
 *  @param format 格式化类型样式
 */
- (NSString *)stringWithDateFormat:(NSString *)format;

/**
 *  年
 */
- (NSString *)yearString;

/** 
 *  月-日
 */
- (NSString *)dateString;

/** 
 *  前天~后天
 */
- (NSString *)dayString;

/**
 *  周日~周一
 */
- (NSString *)weekString;

/** 
 *  时:分
 */
- (NSString *)timeString;

/** 
 *  前天~后天/月-日 时:分
 */
- (NSString *)dateAndTimeString;

/** 
 *  年-月-日
 */
- (NSString *)detailDateString;

/** 
 *  年-月-日 时:分
 */
- (NSString *)detailDateAndTimeString;


@end
