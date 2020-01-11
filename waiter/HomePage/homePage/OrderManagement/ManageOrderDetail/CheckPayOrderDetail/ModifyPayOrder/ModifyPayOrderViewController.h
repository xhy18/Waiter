//
//  ModifyPayOrderViewController.h
//  waiter
//
//  Created by renxin on 2019/7/27.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "paymentDishInfo.h"
#import "ModifyPayOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ModifyPayOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)paymentDishInfo * paymentInfo;
@property(strong,nonatomic)UILabel * totalPrice;
@property(strong,nonatomic)UIButton * deleteBtn;
@property(strong,nonatomic)UITableView * dishTableView;
@property(strong,nonatomic)UIButton * payOrderBtn;
@property(strong,nonatomic)NSMutableArray<NSDictionary *>* submitData;
@property(nonatomic,strong)NSMutableArray<paymentDishInfo *>* paymentDishOrderDS;
@property(nonatomic,strong)ModifyPayOrderModel * modifyModel;
@end

NS_ASSUME_NONNULL_END
