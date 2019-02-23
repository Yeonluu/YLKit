//
//  NSDate+YLString.m
//  YLKit
//
//  Created by Yeonluu on 2016/11/8.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "NSDate+YLString.h"

@implementation NSDate (YLString)

- (NSString *)stringWithDateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter dateFromString:dateString];
}

- (NSString *)timeString
{
    return [self stringWithDateFormat:@"HH:mm"];
}

- (NSString *)fullTimeString
{
    return [self stringWithDateFormat:@"HH:mm:ss"];
}

- (NSString *)dateString
{
    return [self stringWithDateFormat:@"MM-dd"];
}

- (NSString *)fullDateString
{
    return [self stringWithDateFormat:@"yyyy-MM-dd"];
}

- (NSString *)dateAndTimeString
{
    return [self stringWithDateFormat:@"MM-dd HH:mm"];
}

- (NSString *)fullDateAndTimeString
{
    return [self stringWithDateFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)fullDateAndFullTimeString
{
    return [self stringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
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

- (NSString *)dayAndTimeString
{
    return [NSString stringWithFormat:@"%@ %@", [self dayString], [self timeString]];
}

- (NSString *)dayAndFullTimeString
{
    return [NSString stringWithFormat:@"%@ %@", [self dayString], [self fullTimeString]];
}

- (NSString *)weekdayString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
    return @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"][[dateComponents weekday]-1];
}

- (NSString *)chartDayString
{
    NSArray *days = @[@"前天", @"昨天", @"今天"];
    for (int i = -2; i <= 0; i++) {
        if ([self isSameDayAsOtherDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*i]]) {
            return days[i+2];
        }
    }
    return [self dateString];
}

#pragma mark - Helper

- (BOOL)isSameDayAsOtherDate:(NSDate *)date
{
    if (!date) {
        return NO;
    }
    NSDate *newDate = [[self class] normalizeDate:date];
    return [[[self class] normalizeDate:self] isEqualToDate:newDate];
}

- (BOOL)isSameMonthAsOtherDate:(NSDate *)date
{
    if (!date) {
        return NO;
    }
    NSDate *newDate = [[self class] monthDate:date];
    return [[[self class] monthDate:self] isEqualToDate:newDate];
}

+ (NSDate *)normalizeDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
    NSDate* returnDate = [calendar dateFromComponents:dateComponents];
    return returnDate;
}

+ (NSDate *)monthDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
    NSDate* returnDate = [calendar dateFromComponents:dateComponents];
    return returnDate;
}

@end
