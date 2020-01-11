//
//  BWT_HistoryView.h
//  waiter
//
//  Created by Haze_z on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiterHistory.h"
#import "BWTHistoryTableViewCell.h"

@protocol getTipDelegate <NSObject>

-(void)getTipData:(NSString *)tableName;

@end
@interface BWTHistoryView :UIView <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>
@property(nonatomic , strong)UIView *lineView;
@property(nonatomic , strong)UIView *DIYnavigationView;
@property(strong , nonatomic)UIButton *backButton;
@property(strong , nonatomic)UIButton *SearchButton;
@property(strong , nonatomic)UILabel *titleLabel;
@property(nonatomic , strong)UITableView *HistoryTableView;

@property(strong , nonatomic)NSMutableArray<WaiterHistory *> *historyDS;//存储历史记录的动态数组
@property(nonatomic,weak)id<getTipDelegate> getTipDelegate;

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray;
@end

