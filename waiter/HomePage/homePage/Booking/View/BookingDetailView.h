//
//  BookingDetailView.h
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingOrderDetailObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookingDetailView : UIView<UITableViewDelegate,UITableViewDataSource>

//订单详情灰色背景
@property(nonatomic, strong) UIView *grayBackground;
//订单号
@property(nonatomic, strong) UILabel *orderNum;
//姓名
@property(nonatomic, strong) UILabel *name;
//电话
@property(nonatomic, strong) UILabel *telephone;
//下单时间
@property(nonatomic, strong) UILabel *orderTime;
//就餐时间
@property(nonatomic, strong) UILabel *bookingTime;

//菜品数量
@property(nonatomic, strong) UILabel *dishesNum;

//菜单列表灰色背景
@property(nonatomic, strong) UIView *tableBackground;
//菜单table
@property(nonatomic, strong) UITableView *dishesTable;
//菜品列表数组
@property(nonatomic, strong) NSMutableArray<DishInfoObj *> *dishDS;

//打印小票
@property(nonatomic, strong) UIButton *bottomBtn;

//初始化ui
- (instancetype)initWithFrame:(CGRect)frame orderType:(NSString *)type;

//设置未完成ui
- (void)setNotCompletedOrderUI:(BookingOrderDetailObj *)detail;
//设置已完成ui
- (void)setHasCompletedOrderUI:(BookingOrderDetailObj *)detail;
//设置扫描订单ui
- (void)setScanBookingOrderUI:(BookingOrderDetailObj *)detail;

@end

NS_ASSUME_NONNULL_END
