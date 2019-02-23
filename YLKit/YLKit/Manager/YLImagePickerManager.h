//
//  YLImagePickerManager.h
//  YLKit
//
//  Created by Yeonluu on 15/12/10.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PickerSourceType) {
    PickerSourceTypeBothLibraryAndCamera, // 相册、相机
    PickerSourceTypeOnlyLibrary, // 相册
    PickerSourceTypeOnlyCamera,  // 相机
};

@interface YLImagePickerManager : NSObject

/**
 调出图片库/拍照

 @param didFinishPickingBlock 选择结束回调
 @param viewController        当前视图控制器
 */
+ (void)showImagePickerWithAllowsEditing:(BOOL)allowsEditing didFinishPickingBlock:(void (^_Nullable)(UIImage * _Nonnull image))didFinishPickingBlock fromViewController:(UIViewController *_Nullable)viewController;

/**
 调出视频库/拍摄
 
 @param didFinishPickingBlock 选择结束回调
 @param viewController        当前视图控制器
 */
+ (void)showVideoPickerWithDidFinishPickingBlock:(void (^_Nullable)(NSURL * _Nullable filePath))didFinishPickingBlock fromViewController:(UIViewController *_Nullable)viewController;


/**
 调出媒体选择

 @param sourceType            数据源类型
 @param isPickVideo           是否为选择视频
 @param allowsEditing         是否需要裁剪
 @param didFinishPickingBlock 选择结束回调
 @param didCancelBlock        取消动作回调
 @param viewController        当前视图控制器
 */
+ (void)showPickerWithSourceType:(PickerSourceType)sourceType isPickVideo:(BOOL)isPickVideo allowsEditing:(BOOL)allowsEditing didFinishPickingBlock:(void (^_Nullable)(id _Nullable , UIImagePickerController *_Nullable))didFinishPickingBlock didCancelBlock:(void (^_Nullable)(UIImagePickerController *_Nullable))didCancelBlock fromViewController:(UIViewController *_Nullable)viewController;



@end


@interface CodeReaderImagePickerManager : NSObject

+ (void)showImagePickerWithReadSuccessBlock:(void (^_Nullable)(NSString * _Nullable code))readSuccessBlock fromViewController:(UIViewController *_Nullable)viewController;

@end
