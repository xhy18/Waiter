//
//  BookingOrderObj.h
//  waiter
//
//  Created by ltl on 2019/10/25.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookingOrderObj : NSObject

//订单id
@property (nonatomic, strong) NSString *booking_id;
//订单号
@property (nonatomic, strong) NSString *order_num;
//就餐人数
@property (nonatomic, strong) NSString *customer_num;
//预约时间
@property (nonatomic, strong) NSString *reserve_get_time;
//实际就餐时间
@property (nonatomic, strong) NSString *reserve_real_get_time;
//下单时间
@property (nonatomic, strong) NSString *make_order_time;
//订单状态
@property (nonatomic, assign) int status;

@end

NS_ASSUME_NONNULL_END
