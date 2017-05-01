//
//  YLTextField.h
//  YLTools
//
//  Created by Yeonluu on 2016/11/22.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YLTextType) {
    YLTextTypeDefault,            // 默认
    YLTextTypeName,               // 姓名
    YLTextTypeMobile,             // 手机
    YLTextTypeNumber,             // 数字
    YLTextTypePrice,              // 金额
    YLTextTypeLettersNumber,      // 字母&数字
};

@interface YLTextField : UITextField


/**
 构造方法

 @param type        输入类型
 @param fontSize    字体大小
 @param textColor   字体颜色
 @param placeholder 占位文字
 @param title       类型标题 调用isValidText会提示请输入"title"
 */
- (instancetype)initWithType:(YLTextType)type fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder title:(NSString *)title;

+ (instancetype)textFieldWithType:(YLTextType)type fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder title:(NSString *)title;

/**
 *  输入类型
 */
@property (nonatomic, assign) YLTextType type;

/**
 *  最大可输入长度 默认为20 YLTextTypePrice时失效
 */
@property (nonatomic, assign) NSUInteger maxTextLength;

/**
 *  最大可输入金额 YLTextTypePrice时有效 默认为200000
 */
@property (nonatomic, assign) CGFloat maxPriceAmount;

/**
 *  类型标题 调用isValidText会提示 请输入"title"
 */
@property (nonatomic, copy) NSString *title;

/**
 *  文本输入发生变化回调
 */
@property (nonatomic, copy) void (^textEditingChangedBlock)(NSString *text);

/**
 *  是否关闭空串校验 默认为NO
 */
@property (nonatomic, assign, getter=isCloseEmptyVerify) BOOL closeEmptyVerify;

/**
 *  是否为有效文本
 */
- (BOOL)isValidText;


/********************** 其他扩展 **********************/

/**
 *  可用状态下的颜色  一般用不着
 */
@property (nonatomic, strong) UIColor *enabledColor;

/**
 *  不可用状态下的颜色 一般用不着 默认为titleGrayColor
 */
@property (nonatomic, strong) UIColor *disabledColor;

@end
