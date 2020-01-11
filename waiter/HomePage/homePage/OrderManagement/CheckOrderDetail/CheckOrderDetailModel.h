//
//  CheckOrderDetailModel.h
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "unconfirmOrderInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckOrderDetailModel : NSObject
@property(nonatomic,strong)NSMutableArray<unconfirmOrderInfo *> * unconfirmOrderInfoList;
-(void)GetOrderDetailList:(NSString *) orderId;
-(void)PassOrderByOrderId:(NSString *) orderId;
-(void)RefuseOrderByOrderId:(NSString *) orderId;
-(void)RefuseOrderAndDish:(NSString *) orderId DishArray:(NSMutableArray<NSDictionary *>*) dishArray;
@end

NS_ASSUME_NONNULL_END
