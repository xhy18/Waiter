//
//  CheckOrderDetailView.h
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "unconfirmOrderInfo.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SubmitDelegate <NSObject>

-(void)RefuseTheOrder;

-(void)PassTheOrder;

-(void)RefuseTheOrderAndDish:(NSMutableArray<NSDictionary *>*)dishArray;

@end
@interface CheckOrderDetailView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel * customerLabel;
@property(nonatomic,strong)UILabel * consumeAverageLabel;
@property(nonatomic,strong)UILabel * orderTimeLabel;
@property(nonatomic,strong)UILabel * orderNumLabel;
@property(nonatomic,strong)UILabel * orderTableLabel;
@property(nonatomic,strong)UIButton * passBtn;
@property(nonatomic,strong)UIButton * lackBtn;
@property(nonatomic,strong)UIButton * refuseBtn;
@property(nonatomic,weak)id<SubmitDelegate> submitDelegate;
@property(nonatomic,strong)UITableView * orderDetailTable;
@property(nonatomic,strong)NSMutableArray<NSDictionary *>* lackDishArray;
@property(nonatomic,strong)NSMutableArray<unconfirmOrderInfo *>* unconfirmOrderDetailDS;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<unconfirmOrderInfo*> *)dataArray;
@end

NS_ASSUME_NONNULL_END
