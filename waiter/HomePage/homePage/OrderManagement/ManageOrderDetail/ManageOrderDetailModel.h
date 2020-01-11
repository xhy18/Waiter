//
//  ManageOrderDetailModel.h
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ManageOrderDetailModel : NSObject
@property(nonatomic,strong) NSDictionary * unpaymentDetail;
-(void)GetOrderPaymentInfoList:(NSString *) orderId;
-(void)PayOrderByOrderId:(NSString *) orderId;
@end

NS_ASSUME_NONNULL_END
