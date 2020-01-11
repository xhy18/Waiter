//
//  SetWaiterTableViewModel.h
//  waiter
//
//  Created by ltl on 2019/8/8.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetWaiterTableViewModel : NSObject

//开关店状态
@property(nonatomic, assign) BOOL shopStatus;
//创建时间
@property(nonatomic, strong) NSString * shopTime;
//创建时间
@property(nonatomic, strong) NSString * serviceTime;
//开关按钮状态
@property(nonatomic, assign) BOOL switchBtnStatus;
//是否有未支付
@property(nonatomic, assign) BOOL notPaidOrder;

/**
 * 获取开关店状态
 */
- (void)getShopStatus;
/**
 * 开店请求
 */
- (void)openShop;
/**
 * 关店请求
 */
- (void)closeShop;
/**
 * 获取获取未支付订单
 */
- (void)getNotPaidOrder;

@end

NS_ASSUME_NONNULL_END
