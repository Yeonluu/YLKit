//
//  NSObject+YLJSON.m
//  YLKit
//
//  Created by Yeonluu on 15/12/29.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "NSObject+YLJSON.h"

@implementation NSObject (YLJSON)

- (NSString *)JSONString
{
    if (![NSJSONSerialization isValidJSONObject:self]) {
        NSLog(@"不是有效的JSON Object");
        return nil;
    }
    
    NSError *__autoreleasing error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    
    if (error != nil) return nil;
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
