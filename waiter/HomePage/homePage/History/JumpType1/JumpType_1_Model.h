//
//  JumpType_1_Model.h
//  waiter
//
//  Created by Haze_z on 2019/8/16.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDish.h"
#import "OrderSingleDish.h"
#import "OrderPackDish.h"

NS_ASSUME_NONNULL_BEGIN

@interface JumpType_1_Model : NSObject
@property(nonatomic , strong)NSString *tableNum;
@property(nonatomic , strong)NSString *personNum;
@property(nonatomic , strong)NSString *orderNum;
@property(nonatomic , strong)NSString *orderPrice;
@property(nonatomic , strong)NSString *checkStatus;
@property(nonatomic , strong)NSDictionary *dishDic;


@property(strong,nonatomic)NSMutableArray<OrderDish *> * dishInfo;
@property(strong,nonatomic)NSMutableArray<OrderSingleDish *> * singledishInfo;
@property(strong,nonatomic)NSMutableArray<OrderPackDish *> * packdishInfo;

-(void)GetManagerOrderDetail:(NSString *)orderId;
@end

NS_ASSUME_NONNULL_END

