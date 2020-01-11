//
//  BookingView.h
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingOrderObj.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BookingViewDelegte <NSObject>

/**
 * @brief 给controller提供一个订单ID
 * @param type 订单类型
 * @param orderId 预约订单号
 */
- (void)orderType:(NSString *)type bookingOrderId:(NSString *)orderId;

/**
 * @brief 下拉刷新
 * @param table -1：未完成table，1：已完成table
 */
- (void)newData:(int)table;

/**
 * @brief 上拉加载
 * @param table -1：未完成table，1：已完成table
 */
- (void)moreData:(int)table;

@end

@interface BookingView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

//未完成按钮
@property(nonatomic, strong) UIButton *notCompleteBtn;
//已完成按钮
@property(nonatomic, strong) UIButton *completeBtn;
//管理按钮
@property(nonatomic, strong) UIButton *manageBtn;
//滚动视图
@property(nonatomic, strong) UIScrollView *manageScroll;
//滚动下划线
@property(nonatomic, strong) UILabel *underLine;

//未完成table
@property(nonatomic, strong) UITableView *notCompleteTable;
//已完成table
@property(nonatomic, strong) UITableView *completeTable;
//管理view
@property(nonatomic, strong) UIView *manageView;
//管理背景view
@property(nonatomic, strong) UIView *backgroundView;
//关预约label
@property(nonatomic, strong) UILabel *tiplabel;
//预约状态
@property(nonatomic, strong) UILabel *bookingStatuslabel;
//预约开关
@property(nonatomic, strong) UISwitch * isOpenBooking;

//未完成订单列表
@property(nonatomic, strong) NSMutableArray<BookingOrderObj *> *notCompleteArray;
//已完成订单列表
@property(nonatomic, strong) NSMutableArray<BookingOrderObj *> *hasCompleteArray;

//代理
@property(nonatomic, weak) id<BookingViewDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
