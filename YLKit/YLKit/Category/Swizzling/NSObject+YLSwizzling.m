//
//  NSObject+YLSwizzling.m
//  YLKit
//
//  Created by Yeonluu on 2017/3/9.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//  此文件需MRC管理 否则iOS10以下系统在弹出软键盘时按下home键会奔溃 -fno-objc-arc

#import "NSObject+YLSwizzling.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSObject (YLSwizzling)

@end

@implementation NSArray (YLSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSArray0") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:) error:nil];
            [objc_getClass("__NSSingleObjectArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:) error:nil];
            [objc_getClass("__NSArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:) error:nil];
            [objc_getClass("__NSArrayI") jr_swizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(safeObjectAtIndexedSubscript:) error:nil];
            [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:) error:nil];
            [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:) error:nil];
            [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(removeObjectsInRange:) withMethod:@selector(safeRemoveObjectsInRange:) error:nil];
        }
    });
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    @autoreleasepool {
        if (index >= self.count) {
            @try {
                return [self safeObjectAtIndexedSubscript:index];
            } @catch (NSException *exception) {
                // to report exception
                // [Bugly reportException:exception];
                return nil;
            } @finally {
                
            }
            return nil;
        }
        else {
            return [self safeObjectAtIndexedSubscript:index];
        }
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    @autoreleasepool {
        if (index >= self.count) {
            @try {
                return [self safeObjectAtIndex:index];
            } @catch (NSException *exception) {
                // to report exception
                // [Bugly reportException:exception];
                return nil;
            } @finally {
                
            }
            return nil;
        }
        else {
            return [self safeObjectAtIndex:index];
        }
    }
}

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index
{
    @autoreleasepool {
        if (!object) {
            @try {
                [self safeInsertObject:object atIndex:index];
            } @catch (NSException *exception) {
                // to report exception
                // [Bugly reportException:exception];
                [self safeInsertObject:@"" atIndex:index];
            } @finally {
                
            }
        }
        else {
            [self safeInsertObject:object atIndex:index];
        }
    }
}

- (void)safeRemoveObjectsInRange:(NSRange)range
{
    @autoreleasepool {
        if (range.location+range.length > self.count) {
            @try {
                [self safeRemoveObjectsInRange:range];
            } @catch (NSException *exception) {
                // to report exception
                // [Bugly reportException:exception];
            } @finally {
                
            }
        }
        else {
            [self safeRemoveObjectsInRange:range];
        }
    }
}

@end


@implementation NSDictionary (Swizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(safeSetObject:forKey:) error:nil];
        }
    });
}

- (void)safeSetObject:(id)object forKey:(NSString *)key
{
    @autoreleasepool {
        if (!object) {
            @try {
                [self safeSetObject:object forKey:key];
            } @catch (NSException *exception) {
                // to report exception
                // [Bugly reportException:exception];
                [self safeSetObject:@"" forKey:key];
            } @finally {
                
            }
        }
        else {
            [self safeSetObject:object forKey:key];
        }
    }
}

@end
