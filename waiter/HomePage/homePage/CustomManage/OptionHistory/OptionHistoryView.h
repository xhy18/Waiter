//
//  OptionHistoryView.h
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waiterHistory.h"
NS_ASSUME_NONNULL_BEGIN

@protocol dealDelegate <NSObject>

-(void)getTipData;

@end
@interface OptionHistoryView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray<waiterHistory *>* waiterHistoryDS;
@property(nonatomic,weak)id<dealDelegate> dealCallDelegate;
@property(nonatomic,strong) UITableView * dealDetailTable;
@property(nonatomic,strong) UIButton * dealBtn;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray;
@end
NS_ASSUME_NONNULL_END
