//
//  NSArray+YLSafeObject.m
//  YLKit
//
//  Created by Yeonluu on 16/4/14.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "NSArray+YLSafeObject.h"

@implementation NSArray (YLSafeObject)


- (id)safeObejctAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}


- (NSInteger)integerAtIndex:(NSUInteger)index
{
    return [[self safeObejctAtIndex:index] integerValue];
}


- (CGFloat)floatAtIndex:(NSUInteger)index
{
    return [[self safeObejctAtIndex:index] doubleValue];
}


@end


@implementation NSMutableArray (SafeObject)


- (void)safeAddObejct:(id)anObejct
{
    if (anObejct) {
        [self addObject:anObejct];
    }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
}


@end

