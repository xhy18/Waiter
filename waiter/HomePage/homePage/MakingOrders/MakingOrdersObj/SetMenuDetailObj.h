//
//  SetMenuDetailObj.h
//  waiter
//
//  Created by ltl on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//  套餐详情项

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetMenuDishListObj : NSObject

//附加价格
@property (nonatomic, assign) double add_price;
//餐品id
@property (nonatomic, strong) NSString *dish_id;
//餐品名称
@property (nonatomic, strong) NSString *dish_name;
//是否有备注
@property (nonatomic, assign) BOOL is_contain_options;

@end

@interface SetMenuDetailObj : NSObject

//id
@property (nonatomic, strong) NSString *class_id;
//名称
@property (nonatomic, strong) NSString *class_name;
//套餐分组列表
@property (nonatomic, strong) NSMutableArray<SetMenuDishListObj *> *dish_list;
//最大选择值
@property (nonatomic, assign) int max_select_number;

@end

NS_ASSUME_NONNULL_END
