//
//  SingleDishObj.h
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
//  所有单点列表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleDishObj : NSObject

//-----单点分类列表-----

//单点分类id
@property (nonatomic, strong) NSString *class_id;
//单点分类名
@property (nonatomic, strong) NSString *class_name;

//-----单点菜品-----

//菜品id
@property (nonatomic, strong) NSString *dish_id;
//菜品名
@property (nonatomic, strong) NSString *dish_name;
//菜品价格
@property (nonatomic, assign) double dish_price;
//是否有备注选项
@property (nonatomic, assign) BOOL is_contain_options;

@end

NS_ASSUME_NONNULL_END
