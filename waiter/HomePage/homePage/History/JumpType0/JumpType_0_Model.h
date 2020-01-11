//
//  JumpType_0_Model.h
//  waiter
//
//  Created by Haze_z on 2019/8/10.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDish.h"

NS_ASSUME_NONNULL_BEGIN

@interface JumpType_0_Model : NSObject
@property(nonatomic , strong)NSString *tableNum;
@property(nonatomic , strong)NSString *personNum;
@property(nonatomic , strong)NSString *orderNum;
@property(nonatomic , strong)NSString *orderPrice;

@property(strong,nonatomic)NSMutableArray<OrderDish *> * dishInfo;

-(void)GetManagerOrderDetail:(NSString *)orderId;
@end

NS_ASSUME_NONNULL_END
