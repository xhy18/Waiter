//
//  BookingModel.h
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookingOrderObj.h"
#import "BookingOrderDetailObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookingModel : NSObject

//未完成订单列表
@property(nonatomic, strong) NSMutableArray<BookingOrderObj *> *notFinishArray;
//已打包订单列表
@property(nonatomic, strong) NSMutableArray<BookingOrderObj *> *completedArray;
//预约订单详情
@property(nonatomic, strong) BookingOrderDetailObj *bookingDetail;
//请求状态
@property(nonatomic, strong) NSString * interStatus1;
//请求状态
@property(nonatomic, strong) NSString * interStatus2;

//管理：预约开关状态
@property(nonatomic, assign) BOOL bookingSwitchStatus;

/**
 * @brief 获取未完成的预约订单数据
 * @param page 分页
 */
- (void)getNotFinishBookingData:(NSString *)page;

/**
 * @brief 获取已完成的预约订单数据
 * @param page 分页
 */
- (void)getCompletedBookingData:(NSString *)page;

/**
 * @brief 根据订单号获取详细订单数据
 * @param orderId 订单号
 */
- (void)getDetailOrderData:(NSString *)orderId;

/**
 * @brief 根据订单号取消预约订单
 * @param orderId 订单号
 */
- (void)cancelBookingOrder:(NSString *)orderId;

/**
 * @brief 根据订单号打印订单小票
 * @param orderId 订单号
 */
- (void)printBookingOrder:(NSString *)orderId;

/**
 * @brief 根据订单号确认取餐
 * @param orderId 订单号
 */
- (void)confirmBookingOrder:(NSString *)orderId;

/**
 * @brief 获取当前预约模式状态
 */
- (void)getBookingStatus;
/**
 * @brief 开启预约
 */
- (void)openBooking;
/**
 * @brief 关闭预约
 */
- (void)closeBooking;

@end

NS_ASSUME_NONNULL_END
