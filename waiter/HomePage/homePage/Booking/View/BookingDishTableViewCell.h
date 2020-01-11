//
//  BookingDishTableViewCell.h
//  waiter
//
//  Created by ltl on 2019/10/25.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DishInfoObj.h"
#import "MyUtils.h"
#import "Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookingDishTableViewCell : UITableViewCell

//套餐数据源
@property(nonatomic,strong) DishInfoObj *dish;
//底部view
@property(nonatomic,strong) UIView *grayBackground;
//菜品名
@property(nonatomic,strong) UILabel *dishName;
//折叠图标
@property(nonatomic,strong) UIButton *foldBtn;
//菜品数量
@property(nonatomic,strong) UILabel *dishNum;
//备注
@property(nonatomic,strong) UILabel *remarkLabel;
//备注视图
@property(nonatomic,strong) UIView *remark;

@end

NS_ASSUME_NONNULL_END
