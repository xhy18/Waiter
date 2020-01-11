//
//  PayOrderView.m
//  waiter
//
//  Created by renxin on 2019/7/26.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "PayOrderView.h"
#import "Header.h"
#import "MyUtils.h"
@implementation PayOrderView

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<paymentDishInfo*> *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        self.paymentDishOrderDS = @[].mutableCopy;
        self.paymentDishOrderDS = dataArray.mutableCopy;
        [self initUI];
    }
    return self;

}
-(void)initUI{
    paymentDishInfo * dishInfo = _paymentDishOrderDS[0];
    self.orderNumLabel = [[UILabel alloc]init];
    _orderNumLabel.text = [NSString stringWithFormat:@"%@:%@",@"订单号",dishInfo.orderNum];
    _orderNumLabel.font = [UIFont boldSystemFontOfSize:14];

    self.orderTableLabel = [[UILabel alloc]init];
    _orderTableLabel.text = [NSString stringWithFormat:@"%@:%@",@"桌号",dishInfo.orderTable];
    _orderTableLabel.font = [UIFont boldSystemFontOfSize:14];

    self.modifyBtn = [[UIButton alloc]init];
    _modifyBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _modifyBtn.layer.cornerRadius = 20.0f;
    _modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_modifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_modifyBtn addTarget:self action:@selector(modifyPayOrder) forControlEvents:UIControlEventTouchUpInside];
    [_modifyBtn setTitle:@"修改" forState:UIControlStateNormal];


    self.orderPaymentDetailTable = [[UITableView alloc]init];
    _orderPaymentDetailTable.delegate = self;
    _orderPaymentDetailTable.dataSource = self;
    _orderPaymentDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;


    [self addSubview:_orderNumLabel];
    [self addSubview:_orderTableLabel];
    [self addSubview:_modifyBtn];
    [self addSubview:_orderPaymentDetailTable];
}
-(void)layoutSubviews{

    self.orderNumLabel.frame = CGRectMake(15, 0, (SCREENWIDTH-30)*2/3, 50);
    self.orderTableLabel.frame = CGRectMake(15, 50, (SCREENWIDTH-30)*2/3, 50);
    self.modifyBtn.frame = CGRectMake((SCREENWIDTH-30)*2/3, 50, (SCREENWIDTH-30)/3, 40);
    self.orderPaymentDetailTable.frame = CGRectMake(15, 50*2+5, SCREENWIDTH-30, SCREENHEIGHT-150);
}
#pragma mark -- UITableViewDelegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.paymentDishOrderDS.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier =[NSString stringWithFormat:@"%@%ld",@"orderDetail",(long)indexPath.row];
    UITableViewCell *cell = [_orderPaymentDetailTable dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    paymentDishInfo * payDishInfo = _paymentDishOrderDS[indexPath.row];
    cell.backgroundColor = GRAYCOLOR;
    UIView * orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-60, 40)];
    [cell.contentView addSubview:orderView];

    UILabel * dishNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, (SCREENWIDTH-60)*6/7, 40)];
    dishNameLabel.font = [UIFont systemFontOfSize:14];
    dishNameLabel.text = payDishInfo.dishName;
    [orderView addSubview:dishNameLabel];


    UILabel * dishPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-60)*6/7, 0, (SCREENWIDTH-60)/7, 40)];
    dishPriceLabel.font = [UIFont systemFontOfSize:14];
    dishPriceLabel.text = payDishInfo.dishPrice;
    [orderView addSubview:dishPriceLabel];


    return cell;
}
#pragma mark--行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)modifyPayOrder{
    [self.mdifyDelegate ModifyThePayOrder];
}

@end
