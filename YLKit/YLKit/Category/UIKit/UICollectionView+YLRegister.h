//
//  UITableView+YLRegister.h
//  YLKit
//
//  Created by Yeonluu on 2017/5/26.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (YLRegister)

/**
 快速创建默认collectionView
 */
- (nullable instancetype)initWithLayout:(nullable UICollectionViewLayout *)layout delegate:(nullable id<UICollectionViewDelegate>)delegate dataSource:(nullable id<UICollectionViewDataSource>)dataSource;

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
 快速注册SectionHeaderView
 
 @param viewClass HeaderView类型
 */
- (void)registerHeaderViewClass:(nullable Class)viewClass;

/**
 快速注册SectionFooterView
 
 @param viewClass FooterView类型
 */
- (void)registerFooterViewClass:(nullable Class)viewClass;

/**
 获取可复用的cell
 
 @param cellClass cell类型
 @param indexPath 索引
 */
- (nullable __kindof UICollectionViewCell *)dequeueReusableCellWithClass:(nullable Class)cellClass forIndexPath:(nullable NSIndexPath *)indexPath;

/**
 获取可复用的SectionHeaderView
 
 @param viewClass HeaderView类型
 @param indexPath 索引
 */
- (nullable __kindof UICollectionReusableView *)dequeueReusableHeaderViewWithClass:(nullable Class)viewClass forIndexPath:(nullable NSIndexPath *)indexPath;

/**
 获取可复用的SectionFooterView
 
 @param viewClass FooterView类型
 @param indexPath 索引
 */
- (nullable __kindof UICollectionReusableView *)dequeueReusableFooterViewWithClass:(nullable Class)viewClass forIndexPath:(nullable NSIndexPath *)indexPath;


@end


@interface NSIndexPath (RowItem)


/**
 快速创建section为0的indexPath
 */
+ (nullable instancetype)indexPathForRow:(NSInteger)row;

/**
 快速创建section为0的indexPath
 */
+ (nullable instancetype)indexPathForItem:(NSInteger)item;

@end

