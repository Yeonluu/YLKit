//
//  NSString+YLCheck.m
//  YLKit
//
//  Created by Yeonluu on 15/10/21.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "NSString+YLCheck.h"

@implementation NSString (YLCheck)


- (BOOL)isEmoji
{
    // 用于支持九宫格输入
    if ([@"➊➋➌➍➎➏➐➑➒" containsString:self]) {
        return NO;
    }
    const unichar high = [self characterAtIndex: 0];
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

- (BOOL)containsEmoji
{
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}


- (NSString *)deleteEmoji
{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    return buffer;
}

- (BOOL)isChinese
{
    NSString * chineseRegex = @"(^[\u4E00-\u9FA5]+$)";
    return [self match:chineseRegex];
}

- (BOOL)containsChinese
{
    for(int i = 0; i< self.length; i++) {
        unichar a = [self characterAtIndex:i];
        if( a >0x4E00 && a <0x9FA5) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)deleteChinese
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4E00-\u9FA5]+$" options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    }
    return self;
}

- (BOOL)containsChineseAndSpace
{
    for(int i = 0; i< self.length; i++) {
        unichar a = [self characterAtIndex:i];
        if( (a >0x4E00 && a <0x9FA5) || a == 0x0020) {
            return YES;
        }
    }
    return NO;
}


- (NSString *)deleteChineseAndSpace
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4E00-\u9FA5]+$|\\s*" options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    }
    return self;
}

#pragma mark - Space

- (NSString *)deleteSpace
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s*" options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    }
    return self;
}


#pragma mark - Mobile

- (BOOL)isMobile
{
    if (self.length != 11) {
        return NO;
    }
    NSString *phoneRegex = @"^(1)[0-9]{10}$";
    return [self match:phoneRegex];
}

- (BOOL)isErrorMobile
{
    if (![self isMobile]) {
        NSLog(@"请输入正确的11位手机号");
        return YES;
    }
    return NO;
}

- (NSString *)formatMobile
{
    NSInteger length = self.length;

    if (length < 3) {
        return self;
    }
    if (length == 3) {
        return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableString *newMobile = [NSMutableString stringWithString:result];
    
    [newMobile insertString:@" " atIndex:3];
    
    if (newMobile.length > 8) {
        [newMobile insertString:@" " atIndex:8];
    }

    return newMobile;
}


#pragma mark - Other

- (BOOL)isPirce
{
    NSRange pointRange = [self rangeOfString:@"."];
    
    if (pointRange.length) { // 有小数点
        NSString *decimalString = [self substringFromIndex:pointRange.location+1];
        if ([decimalString containsString:@"."]) { // 有两个小数点
            return NO;
        }
        else if (decimalString.length > 2) { // 有超过两位小数
            return NO;
        }
    }
    return self.length <= 10;
}

- (BOOL)isOneDecimal
{
    NSRange pointRange = [self rangeOfString:@"."];
    
    if (pointRange.length) { // 有小数点
        NSString *decimalString = [self substringFromIndex:pointRange.location+1];
        if ([decimalString containsString:@"."]) { // 有两个小数点
            return NO;
        }
        else if (decimalString.length > 1) { // 有超过一位小数
            return NO;
        }
    }
    return self.length <= 10;
}

- (BOOL)isNumber
{
    NSString *numberReg = @"^[0-9]*$";
    return [self match:numberReg];
}

- (BOOL)isLettersNumber
{
    NSString *LettersNumberReg = @"^([0-9]|[a-z]|[A-Z])*$";
    return [self match:LettersNumberReg];
}

- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self match:emailRegex];
}

#pragma mark - Helper

- (BOOL)match:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}


@end
