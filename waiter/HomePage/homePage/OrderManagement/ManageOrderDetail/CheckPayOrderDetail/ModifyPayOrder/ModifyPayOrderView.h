//
//  ModifyPayOrderView.h
//  waiter
//
//  Created by renxin on 2019/8/1.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "paymentDishInfo.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ModifyPayDishDelegate <NSObject>

-(void)PayDishOrderDishes:(NSMutableArray<NSDictionary *>*) dishList;
-(void)DeleteDishOrderDishes:(NSMutableArray<NSDictionary *>*) dishList;

@end
@interface ModifyPayOrderView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)id<ModifyPayDishDelegate> modifyDishDelegate;
@property(strong,nonatomic)paymentDishInfo * paymentInfo;
@property(strong,nonatomic)UILabel * totalPrice;
@property(strong,nonatomic)UIButton * deleteBtn;
@property(strong,nonatomic)UITableView * dishTableView;
@property(strong,nonatomic)UIButton * payOrderBtn;
@property(strong,nonatomic)NSMutableArray<NSDictionary *>* submitData;
@property(nonatomic,strong)NSMutableArray<paymentDishInfo *>* paymentDishOrderDS;
@property(nonatomic,strong)NSString * orderId;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<paymentDishInfo*> *)dataArray;

@end

NS_ASSUME_NONNULL_END
