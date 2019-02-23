//
//  NSString+Size.h
//  YLKit
//
//  Created by Yeonluu on 15/10/9.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 *  获取文本宽度
 *
 *  @param font   字体
 *  @param height 限制高度
 *
 *  @return 文本宽度
 */
- (CGFloat)getWidthWithFont:(UIFont *)font limitHeight:(CGFloat)height;


/**
 *  获取文本高度
 *
 *  @param font  字体
 *  @param width 限制宽度
 *
 *  @return 文本高度
 */
- (CGFloat)getHeightWithFont:(UIFont *)font limitWidth:(CGFloat)width;


@end

@interface NSAttributedString (Size)

/**
 *  获取文本宽度
 */
- (CGFloat)getWidthWithLimitHeight:(CGFloat)height;


/**
 *  获取文本高度
 */
- (CGFloat)getHeightWithLimitWidth:(CGFloat)width;

@end
