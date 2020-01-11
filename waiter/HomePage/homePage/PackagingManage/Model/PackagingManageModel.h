//
//  PackagingManageModel.h
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "packageManage.h"
#import "PackageOrderDetailObj.h"
#import "DishInfoObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface PackagingManageModel : NSObject

//未打包订单列表
@property(nonatomic, strong) NSMutableArray<packageManage *> *notPackageArray;
//已打包订单列表
@property(nonatomic, strong) NSMutableArray<packageManage *> *hasPackageArray;
//打包订单详情
@property(nonatomic, strong) PackageOrderDetailObj *packageDetail;

/**
 * 获取未完成订单数据
 * @param page 分页
 */
- (void)getNotPackageData:(NSString *)page;

/**
 * 获取已完成订单数据
 * @param page 分页
 */
- (void)getHasPackageData:(NSString *)page;

/**
 * 根据订单号获取详细订单数据
 * @param orderId 订单号
 */
- (void)getDetailOrderData:(NSString *)orderId;

/**
 * 根据订单号取消打包订单
 * @param orderId 订单号
 */
- (void)cancelPackageOrder:(NSString *)orderId;

/**
 * 根据订单号打印订单小票
 * @param orderId 订单号
 */
- (void)printPackageOrder:(NSString *)orderId;

/**
 * 根据订单号确认取餐
 * @param orderId 订单号
 */
- (void)confirmPackageOrder:(NSString *)orderId;

@end

NS_ASSUME_NONNULL_END
