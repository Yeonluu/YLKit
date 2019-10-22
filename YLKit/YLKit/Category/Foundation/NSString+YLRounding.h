//
//  NSString+YLRounding.h
//  YLKit
//
//  Created by Yeonluu on 2019/5/6.
//  Copyright © 2019 Yeonluu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSStringFromFloat(aFloat) [NSString stringFromFloat:aFloat]
#define NSStringFromPrice(aPrice) [NSString stringFromPrice:aPrice]

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YLRounding)

/**
 移除小数点后多余的0
 
 @param aFloat 数值
 @param maximumFractionDigits 精度位数
 @return 1.100 -> 1.10/1.1
 */
+ (NSString *)stringFromFloat:(double)aFloat maximumFractionDigits:(NSInteger)maximumFractionDigits;

/**
 移除小数点后多余的0
 
 @param aFloat 数值
 @return 1.100 -> 1.1
 */
+ (NSString *)stringFromFloat:(double)aFloat;

/**
 移除小数点后多余的0，拼接¥
 
 @param aPrice 金额数值
 @return 1.100 -> ¥1.1
 */
+ (NSString *)stringFromPrice:(double)aPrice;

/**
 移除小数点后多余的0
 
 @return 1.100 -> 1.1
 */
- (NSString *)floatStringValue;

/**
 移除小数点后多余的0，拼接¥
 
 @return 1.100 -> ¥1.1
 */
- (NSString *)priceStringValue;

@end

NS_ASSUME_NONNULL_END
