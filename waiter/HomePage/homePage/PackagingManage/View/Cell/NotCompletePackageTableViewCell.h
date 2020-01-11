//
//  NotCompletePackageTableViewCell.h
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotCompletePackageTableViewCell : UITableViewCell

//背景视图
@property(nonatomic,strong) UIView *grayBackground;
//订单号
@property(nonatomic,strong) UILabel *orderId;
//下单时间
@property(nonatomic,strong) UILabel *orderTime;
//取餐时间
@property(nonatomic,strong) UILabel *pickUpTime;
//取餐客人
@property(nonatomic,strong) UILabel *guest;
//打包状态
@property(nonatomic,strong) UILabel *packageState;

@end

NS_ASSUME_NONNULL_END
