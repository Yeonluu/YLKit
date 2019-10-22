//
//  UITableView+YLRegister.h
//  YLKit
//
//  Created by Yeonluu on 2017/5/26.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YLRegister)

/**
 快速创建默认tableView
 */
- (nullable instancetype)initWithDelegate:(nullable id <UITableViewDelegate>)delegate dataSource:(nullable id <UITableViewDataSource>)dataSource;

/**
 快速创建分组tableView
 */
- (nullable instancetype)initWithGroupedDelegate:(nullable id <UITableViewDelegate>)delegate dataSource:(nullable id <UITableViewDataSource>)dataSource;

/**
 快速注册cell

 @param cellClass cell类型
 */
- (void)registerCellClass:(nullable Class)cellClass;

/**
 批量注册cell

 @param cellClasses cell类型列表
 */
- (void)registerCellClasses:(nullable NSArray *)cellClasses;

/**
 快速注册HeaderFooterView
 
 @param viewClass HeaderFooterView类型
 */
- (void)registerHeaderFooterViewClass:(nullable Class)viewClass;

/**
 批量注册HeaderFooterView

 @param viewClasses HeaderFooterView类型列表
 */
- (void)registerHeaderFooterViewClasses:(nullable NSArray *)viewClasses;

/**
 获取可复用的cell
 
 @param cellClass cell类型
 @param indexPath 索引
 */
- (nullable __kindof UITableViewCell *)dequeueReusableCellWithClass:(nullable Class)cellClass forIndexPath:(nullable NSIndexPath *)indexPath;

/**
 获取可复用的HeaderFooterView
 
 @param viewClass HeaderFooterView类型
 */
- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(nullable Class)viewClass;

@end

