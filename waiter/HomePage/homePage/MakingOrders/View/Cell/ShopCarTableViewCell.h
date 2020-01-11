//
//  ShopCarTableViewCell.h
//  waiter
//
//  Created by ltl on 2019/7/25.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarButton.h"
#import "ShopCarSingleObj.h"
#import "ShopCarSetMenuObj.h"
#import "ShopCarAddDishObj.h"
#import "MyUtils.h"
#import "Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarTableViewCell : UITableViewCell

//数据源类型（0：单点，1：套餐）
@property(nonatomic,assign) int type;
//单点数据源
@property(nonatomic,strong) ShopCarSingleObj *dish;
//套餐数据源
@property(nonatomic,strong) ShopCarSetMenuObj *setMenu;
//菜品名
@property(nonatomic,strong) UILabel *dishName;
//总价标签
@property(nonatomic,strong) UILabel *price;
//数量
@property(nonatomic,strong) UILabel *num;
//减按钮
@property(nonatomic,strong) ShopCarButton *sub;
//加按钮
@property(nonatomic,strong) ShopCarButton *add;
//备注
@property(nonatomic,strong) UILabel *remarkLabel;
//备注视图
@property(nonatomic,strong) UIView *remark;

@end

NS_ASSUME_NONNULL_END
