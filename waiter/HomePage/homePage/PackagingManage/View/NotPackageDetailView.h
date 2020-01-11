//
//  NotPackageDetailView.h
//  waiter
//
//  Created by ltl on 2019/7/17.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackageOrderDetailObj.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol NotPackageDetailViewDelegte <NSObject>
//
///**
// * 点击按钮，给controller提供打印信号
// */
//- (void)clickBtnPrint;
//
//@end

@interface NotPackageDetailView : UIView<UITableViewDelegate,UITableViewDataSource>

//订单详情灰色背景
@property(nonatomic, strong) UIView *grayBackground;
//订单号
@property(nonatomic, strong) UILabel *orderId;
//姓名
@property(nonatomic, strong) UILabel *name;
//电话
@property(nonatomic, strong) UILabel *telephone;
//下单时间
@property(nonatomic, strong) UILabel *orderTime;
//取餐时间
@property(nonatomic, strong) UILabel *pickTime;
//实际取餐时间
@property(nonatomic, strong) UILabel *actualPickTime;
//服务员
@property(nonatomic, strong) UILabel *waiter;

//菜品数量
@property(nonatomic, strong) UILabel *dishesNum;

//菜单列表灰色背景
@property(nonatomic, strong) UIView *tableBackground;
//菜单列表
@property(nonatomic, strong) UITableView *dishesTable;
//菜单数组
@property(nonatomic, strong) NSMutableArray<DishInfoObj *> *dishList;

//底部按钮
@property(nonatomic, strong) UIButton *bottomBtn;

//修改view上的订单信息
- (void)changeOrderInfo:(PackageOrderDetailObj *)detail;

//代理
//@property(nonatomic, weak) id<NotPackageDetailViewDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
