//
//  PhotoBrowser.h
//  PhotoBrower
//
//  Created by Yeonluu on 15/8/8.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPhotoBrowserController : UIViewController

/**
 *  传入图片列表
 *
 *  @param photos 图片/地址/图片+地址
 *  @param index  默认显示的页码
 */
- (void)setPhotoList:(NSArray *)photos selectedIndex:(NSInteger)index;

/**
 *  传入单个图片
 *
 *  @param photo  图片/地址
 *  @param title  标题
 */
- (void)setSinglePhoto:(id)photo title:(NSString *)title;

@end
