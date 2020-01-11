//
//  PayOrderViewModel.h
//  waiter
//
//  Created by renxin on 2019/7/26.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "paymentDishInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface PayOrderViewModel : NSObject
@property(nonatomic,strong)NSMutableArray<paymentDishInfo *> * paymentDishOrderList;
-(void)GetDishPaymentInfoList:(NSString *) orderId;
@end

NS_ASSUME_NONNULL_END
