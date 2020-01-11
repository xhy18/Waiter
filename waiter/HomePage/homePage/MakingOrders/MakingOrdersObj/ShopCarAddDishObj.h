//
//  ShopCarAddDishObj.h
//  waiter
//
//  Created by ltl on 2019/7/22.
//  Copyright © 2019 renxin. All rights reserved.
//  单点类型中的餐品，套餐中附加的餐品

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarAddDishObj : NSObject

//附加价格
@property (nonatomic, assign) double add_price;
//套餐附加餐id
@property (nonatomic, strong) NSString *dish_id;
//套餐
@property (nonatomic, strong) NSString *dish_name;
//套餐
@property (nonatomic, strong) NSMutableArray *dish_option_id_list;
//
@property (nonatomic, strong) NSString *dish_option_string;
//
@property (nonatomic, assign) double dish_price;
//
@property (nonatomic, strong) NSString *dish_type;
//
@property (nonatomic, strong) NSString *dish_waiter_remark;
//
@property (nonatomic, strong) NSString *isPay;
//
@property (nonatomic, strong) NSString *is_have_options;
//
@property (nonatomic, strong) NSString *is_selected;

@end

NS_ASSUME_NONNULL_END
