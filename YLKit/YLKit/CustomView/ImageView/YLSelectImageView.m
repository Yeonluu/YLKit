//
//  YLSelectImageView.m
//  YLKit
//
//  Created by Yeonluu on 2017/6/21.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "YLSelectImageView.h"

@implementation YLSelectImageView

- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        self.normalImage = image;
    }
    return self;
}

+ (instancetype)imageNamed:(NSString *)named selectedNamed:(NSString *)selectedNamed
{
    return [[self alloc] initWithImageNamed:named selectedNamed:selectedNamed];
}

- (instancetype)initWithImageNamed:(NSString *)named selectedNamed:(NSString *) selectedNamed
{
    if (self = [super init]) {
        self.normalImage = [UIImage imageNamed:named];
        self.selectedImage = [UIImage imageNamed:selectedNamed];
        self.image = self.normalImage;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.image = selected ? self.selectedImage : self.normalImage;
}

@end
