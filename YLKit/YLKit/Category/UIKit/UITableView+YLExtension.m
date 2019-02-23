//
//  UITableView+YLExtension.m
//  YLKit
//
//  Created by Yeonluu on 2017/5/26.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "UITableView+YLExtension.h"

@implementation UITableView (YLExtension)

- (instancetype)initWithDelegate:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>)dataSource
{
    if (self = [self initWithFrame:CGRectZero style:UITableViewStylePlain]) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        [self setupTableView];
    }
    return self;
}

- (instancetype)initWithGroupedDelegate:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>)dataSource
{
    if (self = [self initWithFrame:CGRectZero style:UITableViewStyleGrouped]) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.rowHeight = 44;

    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}


- (void)registerCellClass:(nullable Class)cellClass
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerCellClasses:(nullable NSArray *)cellClasses
{
    for (Class class in cellClasses) {
        [self registerCellClass:class];
    }
}

- (void)registerHeaderFooterViewClass:(nullable Class)viewClass
{
    [self registerClass:viewClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)registerHeaderFooterViewClasses:(nullable NSArray *)viewClasses
{
    for (Class class in viewClasses) {
        [self registerHeaderFooterViewClass:class];
    }
}

- (nullable __kindof UITableViewCell *)dequeueReusableCellWithClass:(nullable Class)cellClass forIndexPath:(nullable NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(nullable Class)viewClass
{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(viewClass)];
}

@end


@implementation UICollectionView (YLExtension)

- (instancetype)initWithLayout:(UICollectionViewLayout *)layout delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource
{
    if (self = [self initWithFrame:CGRectZero collectionViewLayout:layout]) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)registerCellClass:(nullable Class)cellClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerCellClasses:(nullable NSArray *)cellClasses
{
    for (Class class in cellClasses) {
        [self registerCellClass:class];
    }
}

- (void)registerHeaderViewClass:(nullable Class)viewClass
{
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)registerFooterViewClass:(nullable Class)viewClass
{
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(viewClass)];
}

- (nullable __kindof UICollectionViewCell *)dequeueReusableCellWithClass:(nullable Class)cellClass forIndexPath:(nullable NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (nullable __kindof UICollectionReusableView *)dequeueReusableHeaderViewWithClass:(nullable Class)viewClass forIndexPath:(nullable NSIndexPath *)indexPath
{
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(viewClass) forIndexPath:indexPath];
}

- (nullable __kindof UICollectionReusableView *)dequeueReusableFooterViewWithClass:(nullable Class)viewClass forIndexPath:(nullable NSIndexPath *)indexPath
{
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(viewClass) forIndexPath:indexPath];
}


@end


@implementation NSIndexPath (RowItem)

+ (nullable instancetype)indexPathForRow:(NSInteger)row
{
    return [self indexPathForRow:row inSection:0];
}

+ (nullable instancetype)indexPathForItem:(NSInteger)item
{
    return [self indexPathForItem:item inSection:0];
}

@end
