//
//  UITableView+YLRegister.m
//  YLKit
//
//  Created by Yeonluu on 2017/5/26.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import "UITableView+YLRegister.h"

@implementation UITableView (YLRegister)

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
