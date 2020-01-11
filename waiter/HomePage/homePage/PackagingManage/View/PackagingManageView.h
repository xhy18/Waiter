//
//  PackagingManageView.h
//  waiter
//
//  Created by ltl on 2019/7/12.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packageManage.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PackagingManageViewDelegte <NSObject>

/**
 * 给controller提供一个打包单号
 * @param orderType 订单类型 0：未打包订单 1：历史订单
 * @param packageNum 单号
 */
- (void)orderType:(NSString *)orderType packageId:(NSString *)packageNum;

/**
 * 下拉刷新，-1 未完成table，1 已完成table
 */
- (void)newData:(int)table;

/**
 * 上拉加载，-1 未完成table，1 已完成table
 */
- (void)moreData:(int)table;

@end


@interface PackagingManageView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

//未完成按钮
@property(nonatomic, strong) UIButton *notCompleteBtn;
//已完成按钮
@property(nonatomic, strong) UIButton *completeBtn;
//滚动视图
@property(nonatomic, strong) UIScrollView *manageScroll;
//滚动下划线
@property(nonatomic, strong) UILabel *underLine;
//未完成table
@property(nonatomic, strong) UITableView *notCompleteTable;
//已完成table
@property(nonatomic, strong) UITableView *completeTable;


//未打包订单列表
@property(nonatomic, strong) NSMutableArray<packageManage *> *packageArray;
//已打包订单列表
@property(nonatomic, strong) NSMutableArray<packageManage *> *hasPackageArray;

//代理
@property(nonatomic, weak) id<PackagingManageViewDelegte> delegate;
//assign,防止循环引用

//结束table刷新动画
- (void)endFreshHeader:(UITableView *)table;
- (void)endFreshFooter:(UITableView *)table;

@end

NS_ASSUME_NONNULL_END
