//
//  NSArray+YLSafeObject.h
//  YLKit
//
//  Created by Yeonluu on 16/4/14.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSArray (YLSafeObject)

/**
 *  避免数组越界导致奔溃
 */
- (id)safeObejctAtIndex:(NSUInteger)index;

/**
 *  获取NSInteger值
 */
- (NSInteger)integerAtIndex:(NSUInteger)index;

/**
 *  获取CGFloat值
 */
- (CGFloat)floatAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (SafeObject)

/**
 *  避免添加nil导致奔溃
 */
- (void)safeAddObejct:(id)anObejct;

/**
 *  避免插入nil导致奔溃
 */
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

@end
