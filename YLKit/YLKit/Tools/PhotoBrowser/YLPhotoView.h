//
//  YLPhotoView.h
//  YLKit
//
//  Created by Yeonluu on 15/8/8.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLPhotoView;
typedef void(^EnlargeBlock)(YLPhotoView *view);

@interface YLPhotoView : UIScrollView

/**
 双击放大事件回调
 */
@property (nonatomic, copy) EnlargeBlock enlargeBlock;

/**
 设置图片

 @param photo UIImage/NSURL/NSString
 */
- (void)setPhoto:(id)photo;

/**
 恢复普通状态
 */
- (void)recoveryNormalMode;

@end
