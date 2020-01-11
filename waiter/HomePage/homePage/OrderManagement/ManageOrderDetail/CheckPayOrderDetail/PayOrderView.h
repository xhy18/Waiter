//
//  PayOrderView.h
//  waiter
//
//  Created by renxin on 2019/7/26.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "paymentDishInfo.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ModifyPayOrderDelegate <NSObject>

-(void)ModifyThePayOrder;

@end
@interface PayOrderView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel * orderNumLabel;
@property(nonatomic,strong)UILabel * orderTableLabel;
@property(nonatomic,strong)UIButton * modifyBtn;
@property(nonatomic,weak)id<ModifyPayOrderDelegate> mdifyDelegate;
@property(nonatomic,strong)UITableView * orderPaymentDetailTable;
@property(nonatomic,strong)NSMutableArray<paymentDishInfo *>* paymentDishOrderDS;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<paymentDishInfo*> *)dataArray;
@end

NS_ASSUME_NONNULL_END
