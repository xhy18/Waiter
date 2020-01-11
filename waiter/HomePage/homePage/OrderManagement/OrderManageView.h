//
//  OrderManageView.h
//  waiter
//
//  Created by renxin on 2019/7/22.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderInfo.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SelectDelegate <NSObject>

-(void)CheckOrderDetailByOrderId:(NSString *)orderId;
-(void)ManageOrderByOrderId:(NSString *)orderId;
-(void)PassTheOrderByTable:(NSString *)orderTable;

@end
@interface OrderManageView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * orderTableView;
@property(nonatomic,weak)id<SelectDelegate> selectDelegate;
@property(nonatomic,strong)NSMutableArray<NSMutableArray *>* unconfirmOrderDS;
@property(nonatomic,strong)NSMutableArray<NSMutableArray *>* unpayOrderDS;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<NSMutableArray *> *)dataArray;
-(void)reloadTable;
@end

NS_ASSUME_NONNULL_END
