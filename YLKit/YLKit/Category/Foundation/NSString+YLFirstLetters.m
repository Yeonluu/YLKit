//
//  NSString+YLFirstLetters.m
//  YLKit
//
//  Created by Yeonluu on 2017/6/13.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "NSString+YLFirstLetters.h"
#import "NSString+YLCheck.h"
#import <objc/runtime.h>

NSString * const firstLettersKey = @"firstLettersKey";

@implementation NSString (YLFirstLetters)

- (void)setFirstLetters:(NSString *)firstLetters {
    objc_setAssociatedObject(self, &firstLettersKey, firstLetters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)firstLetters {
    
    NSString *firstLetters = objc_getAssociatedObject(self, &firstLettersKey);
    if (!firstLetters) {
        NSMutableString *letters = [NSMutableString string];
        
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                  [letters appendString:[substring firstLetter]];
                              }];
        firstLetters = letters;
        self.firstLetters = letters;
    }
    
    return firstLetters;
}


#pragma mark - 首字母

- (NSString *)firstLetter
{
    if (self.isChinese) {
        // 转成了可变字符串
        NSMutableString *str = [NSMutableString stringWithString:self];
        // 先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
        // 再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
        // 获取并返回首字母
        return [str substringToIndex:1];
    }
    else if ([self isEqualToString:@" "]) {
        return @"";
    }
    else {
        return self;
    }
    
}


@end
