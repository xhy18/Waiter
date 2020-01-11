//
//  DishInfoCollectionViewCell.h
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
//  菜单cell(右侧单点和套餐共用cell)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DishInfoCollectionViewCell : UICollectionViewCell

//菜品名
@property (strong, nonatomic) UILabel * dishName;
//菜品价格(label,带欧元符号)
@property (strong, nonatomic) UILabel * dishPrice;

//-----单点特有------
//菜品id
@property (nonatomic, strong) NSString *dish_id;
//菜品单价
@property (nonatomic, assign) double dish_price;
//是否有备注选项
@property (nonatomic, assign) BOOL is_contain_options;

//-----套餐特有------
//套餐id
@property (nonatomic, strong) NSString *set_menu_id;
//套餐单价
@property (nonatomic, assign) double set_menu_price;

@end

NS_ASSUME_NONNULL_END
