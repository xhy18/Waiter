//
//  MakingOrdersModel.h
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleDishObj.h"
#import "SetMenuObj.h"
#import "TasteTypeObj.h"
#import "SetMenuDetailObj.h"
#import "ShopCarSingleObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakingOrdersModel : NSObject

//商家点餐模式，键值（ "support_set_menu"，"support_single_ordering"）
@property(nonatomic, strong) NSMutableDictionary *dishModeDic;
//单点分类列表
@property(nonatomic, strong) NSMutableArray<SingleDishObj *> *singleClassifyArray;
//单点菜品列表
@property(nonatomic, strong) NSMutableArray<SingleDishObj *> *singleDishArray;
//套餐列表
@property(nonatomic, strong) NSMutableArray<SetMenuObj *> *setMenuArray;
//单独获取菜品口味列表
@property(nonatomic, strong) NSMutableArray<TasteTypeObj *> *dishTasteArray;
//套餐详细列表
@property(nonatomic, strong) NSMutableArray<SetMenuDetailObj *> *setMenuDetailArray;
//可用桌号数组
@property(nonatomic, strong) NSMutableArray *tableNumArray;

/**
 * 获取商家点餐模式
 */
- (void)getShopDishMode;

/**
 * 获取商家单点菜品分类
 */
- (void)getSingleDishClassification;

/**
 * 根据分类id获取单点菜品
 * @param classId 分类id
 */
- (void)getSingleDish:(NSString *)classId;

/**
 * 获取商家套餐菜单
 */
- (void)getComboMenu;

/**
 * 根据菜品id获取菜品口味
 * @param dishId 菜品id
 */
- (void)getDishTaste:(NSString *)dishId;

/**
 * 根据套餐id获取套餐菜单
 * @param setMenuId 套餐id
 */
- (void)getSetMenu:(NSString *)setMenuId;

/**
 * 获取商家桌号
 */
- (void)getShopTableNumber;

/**
 * 提交点餐订餐
 * @param dishList 餐品列表
 * @param orderType 订单类型
 * @param tableNum 桌号
 * @param peopleNum 人数
 */
- (void)postShopCarOrderdishList:(NSMutableArray *)dishList type:(NSString *)orderType table:(NSString *)tableNum people:(NSString *)peopleNum;

@end

NS_ASSUME_NONNULL_END
