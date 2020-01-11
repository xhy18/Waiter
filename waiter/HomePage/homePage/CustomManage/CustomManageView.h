//
//  CustomManageView.h
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "callInfo.h"
NS_ASSUME_NONNULL_BEGIN
@protocol getTipDelegate <NSObject>

-(void)getTipData:(NSString *)tableName;

@end
@interface CustomManageView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray<callInfo *>* customCallDS;
@property(nonatomic,weak)id<getTipDelegate> getTipDelegate;
@property(nonatomic,strong) UITableView * callShowTable;

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
