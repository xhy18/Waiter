//
//  MakingOrdersView.h
//  waiter
//
//  Created by ltl on 2019/7/12.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleDishObj.h"
#import "SetMenuObj.h"
#import "ShopCarSingleObj.h"
#import "ShopCarSetMenuObj.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MakingOrdersViewDelegte <NSObject>

/**
 * 给controller提供一个分类id，查询分类下所有单品
 * @param classId 分类id
 */
- (void)getNewClassId:(NSString *)classId;
/**
 * 给controller提供一个单品id，查询单品口味
 * @param dishId 单品id
 */
- (void)getDishTaste:(NSString *)dishId;
/**
 * 给controller提供一个套餐id，请求套餐详细信息，并给购物车数组新增一个临时套餐
 * @param setMenuId 套餐id
 * @param setMenuName 套餐名
 * @param addSetMenu 套餐
 */
- (void)getsetMenuDetail:(NSString *)setMenuId menuName:(NSString *)setMenuName
     addSetMenuToShopCar:(ShopCarSetMenuObj *)addSetMenu;
/**
 * 给controller购物车数组新增一个单点无口味餐品
 * @param addSingleDish 新单点无口味餐品
 */
- (void)addSingleDishNoTasteToShopCar:(ShopCarSingleObj *)addSingleDish;
/**
 * 给controller购物车数组新增一个单点有口味餐品
 * @param addSingleDish 新单点有口味餐品
 */
- (void)addSingleDishTasteToShopCar:(ShopCarSingleObj *)addSingleDish;
/**
 * 给controller提醒加减餐品操作
 * @param sec 0或1
 * @param row 序号
 * @param state 1加，-1减
 */
- (void)changeShopCar:(NSInteger)sec row:(NSInteger)row state:(int)state;
/**
 * 给controller标志位，显示某菜品备注弹窗
 * @param tag 包含section与row的组合信息
 */
- (void)addRemark:(NSUInteger)tag;

@end

@interface MakingOrdersView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

//单点按钮
@property(nonatomic, strong) UIButton *singleDishBtn;
//套餐按钮
@property(nonatomic, strong) UIButton *comboMealBtn;
//主菜单区
@property(nonatomic, strong) UIView *mainView;
//单点菜单区
@property(nonatomic, strong) UIView *singleDishView;
//套餐菜单区
@property(nonatomic, strong) UIView *comboMealView;
//单点左侧列表
@property(nonatomic, strong) UICollectionView *singleDishCollectionView;
//单点右侧列表
@property(nonatomic, strong) UICollectionView *dishCollectionView;
//套餐区
@property(nonatomic, strong) UICollectionView *setMenuCollectionView;

//底部背景视图
@property(nonatomic, strong) UIView *backgroundView;
//打包按钮
@property(nonatomic, strong) UIButton *packageBtn;
//点餐按钮
@property(nonatomic, strong) UIButton *makeOrderBtn;
//购物车图标
@property(nonatomic, strong) UIImageView *shopCarView;
//点餐数量view
@property(nonatomic, strong) UIView *shopNumView;
//点餐数量
@property(nonatomic, strong) UILabel *numLabel;
//菜品label
@property(nonatomic, strong) UILabel *dishNumLabel;
//总价label
@property(nonatomic, strong) UILabel *totalLabel;
//提交订单按钮
@property(nonatomic, strong) UIButton *submitBtn;
//购物车视图
@property(nonatomic, strong) UIView *shopCarDetailView;
//购物车详情视图
@property(nonatomic, strong) UITableView *shopTable;

//单点分类列表
@property(nonatomic, strong) NSMutableArray<SingleDishObj *> *singleClassifyArray;
//单点菜品列表
@property(nonatomic, strong) NSMutableArray<SingleDishObj *> *singleDishArray;
//套餐列表
@property(nonatomic, strong) NSMutableArray<SetMenuObj *> *setMenuArray;

//购物车单点
@property(nonatomic, strong) NSMutableArray *singleArray;
//购物车套餐
@property(nonatomic, strong) NSMutableArray *menuArray;


//根据controller的数据初始化单点分类列表
- (void)initSingleListCollection:(NSMutableArray<SingleDishObj *> *)singleList;
//根据controller的数据初始化单点右侧菜品分类列表
- (void)initSingleDishCollection:(NSMutableArray<SingleDishObj *> *)singleList;
//根据controller的数据初始化套餐列表
- (void)initSetMenuCollection:(NSMutableArray<SetMenuObj *> *)setMenuList;
//修改购物车数量
- (void)changeShopCarNum:(int)num shopCarPrice:(double)price;

//代理
@property(nonatomic, weak) id<MakingOrdersViewDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
