//
//  PackageOrderDetailObj.h
//  waiter
//
//  Created by ltl on 2019/7/17.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DishInfoObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface PackageOrderDetailObj : NSObject

//取餐客人
@property (nonatomic, strong) NSString *customer;
//点餐列表
@property (nonatomic, strong) NSMutableArray<DishInfoObj *> *dish_list;
//下单时间
@property (nonatomic, strong) NSString *make_order_time;
//订单号
@property (nonatomic, strong) NSString *order_num;
//手机号
@property (nonatomic, strong) NSString *phone;
//实际取餐时间
@property (nonatomic, strong) NSString *real_time;
//预计取餐时间
@property (nonatomic, strong) NSString *reserver_time;
//订单状态
@property (nonatomic, strong) NSString *status;
//服务员
@property (nonatomic, strong) NSString *waiter;

@end

NS_ASSUME_NONNULL_END
