//
//  PhotoView.h
//  PhotoBrower
//
//  Created by Yeonluu on 15/8/8.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLPhotoView;
typedef void(^EnlargeBlock)(YLPhotoView *view);

@interface YLPhotoView : UIScrollView

@property (nonatomic, copy) EnlargeBlock enlargeBlock;
- (void)setPhotoUrl:(NSURL *)url;
- (void)setPhoto:(UIImage *)photo;
- (void)recoveryNormalMode;

@end
