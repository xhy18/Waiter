//
//  JumpType_2_Model.h
//  waiter
//
//  Created by Haze_z on 2019/8/9.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JumpType_2_Model : NSObject
@property(nonatomic,strong)NSString * payStatus;
@property(nonatomic,strong) NSDictionary * unpaymentDetail;
-(void)GetOrderPaymentInfoList:(NSString *) orderId;
-(void)PayOrderByOrderId:(NSString *) orderId;
-(void)HaveSeeByOrderId:(NSString *) orderId;
@end

NS_ASSUME_NONNULL_END
