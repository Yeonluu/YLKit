//
//  YLScoreStarView.h
//  YLTools
//
//  Created by Yeonluu on 15/10/17.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLScoreStarView : UIView

/** 总分，默认为5 */
@property (nonatomic, assign) NSInteger totalScore;
/** 当前评分，默认为0 */
@property (nonatomic, assign) NSInteger currentScore;
/** 是否允许动画，默认为YES */
@property (nonatomic, assign) BOOL hasAnimation;

/** 是否开启详细计分， 默认为NO */
@property (nonatomic, assign) BOOL canDetail;
/** 详细评分，允许小数 */
@property (nonatomic, assign) CGFloat detailScore;

@property (nonatomic, copy) void(^scoreBlock)(NSInteger score);


/**
 构造方法

 @param frame        位置
 @param numberOfStar 星星数量
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStar;


/**
 构造方法

 @param foreImage 亮星图片
 @param backImage 暗星图片
 */
- (instancetype)initWithForeStarImage:(NSString *)foreImage backStarImage:(NSString *)backImage;

@end
