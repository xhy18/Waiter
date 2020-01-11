//
//  BookingTableViewCell.h
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookingTableViewCell : UITableViewCell

//背景视图
@property(nonatomic,strong) UIView  *grayBackground;
//订单号
@property(nonatomic,strong) UILabel *orderId;
//就餐人数
@property(nonatomic,strong) UILabel *numberOfPeople;
//就餐时间
@property(nonatomic,strong) UILabel *bookingTime;
//预约状态
@property(nonatomic,strong) UILabel *bookingState;

@end

NS_ASSUME_NONNULL_END
