//
//  YLImagePickerManager.h
//  YLTools
//
//  Created by Yeonluu on 15/12/10.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YLImagePickerManagerSourceType) {
    YLImagePickerManagerSourceTypeBothPhotosAndCamera,
    YLImagePickerManagerSourceTypeOnlyPhotos,
    YLImagePickerManagerSourceTypeOnlyCamera,
};

@interface YLImagePickerManager : NSObject


/**
 调出相册/相机

 @param didFinishEditingBlock 选择照片裁剪结束回调
 @param viewController        当前视图控制器
 */
+ (void)showPickerWithDidFinishEditingBlock:(void (^)(UIImage *editedImage))didFinishEditingBlock fromViewController:(UIViewController *)viewController;


/**
 调出图片选择

 @param sourceType            图片源类型
 @param allowsEditing         是否需要裁剪
 @param didFinishPickingBlock 选择照片结束回调
 @param didCancelBlock        取消动作回调
 @param viewController        当前视图控制器
 */
+ (void)showPickerWithSourceType:(YLImagePickerManagerSourceType)sourceType allowsEditing:(BOOL)allowsEditing didFinishPickingBlock:(void (^)(UIImage *pickedImage, UIImagePickerController *))didFinishPickingBlock didCancelBlock:(void (^) (UIImagePickerController *))didCancelBlock fromViewController:(UIViewController *)viewController;

@end
