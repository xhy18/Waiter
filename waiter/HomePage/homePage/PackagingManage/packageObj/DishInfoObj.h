//
//  DishInfoObj.h
//  waiter
//
//  Created by ltl on 2019/7/17.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DishInfoObj : NSObject

//餐品id
@property (nonatomic, strong) NSString *dish_id;
//餐品名
@property (nonatomic, strong) NSString *dish_name;
//餐品数量
@property (nonatomic, strong) NSString *dish_number;
//备注
@property (nonatomic, strong) NSString *dish_options;

@end

NS_ASSUME_NONNULL_END
