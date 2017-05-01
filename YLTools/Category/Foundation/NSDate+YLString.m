//
//  NSDate+YLString.m
//  YLTools
//
//  Created by Yeonluu on 2016/11/8.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "NSDate+YLString.h"

@implementation NSDate (SYLtring)

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter dateFromString:dateString];
}

- (NSString *)stringWithDateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)yearString
{
    return [self stringWithDateFormat:@"yyyy"];
}

- (NSString *)dateString
{
    return [self stringWithDateFormat:@"MM-dd"];
}

- (NSString *)dayString
{
    NSArray *days = @[@"前天", @"昨天", @"今天", @"明天", @"后天"];
    for (int i = -2; i <= 2 ; i++) {
        if ([self isSameDayAsOtherDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*i]]) {
            return days[i+2];
        }
    }
    return [self dateString];
}

- (NSString *)weekString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setWeekdaySymbols:@[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"]];
    [dateFormatter setShortWeekdaySymbols:@[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"]];
    [dateFormatter setVeryShortWeekdaySymbols:@[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)timeString
{
    return [self stringWithDateFormat:@"HH:mm"];
}

- (NSString *)dateAndTimeString
{
    return [NSString stringWithFormat:@"%@ %@", [self dayString], [self timeString]];
}

- (NSString *)detailDateString
{
    return [self stringWithDateFormat:@"yyyy-MM-dd"];
}

- (NSString *)detailDateAndTimeString
{
    return [self stringWithDateFormat:@"yyyy-MM-dd HH:mm"];
}

#pragma mark - Helper

- (BOOL)isSameDayAsOtherDate:(NSDate *)date
{
    NSDate *newDate = [[self class] normalizeDate:date];
    return [[[self class] normalizeDate:self] isEqualToDate:newDate];
}

- (BOOL)isSameMonthAsOtherDate:(NSDate *)date
{
    NSDate *newDate = [[self class] monthDate:date];
    return [[[self class] monthDate:self] isEqualToDate:newDate];
}

+ (NSDate *)normalizeDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday)
                                                   fromDate:date];
    NSDate* returnDate = [calendar dateFromComponents:dateComponents];
    return returnDate;
}

+ (NSDate *)monthDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth)
                                                   fromDate:date];
    NSDate* returnDate = [calendar dateFromComponents:dateComponents];
    return returnDate;
}

@end
