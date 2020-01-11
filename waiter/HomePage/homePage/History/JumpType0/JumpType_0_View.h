//
//  JumpType_0_View.h
//  waiter
//
//  Created by Haze_z on 2019/8/10.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDish.h"

@protocol getDishDelegate <NSObject>

-(void)getDishData:(NSString *)tableName;

@end

@interface JumpType_0_View : UIView
@property(nonatomic , strong)UIView *tableDataView;
@property(nonatomic , strong)UIView *dishListView;
@property(nonatomic , strong)UIView *remarkView;
@property(nonatomic , strong)UIView *totalView;
@property(nonatomic , strong)UILabel *tableNum;
@property(nonatomic , strong)UILabel *orderNum;
@property(nonatomic , strong)UIImageView *person;
@property(nonatomic , strong)UILabel *personNum;
@property(nonatomic , strong)UILabel *dishNum;
@property(nonatomic , strong)UILabel *total;
@property(nonatomic , strong)UIButton *passBtn;
@property(nonatomic,strong)UITextField * remarkTF;

@property(strong , nonatomic)NSMutableArray<OrderDish *> *dishDS;//存储点餐详情的动态数组
@property(nonatomic,weak)id<getDishDelegate> getDishDelegate;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray;
@end

