//
//  NSString+YLRounding.m
//  YLKit
//
//  Created by Yeonluu on 2019/5/6.
//  Copyright © 2019 Yeonluu. All rights reserved.
//

#import "NSString+YLRounding.h"

@implementation NSString (YLRounding)

+ (NSString *)stringFromFloat:(double)aFloat maximumFractionDigits:(NSInteger)maximumFractionDigits {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = maximumFractionDigits;
    formatter.usesGroupingSeparator = NO; // formatRMBPrice不使用分组符号
    formatter.roundingMode = NSNumberFormatterRoundFloor; // 向下取整
    return [formatter stringFromNumber:@(aFloat + 0.000001)]; // 加上 0.000001 消除误差
}

+ (NSString *)stringFromFloat:(double)aFloat {
    return [self stringFromFloat:aFloat maximumFractionDigits:2];
}

+ (NSString *)stringFromPrice:(double)aPrice {
    return [NSString stringWithFormat:@"¥%@", [self stringFromFloat:aPrice]];
}

- (NSString *)floatStringValue {
    return [NSString stringFromFloat:self.doubleValue];
}

- (NSString *)priceStringValue {
    return [NSString stringWithFormat:@"¥%@", self.floatStringValue];
}

@end

