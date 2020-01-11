//
//  ShopCarModel.h
//  waiter
//
//  Created by ltl on 2019/7/22.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCarSingleObj.h"
#import "ShopCarSetMenuObj.h"

//回调最后解析的数组
typedef void(^finalDishList)(NSMutableArray * finalArray);

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarModel : NSObject

@property(nonatomic, assign) int totalNum;
@property(nonatomic, assign) double totalPrice;
@property(nonatomic, strong) NSMutableArray * shopCarSingleArray;
@property(nonatomic, strong) NSMutableArray * shopCarSetMenuArray;

/**
 * 初始化购物车数组
 */
-(void)InitShopCar;
/**
 * 向购物车中增加单点(非加减方式)
 * @param dish 单点
 */
- (void)AddSingleDishToShopcar:(ShopCarSingleObj *)dish;
/**
 * 向购物车中增加套餐(非加减方式)
 * @param dish 套餐
 */
- (void)AddSetMenuToShopcar:(ShopCarSetMenuObj *)dish;
/**
 * 购物车中更改数量(加减方式)
 * @param section 对应视图的tableview，0：单点，1：套餐
 * @param index 数组序号
 * @param state 1：加，-1：减
 */
- (void)addOrSubShopCar:(NSInteger)section row:(NSInteger)index state:(int)state;
/**
 * 获取购物车菜品个数
 */
- (int)GetShopCarNum;
/**
 * 获取购物车总价
 */
- (double)GetShopCarTotalPrice;
/**
 * 将原始单点数组/套餐数组解析成字典数组
 */
- (void)shopCarToDictionary:(finalDishList)block;

@end

NS_ASSUME_NONNULL_END
