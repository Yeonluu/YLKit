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
- (id)safe_objectAtIndex:(NSUInteger)index;

/**
 *  获取NSInteger值
 */
- (NSInteger)safe_integerAtIndex:(NSUInteger)index;

/**
 *  获取CGFloat值
 */
- (CGFloat)safe_floatAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (SafeObject)

/**
 *  避免添加nil导致奔溃
 */
- (void)safe_addObject:(id)anObject;

/**
 *  避免插入nil导致奔溃
 */
- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index;

@end
