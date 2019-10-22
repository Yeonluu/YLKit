//
//  NSArray+YLSafeObject.m
//  YLKit
//
//  Created by Yeonluu on 16/4/14.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import "NSArray+YLSafeObject.h"

@implementation NSArray (YLSafeObject)


- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}


- (NSInteger)safe_integerAtIndex:(NSUInteger)index
{
    return [[self safe_objectAtIndex:index] integerValue];
}


- (CGFloat)safe_floatAtIndex:(NSUInteger)index
{
    return [[self safe_objectAtIndex:index] doubleValue];
}


@end


@implementation NSMutableArray (SafeObject)


- (void)safe_addObject:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
}


@end

