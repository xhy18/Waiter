//
//  OrderManageModel.h
//  waiter
//
//  Created by renxin on 2019/7/22.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "orderInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderManageModel : NSObject
@property(nonatomic,strong)NSMutableArray<orderInfo *> * orderInfoList;
@property(nonatomic,strong)NSMutableArray<NSMutableArray *> * theOrderArray;
@property(nonatomic,strong)NSMutableArray<orderInfo *> * unpayOrderInfoList;
@property(nonatomic,strong)NSMutableArray<NSMutableArray *> * unpayOrderArray;
-(void)GetUnconfirmOrderList;
-(void)GetUnpayOrderList;
-(void)PassOrderByTable:(NSString *)orderTable;
@end

NS_ASSUME_NONNULL_END
