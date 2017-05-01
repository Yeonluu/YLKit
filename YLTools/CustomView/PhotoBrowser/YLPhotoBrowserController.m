//
//  PhotoBrowser.m
//  PhotoBrower
//
//  Created by Yeonluu on 15/8/8.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLPhotoBrowserController.h"
#import "YLPhotoView.h"

@interface YLPhotoBrowserController () <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) YLPhotoView *enlargePhotoView;
@property (nonatomic, assign) BOOL isLoaded;

@end

@implementation YLPhotoBrowserController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    self.view.frame = CGRectMake(0, -20, width, height);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width+10, height)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.scrollView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 60)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.titleLabel];
    
    
    // 单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    [self.scrollView addGestureRecognizer:singleTap];
    
    // 双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] init];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    // 防止双击进来又退出
    [self performSelector:@selector(viewLoaded) withObject:nil afterDelay:0.8];
}

- (void)viewLoaded
{
    self.isLoaded = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Scrollew Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageIndex = (scrollView.contentOffset.x/ (self.view.bounds.size.width+10) )+0.5;
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", (int)self.pageIndex+1, (int)self.photos.count];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.enlargePhotoView) {
        [self.enlargePhotoView recoveryNormalMode];
    }
}

// 单击事件
- (void)singleTapAction
{
    if (self.isLoaded) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - Public

- (void)setPhotoList:(NSArray *)photos selectedIndex:(NSInteger)index
{
    _photos = photos;
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    self.scrollView.contentSize = CGSizeMake(photos.count * (width+10), height);
    for (int i = 0; i < photos.count; i++) {
        YLPhotoView *photoView = [[YLPhotoView alloc] initWithFrame:CGRectMake((width+10)*i, 0, width, height)];
        if ([photos[i] isKindOfClass:[UIImage class]]) {
            [photoView setPhoto:photos[i]];
        }
        else {
            [photoView setPhotoUrl:photos[i]];
        }
        __weak typeof(self) weakSelf = self;
        photoView.enlargeBlock = ^void(YLPhotoView *view) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.enlargePhotoView = view;
        };
        [self.scrollView addSubview:photoView];
    }
    self.scrollView.contentOffset = CGPointMake((width+10)* index, 0);
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", (int)index+1, (int)photos.count];
}

- (void)setSinglePhoto:(id)photo title:(NSString *)title
{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    YLPhotoView *photoView = [[YLPhotoView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    if ([photo isKindOfClass:[UIImage class]]) {
        [photoView setPhoto:photo];
    }
    else {
        [photoView setPhotoUrl:photo];
    }
    __weak typeof(self) weakSelf = self;
    photoView.enlargeBlock = ^void(YLPhotoView *view) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.enlargePhotoView = view;
    };
    [self.scrollView addSubview:photoView];
    self.scrollView.bounces = NO;
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
}

@end
