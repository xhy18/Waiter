//
//  ViewControllerModel.h
//  waiter
//
//  Created by ltl on 2019/8/7.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewControllerModel : NSObject

//呼叫数量
@property(nonatomic, strong) NSString * customManageNum;
//订单数量
@property(nonatomic, strong) NSString * orderManageNum;
//打包数量
@property(nonatomic, strong) NSString * packageNum;

/**
 * 根据大堂经理id与商户id获取客人管理消息数量 呼叫
 */
- (void)getCustomManageNum;
/**
 * 根据大堂经理id与商户id获取待审核订单数量 订单
 */
- (void)getOrderManageNum;
/**
 * 根据大堂经理id与商户id获取打包信息数量 打包
 */
- (void)getPackageNum;

@end

NS_ASSUME_NONNULL_END
