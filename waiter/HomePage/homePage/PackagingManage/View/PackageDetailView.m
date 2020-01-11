//
//  PackageDetailView.m
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//  历史打包详情页

#import "PackageDetailView.h"
#import "DishListTableViewCell.h"
#import "Header.h"
#import "MyUtils.h"
#define FONTSIZE 15

@implementation PackageDetailView
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.dishList = [[NSMutableArray<DishInfoObj *> alloc] init];
        NSLog(@"打包详情");
        //1.订单详情灰色背景图
        UIView * grayBackground = [[UIView alloc]init];
        grayBackground.backgroundColor = GLOBALGRAYCOLOR;
        grayBackground.layer.cornerRadius = 3;
        _grayBackground = grayBackground;
        [self addSubview:grayBackground];
        
        //2.订单号
        UILabel *orderIDLabel = [[UILabel alloc]init];
        orderIDLabel.text = [NSString stringWithFormat:@"%@：---",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderId"]];
        orderIDLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        _orderId = orderIDLabel;
        [grayBackground addSubview:orderIDLabel];
        
        //3.姓名
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.text = [NSString stringWithFormat:@"%@：---",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_name"]];
        nameLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        _name = nameLabel;
        [grayBackground addSubview:nameLabel];
        
        //4.电话
        UILabel *telephoneLabel = [[UILabel alloc]init];
        telephoneLabel.text = [NSString stringWithFormat:@"%@：---",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_telephone"]];
        _telephone = telephoneLabel;
        telephoneLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        [grayBackground addSubview:telephoneLabel];
        
        //5.下单时间
        UILabel *orderTimeLabel = [[UILabel alloc]init];
        orderTimeLabel.text = [NSString stringWithFormat:@"%@：--- ---",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderTime"]];
        orderTimeLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        _orderTime = orderTimeLabel;
        [grayBackground addSubview:orderTimeLabel];
        
        //6.取餐时间
        UILabel *pickUpTimeLabel = [[UILabel alloc]init];
        pickUpTimeLabel.text = [NSString stringWithFormat:@"%@：--- ---",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_pickUpTime"]];
        pickUpTimeLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        _pickTime = pickUpTimeLabel;
        [grayBackground addSubview:pickUpTimeLabel];
        
        //7.实际取餐时间
        UILabel *actuallTimeLabel = [[UILabel alloc]init];
        actuallTimeLabel.text = [NSString stringWithFormat:@"%@：--- ---",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_actuallPickUpTime"]];
        actuallTimeLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        _actualPickTime = actuallTimeLabel;
        [grayBackground addSubview:actuallTimeLabel];
        
        //8.服务员
        UILabel *waiterLabel = [[UILabel alloc]init];
        waiterLabel.text = [NSString stringWithFormat:@"%@：---",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_waiter"]];
        waiterLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        //        guestLabel.textAlignment = NSTextAlignmentRight;
        _waiter = waiterLabel;
        [grayBackground addSubview:waiterLabel];
        
        //9.菜品数量
        UILabel *dishesNumLabel = [[UILabel alloc]init];
        dishesNumLabel.text = [NSString stringWithFormat:@"%@：0",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_dishNum"]];
        dishesNumLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        dishesNumLabel.textColor = [UIColor redColor];
        _dishesNum = dishesNumLabel;
        [self addSubview:dishesNumLabel];
        
        //10.菜品table
        UIView * tableBackground = [[UIView alloc]init];
        tableBackground.backgroundColor = GLOBALGRAYCOLOR;
        tableBackground.layer.cornerRadius = 3;
        _tableBackground = tableBackground;
        [self addSubview:tableBackground];
    }
    return  self;
}

//重写layoutSubviews方法，父控件改变尺寸时调用该方法，父控件有了尺寸再设置子控件的尺寸
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat leftBlank = 15;
    CGFloat infoRowHeight = 35;
    
    _grayBackground.frame = CGRectMake(leftBlank, 0, selfWidth-2*leftBlank, infoRowHeight*7);
    
    _orderId.frame = CGRectMake(leftBlank, infoRowHeight*0, selfWidth-leftBlank, infoRowHeight);
    _name.frame = CGRectMake(leftBlank, infoRowHeight*1, selfWidth-leftBlank, infoRowHeight);
    _telephone.frame = CGRectMake(leftBlank, infoRowHeight*2, selfWidth-leftBlank, infoRowHeight);
    _orderTime.frame = CGRectMake(leftBlank, infoRowHeight*3, selfWidth-leftBlank, infoRowHeight);
    _pickTime.frame = CGRectMake(leftBlank, infoRowHeight*4, selfWidth-leftBlank, infoRowHeight);
    _actualPickTime.frame = CGRectMake(leftBlank, infoRowHeight*5, selfWidth-leftBlank, infoRowHeight);
    _waiter.frame = CGRectMake(leftBlank, infoRowHeight*6, selfWidth-leftBlank, infoRowHeight);
    
    CGFloat dishOffset = _grayBackground.frame.size.height + _grayBackground.frame.origin.y;
    _dishesNum.frame = CGRectMake(leftBlank, dishOffset, selfWidth-2*leftBlank, 40);
    
    CGFloat tableOffset = _dishesNum.frame.size.height + _dishesNum.frame.origin.y;
    CGFloat tableHeight = selfHeight - tableOffset - leftBlank;
    _tableBackground.frame = CGRectMake(leftBlank, tableOffset, selfWidth-2*leftBlank, tableHeight);
}

- (void)initTable{
    _dishesTable = [[UITableView alloc]init];
    _dishesTable.frame = CGRectMake(0, 15, _tableBackground.frame.size.width, _tableBackground.frame.size.height-15*2);
    _dishesTable.backgroundColor = GLOBALGRAYCOLOR;
    [_dishesTable registerClass:[DishListTableViewCell class] forCellReuseIdentifier:@"dishListCell"];
    _dishesTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _dishesTable.separatorColor = [UIColor clearColor];
    [_dishesTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    _dishesTable.bounces = NO;
    _dishesTable.delegate = self;
    _dishesTable.dataSource = self;
    [_tableBackground addSubview:_dishesTable];
}

- (void)changeOrderInfo:(PackageOrderDetailObj *)detail{
    NSLog(@"订单信息改变");
    
     _orderId.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderId"],detail.order_num];
    _name.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_name"],detail.customer];
    _telephone.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_telephone"],detail.phone];
    _orderTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderTime"],detail.make_order_time];
    _pickTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_pickUpTime"],detail.reserver_time];
    _actualPickTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_actuallPickUpTime"],detail.real_time];
    _waiter.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_waiter"],detail.waiter];
    
    self.dishList = detail.dish_list;
    NSLog(@"dish_list:%@",detail.dish_list);
    _dishesNum.text = [NSString stringWithFormat:@"%@：%lu",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_dishNum"],(unsigned long)[self.dishList count]];
    
    [self initTable];
}

#pragma mark - not complete package tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"菜单个数：%lu",(unsigned long)[self.dishList count]);
    return [self.dishList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dishListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = GLOBALGRAYCOLOR;
    DishInfoObj *info = [self.dishList objectAtIndex:indexPath.row];
    if (info) {
        cell.dishName.text = info.dish_name;
        cell.dishNum.text = [NSString stringWithFormat:@"%@%@",@"×",info.dish_number];
        cell.remarks.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_remarks"],info.dish_options];
    }
    return cell;
}

@end
