//
//  BookingOrderDetailObj.h
//  waiter
//
//  Created by ltl on 2019/11/8.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DishInfoObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookingOrderDetailObj : NSObject

//预约客人
@property (nonatomic, strong) NSString *customer;
//点餐列表
@property (nonatomic, strong) NSMutableArray<DishInfoObj *> *dish_list;
//下单时间
@property (nonatomic, strong) NSString *make_order_time;
//订单号
@property (nonatomic, strong) NSString *order_num;
//手机号
@property (nonatomic, strong) NSString *phone;
//预约时间
@property (nonatomic, strong) NSString *reserve_get_time;
//实际就餐时间
@property (nonatomic, strong) NSString *reserve_real_get_time;
//订单状态
@property (nonatomic, strong) NSString *status;
//是否是微信支付
@property (nonatomic, assign) BOOL pay_by_wechat;

@end

NS_ASSUME_NONNULL_END
