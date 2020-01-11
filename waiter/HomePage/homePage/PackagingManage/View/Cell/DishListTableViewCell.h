//
//  DishListTableViewCell.h
//  waiter
//
//  Created by ltl on 2019/7/17.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DishListTableViewCell : UITableViewCell

//底部view
@property(nonatomic,strong) UIView *grayBackground;
//菜品名
@property(nonatomic,strong) UILabel *dishName;
//菜品数量
@property(nonatomic,strong) UILabel *dishNum;
//备注
@property(nonatomic,strong) UILabel *remarks;

@end

NS_ASSUME_NONNULL_END
