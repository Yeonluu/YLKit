//  NSString+YLRegex.m
//  YLTools
//
//  Created by Yeonluu on 15/12/5.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "NSString+YLRegex.h"

@implementation NSString (YLRegex)

- (BOOL)match:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isMobile
{
    NSString * phoneRegex = @"^(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
    return [self match:phoneRegex];
}


-(BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self match:emailRegex];
}

- (BOOL)isNumber
{
    NSString *numberReg = @"^[0-9]*$";
    return [self match:numberReg];
}

- (NSString *)formatMobile
{
    if (!self) return @"";
    
    NSInteger length = self.length;
    if (length <= 3) return self;
    
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *str = [NSMutableString string];

    
    for (int i = 0; i < result.length; ++i) {
        if (i == 3 || i == 7) {
            [str appendString:@" "];
        }
        [str appendFormat:@"%c", [result characterAtIndex:i]];
    }
    
    return str;
}

- (NSString *)clearWhiteSpace
{
    NSString *result;
    NSString *reg = @"\\s*";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:reg options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        result = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    }
    return result;
}

@end
