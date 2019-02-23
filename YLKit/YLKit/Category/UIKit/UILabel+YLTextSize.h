//
//  UILabel+YLTextSize.h
//  YLKit
//
//  Created by Yeonluu on 16/1/8.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YLTextSize)

/**
 *  单行情况下文本宽度
 */
- (CGFloat)textWidth;

/**
 *  单行情况下文本高度
 */
- (CGFloat)textHeight;

/**
 *  单行情况下富文本的宽度
 *  注意设置font
 */
- (CGFloat)attributedTextWidth;

/**
 *  单行情况下富文本的高度
 *  注意设置font
 */
- (CGFloat)attributedTextHeight;

@end
