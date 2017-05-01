//
//  YLScoreStarView.m
//  YLTools
//
//  Created by Yeonluu on 15/10/17.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "YLScoreStarView.h"

#define STAR_NUMBER (5)
#define ANIMATION_TIME_DURING (0.2f)

@interface YLScoreStarView ()
{
    NSInteger _currentScore;
}
@property (nonatomic, strong) UIView *foreStarView;
@property (nonatomic, strong) UIView *backStarView;
@property (nonatomic, strong) UIImage *foreStarImage;
@property (nonatomic, strong) UIImage *backStarImage;
@property (nonatomic, assign) BOOL hasInit;

@end

@implementation YLScoreStarView
- (instancetype)init
{
    return [self initWithFrame:CGRectZero numberOfStars:STAR_NUMBER];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStars:STAR_NUMBER];
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStar
{
    if (self = [super initWithFrame:frame]) {
        _totalScore = numberOfStar;
        [self buildDataAndUI];
    }
    return self;
}

- (instancetype)initWithForeStarImage:(NSString *)foreImage backStarImage:(NSString *)backImage
{
    if (self = [self initWithFrame:CGRectZero numberOfStars:STAR_NUMBER]) {
        _foreStarImage = [UIImage imageNamed:foreImage];
        _backStarImage = [UIImage imageNamed:backImage];
    }
    return self;
}

#pragma mark - private

- (void)buildDataAndUI
{
    _hasAnimation = YES;
    _foreStarImage = [UIImage imageNamed:@"YLLightStar"];
    _backStarImage = [UIImage imageNamed:@"YLDarkStar"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.objectEnumerator.allObjects[0];
    
    if (touch.tapCount == 1) {
        CGPoint tapPoint = [touch locationInView:self];
        CGFloat offset = tapPoint.x;
        CGFloat realStarScore = offset / (self.bounds.size.width / self.totalScore);
        self.currentScore = ceilf(realStarScore);
    }
}

- (UIView *)createStarViewWithImage:(UIImage *)image
{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.totalScore; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGFloat width = self.bounds.size.width / self.totalScore;
        imageView.frame = CGRectMake(i * width, 0, width, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    if (!CGRectEqualToRect(frame, CGRectZero) && !self.hasInit) {
        self.foreStarView = [self createStarViewWithImage:_foreStarImage];
        self.backStarView = [self createStarViewWithImage:_backStarImage];
        self.foreStarView.frame = CGRectZero;
        [self addSubview:self.backStarView];
        [self addSubview:self.foreStarView];
        self.hasInit = YES;
    }
    
    if (self.canDetail) {
        CGFloat starW = self.bounds.size.width / self.totalScore;
        CGFloat starH = self.bounds.size.height;
        CGFloat margin = (starW-starH)/2;
        NSInteger wholeScore = floor(self.detailScore);
        CGFloat width = wholeScore*starW+margin+(self.detailScore-wholeScore)*starH;
        self.foreStarView.frame = CGRectMake(0, 0, width, starH);
    }
    else {
        CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_DURING : 0;
        [UIView animateWithDuration:animationTimeInterval animations:^{
            self.foreStarView.frame = CGRectMake(0, 0, self.bounds.size.width * self.currentScore/self.totalScore, self.bounds.size.height);
        }];
    }
}

#pragma mark - Setter
// 设置当前评分
- (void)setCurrentScore:(NSInteger)currentScore
{
    if (_currentScore == currentScore) {
        return;
    }
    _currentScore = currentScore;
    
    
    if (currentScore < 0) {
        _currentScore = 0;
    }
    else if (currentScore > self.totalScore) {
        _currentScore = self.totalScore;
    }
    else {
        _currentScore = currentScore;
    }
    
    if (self.scoreBlock) {
        self.scoreBlock(_currentScore);
    }
    
    [self setNeedsLayout];
}

// 设置详细评分
- (void)setDetailScore:(CGFloat)detailScore
{
    _detailScore = detailScore;
    self.userInteractionEnabled = NO;
    [self setNeedsLayout];
}

@end
