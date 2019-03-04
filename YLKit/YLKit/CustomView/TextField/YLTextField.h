//
//  YLTextField.h
//  YLKit
//
//  Created by Yeonluu on 2016/11/22.
//  Copyright © 2016年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 输入类型
 */
typedef NS_ENUM(NSInteger, YLTextType) {
    YLTextTypeDefault,       // 默认
    YLTextTypeName,          // 姓名
    YLTextTypeMobile,        // 手机
    YLTextTypeNumber,        // 数字
    YLTextTypePrice,         // 金额
    YLTextTypeLettersNumber, // 字母数字
    YLTextTypeASCII,         // 字母数字符号不包括空格和中文
    YLTextTypeNone,          // 不需要输入
};

@interface YLTextField : UITextField

/**
 YLTextField 构造方法
 
 @param type        输入类型
 @param fontSize    字体大小
 @param textColor   字体颜色
 @param placeholder 占位文字
 @param title       类型标题 调用isValidText会提示请输入"title"
 */
+ (instancetype)textFieldWithType:(YLTextType)type fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder title:(NSString *)title;

/**
 *  输入类型
 */
@property (nonatomic, assign) YLTextType textType;

/**
 *  最大可输入长度 默认为20 YLTextTypePrice时失效
 */
@property (nonatomic, assign) NSInteger maxTextLength;

/**
 *  最大可输入值  默认为-1，即不限制
 */
@property (nonatomic, assign) CGFloat maxValue;

/**
 *  类型标题 调用isValidText会提示 请输入"title"
 */
@property (nonatomic, copy) NSString *title;

/**
 *  文本输入发生变化回调
 */
@property (nonatomic, copy) void (^textEditingChangeBlock)(NSString *text);
/**
 *  文本输入结束回调
 */
@property (nonatomic, copy) void (^textEditingDidEndBlock)(NSString *text);

/**
 *  是否非必填 允许为空 默认为NO
 */
@property (nonatomic, assign, getter=isEmptyable) BOOL emptyable;

/**
 *  是否为有效文本 无效时会自动提示错误
 */
- (BOOL)isValidText;



/********************** 其他扩展 **********************/

/**
 *  可用状态下的颜色  默认为textColor
 */
@property (nonatomic, strong) UIColor *enabledColor;

/**
 *  不可用状态下的颜色 默认为titleGrayColor
 */
@property (nonatomic, strong) UIColor *disabledColor;

@end
