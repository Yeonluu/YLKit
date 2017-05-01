//
//  YLImagePickerManager.m
//  YLTools
//
//  Created by Yeonluu on 15/12/10.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLImagePickerManager.h"
#import "YLSingleton.h"

@interface YLImagePickerManager() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/** 选择照片结束回调 */
@property (nonatomic, copy) void(^didFinishPickingBlock)(UIImage *, UIImagePickerController *);
/** 取消动作结束回调 */
@property (nonatomic, copy) void(^didCancelBlock)(UIImagePickerController *);

@end

@implementation YLImagePickerManager

SingletonM(Manager)

+ (void)showPickerWithDidFinishEditingBlock:(void (^)(UIImage *))didFinishEditingBlock fromViewController:(UIViewController *)viewController
{
    [self showPickerWithSourceType:YLImagePickerManagerSourceTypeBothPhotosAndCamera allowsEditing:YES didFinishPickingBlock:^(UIImage *editedImage, UIImagePickerController *picker) {
        if (didFinishEditingBlock) {
            didFinishEditingBlock(editedImage);
        }
        picker.delegate = nil;
        [picker dismissViewControllerAnimated:YES completion:nil];
    } didCancelBlock:nil fromViewController:viewController];
}

+ (void)showPickerWithSourceType:(YLImagePickerManagerSourceType)sourceType allowsEditing:(BOOL)allowsEditing didFinishPickingBlock:(void (^)(UIImage *, UIImagePickerController *))didFinishPickingBlock didCancelBlock:(void (^) (UIImagePickerController *))didCancelBlock fromViewController:(UIViewController *)viewController
{
    YLImagePickerManager *manager = [YLImagePickerManager sharedManager];
    manager.didFinishPickingBlock = didFinishPickingBlock;
    manager.didCancelBlock = didCancelBlock;

    if (sourceType == YLImagePickerManagerSourceTypeOnlyPhotos) {
        [manager presentPhotosPickerWithAllowsEditing:allowsEditing fromViewController:viewController];
    }
    else if (sourceType == YLImagePickerManagerSourceTypeOnlyCamera) {
        [manager presentCameraPickerWithAllowsEditing:allowsEditing fromViewController:viewController];
    }
    else {
        UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [sheetController addAction: [UIAlertAction actionWithTitle:@"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [manager presentCameraPickerWithAllowsEditing:allowsEditing fromViewController:viewController];
        }]];
        [sheetController addAction: [UIAlertAction actionWithTitle:@"从相册选择" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [manager presentPhotosPickerWithAllowsEditing:allowsEditing fromViewController:viewController];
        }]];
        [sheetController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
        [viewController presentViewController:sheetController animated:YES completion:nil];
    }
}


// 推出相册页面
- (UIImagePickerController *)presentPhotosPickerWithAllowsEditing:(BOOL)allowsEditing fromViewController:(UIViewController *)viewController
{
    UIImagePickerControllerSourceType sourceType;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else {
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = allowsEditing;
    [viewController presentViewController:imagePickerController animated:YES completion:nil];
    return imagePickerController;
}

// 推出相机页面
- (UIImagePickerController *)presentCameraPickerWithAllowsEditing:(BOOL)allowsEditing fromViewController:(UIViewController *)viewController
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        NSLog(@"%@", @"设备不支持拍摄");
        return nil;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = allowsEditing;
    [viewController presentViewController:imagePickerController animated:YES completion:nil];
    return imagePickerController;
}

#pragma mark - UIImagePicker Delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.didFinishPickingBlock) {
        UIImage *pickedImage = [info objectForKey:picker.allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
        self.didFinishPickingBlock(pickedImage, picker);
    }
    else {
        picker.delegate = nil;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.didCancelBlock) {
        self.didCancelBlock(picker);
    }
    else {
        picker.delegate = nil;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
    if ([navigationController isKindOfClass:[UIImagePickerController class]] && ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

@end
