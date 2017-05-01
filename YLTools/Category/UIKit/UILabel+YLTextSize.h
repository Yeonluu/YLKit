//
//  UILabel+YLTextSize.h
//  YLTools
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
 */
- (CGFloat)attributedTextWidth;

/**
 *  单行情况下富文本的高度
 */
- (CGFloat)attributedTextHeight;

/**
 *  指定高度下富文本的宽度
 */
- (CGFloat)attributedTextHeightForWidth:(CGFloat)width;

/**
 *  指定宽度下富文本的高度
 */
- (CGFloat)attributedTextWidthForHeight:(CGFloat)height;

/**
 *  当文本内容超出自身宽度时 自适应字体
 */
- (void)adjustsFontSizeWhenTextExceedWidth;

/**
 *  当文本内容超出自身高度时 自适应字体
 */
- (void)adjustsFontSizeWhenTextExceedHeight;

/**
 *  当富文本内容超出自身宽度时 自适应字体
 */
- (void)adjustsFontSizeWhenAttributedTextExceedWidth;

/**
 *  当富文本内容超出自身高度时 自适应字体
 */
- (void)adjustsFontSizeWhenAttributedTextExceedHeight;

@end
