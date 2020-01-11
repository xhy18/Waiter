//
//  SetMenuObj.h
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
//  所有套餐列表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetMenuObj : NSObject

//套餐id
@property (nonatomic, strong) NSString *set_menu_id;
//套餐名
@property (nonatomic, strong) NSString *set_menu_name;
//套餐价格
@property (nonatomic, assign) double set_menu_price;

@end

NS_ASSUME_NONNULL_END
