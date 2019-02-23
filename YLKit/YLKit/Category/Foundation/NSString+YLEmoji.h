//
//  NSString+YLEmoji.h
//  YLKit
//
//  Created by Yeonluu on 15/10/21.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YLEmoji)

/**
 *  字符是否为emoji
 */
- (BOOL)isEmoji;

/**
 *  字符串是否含有emoji
 */
- (BOOL)containsEmoji;

/**
 *  删除字符串中的emoji
 */
- (NSString *)deleteEmoji;

@end
