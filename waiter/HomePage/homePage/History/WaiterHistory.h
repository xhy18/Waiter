//
//  WaiterHistory.h
//  waiter
//
//  Created by Haze_z on 2019/7/25.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaiterHistory : NSObject

//@property (nonatomic, assign) int count;//历史记录数量
@property (nonatomic, strong)NSString * historyId;
@property (nonatomic, strong)NSString * orderId;
@property (nonatomic, strong)NSString * table;
@property (nonatomic, strong)NSString * waiter;
@property (nonatomic, strong)NSString * type;
@end

NS_ASSUME_NONNULL_END
