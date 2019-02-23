//
//  YLImagePickerManager.m
//  YLKit
//
//  Created by Yeonluu on 15/12/10.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLImagePickerManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "YLSingleton.h"

@interface YLImagePickerManager() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 选择媒体结束回调 */
@property (nonatomic, copy) void(^didFinishPickingBlock)(id , UIImagePickerController *);
/** 取消动作结束回调 */
@property (nonatomic, copy) void(^didCancelBlock)(UIImagePickerController *);
/** 是否为选择视频 */
@property (nonatomic, assign) BOOL isPickVideo;

@end
@implementation YLImagePickerManager

SingletonM(Manager)

+ (void)showImagePickerWithAllowsEditing:(BOOL)allowsEditing didFinishPickingBlock:(void (^)(UIImage *))didFinishPickingBlock fromViewController:(UIViewController *)viewController
{
    [self showPickerWithSourceType:PickerSourceTypeBothLibraryAndCamera isPickVideo:NO allowsEditing:allowsEditing didFinishPickingBlock:^(UIImage *image, UIImagePickerController *picker) {
        if (didFinishPickingBlock) {
            didFinishPickingBlock(image);
        }
        picker.delegate = nil;
        [picker dismissViewControllerAnimated:YES completion:nil];
    } didCancelBlock:nil fromViewController:viewController];
}

+ (void)showVideoPickerWithDidFinishPickingBlock:(void (^)(NSURL *))didFinishPickingBlock fromViewController:(UIViewController *)viewController
{
    [self showPickerWithSourceType:PickerSourceTypeBothLibraryAndCamera isPickVideo:YES allowsEditing:YES didFinishPickingBlock:^(NSURL *filePath, UIImagePickerController *picker) {
        if (didFinishPickingBlock) {
            didFinishPickingBlock(filePath);
        }
        picker.delegate = nil;
        [picker dismissViewControllerAnimated:YES completion:nil];
    } didCancelBlock:nil fromViewController:viewController];
}

+ (void)showPickerWithSourceType:(PickerSourceType)sourceType isPickVideo:(BOOL)isPickVideo allowsEditing:(BOOL)allowsEditing didFinishPickingBlock:(void (^)(id, UIImagePickerController *))didFinishPickingBlock didCancelBlock:(void (^)(UIImagePickerController *))didCancelBlock fromViewController:(UIViewController *)viewController
{
    YLImagePickerManager *manager = [YLImagePickerManager sharedManager];
    manager.didFinishPickingBlock = didFinishPickingBlock;
    manager.didCancelBlock = didCancelBlock;
    manager.isPickVideo = isPickVideo;

    if (sourceType == PickerSourceTypeBothLibraryAndCamera ) {
        UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [sheetController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [manager presentPickerWithIsCamera:NO allowsEditing:allowsEditing fromViewController:viewController];
        }]];
        [sheetController addAction:[UIAlertAction actionWithTitle:isPickVideo?@"拍摄":@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [manager presentPickerWithIsCamera:YES allowsEditing:allowsEditing fromViewController:viewController];
        }]];
        [sheetController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [viewController presentViewController:sheetController animated:YES completion:nil];
    }
    else if (sourceType == PickerSourceTypeOnlyLibrary) {
        [manager presentPickerWithIsCamera:NO allowsEditing:allowsEditing fromViewController:viewController];
    }
    else {
        [manager presentPickerWithIsCamera:YES allowsEditing:allowsEditing fromViewController:viewController];
    }
}

- (UIImagePickerController *)presentPickerWithIsCamera:(BOOL)isCamera allowsEditing:(BOOL)allowsEditing fromViewController:(UIViewController *)viewController
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    if (isCamera) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            NSLog(@"设备不支持拍摄");
            return nil;
        }
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else {
            pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
    if (self.isPickVideo) {
        pickerController.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeVideo];
        pickerController.videoMaximumDuration = 15.0;
        pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }
    
    pickerController.delegate = self;
    pickerController.allowsEditing = allowsEditing;
    [viewController presentViewController:pickerController animated:YES completion:nil];
    return pickerController;
}

#pragma mark - UIImagePicker Delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.didFinishPickingBlock) {
        if (self.isPickVideo) {
            NSURL *fileURL = [info objectForKey:UIImagePickerControllerMediaURL];
            self.didFinishPickingBlock(fileURL, picker);
        }
        else {
            UIImage *pickedImage = [info objectForKey:picker.allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
            pickedImage = [self compressImage:pickedImage];
            if (!pickedImage) {
                NSLog(@"选取图片失败，请重试");
                return;
            }
            self.didFinishPickingBlock(pickedImage, picker);
        }
    }
    else {
        picker.delegate = nil;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIImage *)compressImage:(UIImage *)image {
//    NSLog(@"压缩前：%.2fMB", UIImagePNGRepresentation(image).length/1024.f/1024.f);
    if (image.size.width < 1125) {
        return image;
    }
    CGSize size = CGSizeMake(1125, image.size.height/image.size.width*1125);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    NSLog(@"压缩后：%.2fMB", UIImagePNGRepresentation(resultImage).length/1024.f/1024.f);
    return resultImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    picker.delegate = nil;
    if (self.didCancelBlock) {
        self.didCancelBlock(picker);
        self.didCancelBlock = nil;
    }
    else {
        [picker dismissViewControllerAnimated:YES completion:nil];
        self.didFinishPickingBlock = nil;
    }
}
@end


@implementation UIImagePickerController (statusBar)

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    NSLog(@"dealloc: %@\n", self);
}

@end
