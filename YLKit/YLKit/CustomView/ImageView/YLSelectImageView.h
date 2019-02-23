//
//  YLSelectImageView.h
//  YLKit
//
//  Created by Yeonluu on 2017/6/21.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLSelectImageView : UIImageView

/**
 构造方法 创建带选中样式的图片控件
 
 @param named 本地图片名
 @param selectedNamed 选中图片名
 */
+ (instancetype)imageNamed:(NSString *)named selectedNamed:(NSString *) selectedNamed;

/**
 构造方法 创建带选中样式的图片控件
 
 @param named 本地图片名
 @param selectedNamed 选中图片名
 */
- (instancetype)initWithImageNamed:(NSString *)named selectedNamed:(NSString *) selectedNamed;

/**
 普通状态的图片
 */
@property (nonatomic, strong) UIImage *normalImage;

/**
 选中状态的图片
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 是否选中
 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end
