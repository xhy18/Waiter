//
//  ShopCarSingleObj.h
//  waiter
//
//  Created by ltl on 2019/7/22.
//  Copyright © 2019 renxin. All rights reserved.
//  购物车中单点项

#import <Foundation/Foundation.h>
#import "ShopCarAddDishObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarSingleObj : NSObject

//分类
@property (nonatomic, strong) NSString *model_category;
//数量
@property (nonatomic, assign) int model_number;
//支付类型
@property (nonatomic, strong) NSString *pay_type;
//套餐价格
@property (nonatomic, assign) double set_menu_dish_prices;
//套餐选项备注
@property (nonatomic, strong) NSString *set_menu_dishes_remarks;
//
@property (nonatomic, assign) double set_menu_price;
//套餐手动备注
@property (nonatomic, strong) NSString *set_menu_waiter_remark;
//单点
@property (nonatomic, strong) ShopCarAddDishObj *single_dish;
//
@property (nonatomic, assign) double single_dish_prices;

@end

NS_ASSUME_NONNULL_END
