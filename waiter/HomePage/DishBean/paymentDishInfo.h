//
//  unpaymentDetail.h
//  waiter
//
//  Created by renxin on 2019/7/26.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface unpaymentDetail : NSObject

@property(strong,nonatomic)NSString * dishId;
@property(strong,nonatomic)NSString * dishName;
@property(strong,nonatomic)NSString * dishPrice;
@property(strong,nonatomic)NSString * dishType;
@property(strong,nonatomic)NSString * payStatus;
@property(strong,nonatomic)NSString * orderNum;
@property(strong,nonatomic)NSString * orderTable;
@end

NS_ASSUME_NONNULL_END
