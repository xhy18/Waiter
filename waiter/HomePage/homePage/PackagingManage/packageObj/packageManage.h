//
//  packageManage.h
//  waiter
//
//  Created by ltl on 2019/7/12.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface packageManage : NSObject

//打包id
@property (nonatomic, strong) NSString *package_id;
//下单时间
@property (nonatomic, strong) NSString *make_order_time;
//预计取餐时间
@property (nonatomic, strong) NSString *reserve_time;
//实际取餐时间
@property (nonatomic, strong) NSString *real_time;
//取餐客人
@property (nonatomic, strong) NSString *customer;
//订单状态：0.已打印小票  1.已支付
@property (nonatomic, assign) NSString *status;
//订单号
@property (nonatomic, strong) NSString *order_num;

@end

NS_ASSUME_NONNULL_END
