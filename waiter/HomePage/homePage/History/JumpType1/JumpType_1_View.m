//
//  JumpType_1_View.m
//  waiter
//
//  Created by Haze_z on 2019/8/16.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_1_View.h"
#import "Header.h"
#import "MyUtils.h"
@implementation JumpType_1_View
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray singleDataArry:(NSMutableArray *)singleDataArry packDataArry:(NSMutableArray *)packDataArry{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
        self.dishDS = @[].mutableCopy;
        self.dishDS = dataArray.mutableCopy;
        self.singledishDS = @[].mutableCopy;
        self.singledishDS = singleDataArry.mutableCopy;
        self.packdishDS = @[].mutableCopy;
        self.packdishDS = packDataArry.mutableCopy;
    }
    return self;
}
-(void)initUI{
    
    self.tableDataView = [[UIView alloc]init];
    self.tableDataView.backgroundColor = GRAYCOLOR;
    [self addSubview:self.tableDataView];
    
    self.dishListView = [[UITableView alloc]init];
    self.dishListView.backgroundColor = GRAYCOLOR;
    self.dishListView.delegate = self;
    self.dishListView.dataSource = self;
    self.dishListView.bounces = NO;
    self.dishListView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.dishListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.dishListView];
    
    self.remarkView = [[UIView alloc]init];
    self.remarkView.backgroundColor = GRAYCOLOR;
    [self addSubview:self.remarkView];
    
    self.totalView = [[UIView alloc]init];
    self.totalView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.totalView];
    
    self.tableNum = [[UILabel alloc]init];
    self.tableNum.textAlignment = NSTextAlignmentLeft;
    self.tableNum.font = [UIFont boldSystemFontOfSize:16];
    [self.tableDataView addSubview:self.tableNum];
    
    self.orderNum = [[UILabel alloc]init];
    self.orderNum.textAlignment = NSTextAlignmentLeft;
    self.orderNum.font = [UIFont boldSystemFontOfSize:16];
    [self.tableDataView addSubview:self.orderNum];
    
    self.personNum = [[UILabel alloc]init];
    self.personNum.textAlignment = NSTextAlignmentRight;
    self.personNum.font = [UIFont boldSystemFontOfSize:16];
    [self.tableDataView addSubview:self.personNum];
    
    self.person = [[UIImageView alloc]init];
    self.person.image = [UIImage imageNamed:@"person"];
    self.person.backgroundColor = GRAYCOLOR;
    [self.tableDataView addSubview:self.person];
    
    
    self.remarkTF = [[UITextField alloc]init];
    self.remarkTF.backgroundColor = GRAYCOLOR;
    self.remarkTF.layer.borderColor = SHALLOWPURPLECOLOR.CGColor;
    self.remarkTF.layer.borderWidth = 1.0;
    self.remarkTF.layer.cornerRadius = 0.5;
    self.remarkTF.placeholder = [MyUtils changeLanguage:[MyUtils GetCurrentLanguage] strKey:@"PackageManage_remarks"];
    [self.remarkTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    self.remarkTF.delegate = self;
    self.remarkTF.keyboardType = UIKeyboardTypePhonePad;
    [self.remarkView addSubview:self.remarkTF];
    
    self.total = [[UILabel alloc]init];
    self.total.textAlignment = NSTextAlignmentCenter;
    self.total.font = [UIFont boldSystemFontOfSize:18];
    //    self.dishNum.text = [NSString stringWithFormat:@"%d%@",self.dishDS.count,[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_dishNum"]];
    [self.totalView addSubview:self.total];
    
    self.passBtn = [[UIButton alloc]init];
    self.passBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    self.passBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.passBtn.layer.cornerRadius = 28.0f;
    [self.passBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"order_confirm_pass"] forState:UIControlStateNormal];
    [self.passBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.passBtn addTarget:self action:@selector(confirmPayment) forControlEvents:UIControlEventTouchUpInside];
    [self.totalView addSubview:self.passBtn];
    
}

-(void)layoutSubviews{
    
    
    self.tableDataView.frame = CGRectMake(self.frame.size.width*0.05, 60, self.frame.size.width*0.9, self.frame.size.height*0.1);
    self.dishListView.frame = CGRectMake(self.frame.size.width*0.05, self.frame.size.height*0.19, self.frame.size.width*0.9, self.frame.size.height*0.5);
    self.remarkView.frame = CGRectMake(self.frame.size.width*0.05,self.frame.size.height*0.7 , self.frame.size.width*0.9, self.frame.size.height*0.1);
    self.totalView.frame = CGRectMake(self.frame.size.width*0.05,self.frame.size.height*0.81 , self.frame.size.width*0.9, self.frame.size.height*0.15);
    self.tableNum.frame = CGRectMake(20, 15, self.tableDataView.frame.size.width*0.5, self.tableDataView.frame.size.height*0.2);
    self.orderNum.frame = CGRectMake(20, 45, self.tableDataView.frame.size.width*0.3, self.tableDataView.frame.size.height*0.2);
    self.personNum.frame = CGRectMake(self.frame.size.width*0.57, 15, self.tableDataView.frame.size.width*0.3, self.tableDataView.frame.size.height*0.2);
    self.person.frame = CGRectMake(self.frame.size.width*0.73, 7, self.tableDataView.frame.size.width*0.08, self.tableDataView.frame.size.width*0.08);
    self.remarkTF.frame = CGRectMake(5, 5, self.tableDataView.frame.size.width*0.8, self.tableDataView.frame.size.height*0.8);
    self.total.frame = CGRectMake((self.totalView.frame.size.width - SCREENWIDTH*1/3)/2, self.totalView.frame.size.height*0.3, SCREENWIDTH*1/3, 20);
    self.passBtn.frame = CGRectMake((self.totalView.frame.size.width-SCREENWIDTH*2/3)/2, self.totalView.frame.size.height*0.5, SCREENWIDTH*2/3, 55);
    //
    
    
}
#pragma mark 有多少的section
//有几组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.dishDS.count;
    
    
    
}
#pragma mark indexpath这行的 cell长什么样

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"history_Dish_Data";
    UITableViewCell *cell = [_dishListView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    UIView * cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.9, 60)];
    cellView.layer.cornerRadius = 5.0f;
    cellView.layer.masksToBounds = YES;
    cellView.layer.borderWidth = 1.0f;
    cellView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    
    cellView.backgroundColor = GRAYCOLOR;
    
    UILabel * dishPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.45, 10, SCREENWIDTH/4, 20)];
    dishPrice.textAlignment = NSTextAlignmentRight;
    dishPrice.text = [NSString stringWithFormat:@"%@ €",_dishDS[indexPath.row].dishPrice];
    dishPrice.textColor = [UIColor blackColor];
    dishPrice.font = [UIFont systemFontOfSize:16];
    
    UILabel * dishNum = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.6, 10, SCREENWIDTH/4, 20)];
    dishNum.text = [NSString stringWithFormat:@"x %@",_dishDS[indexPath.row].dishNumber];
    dishNum.font = [UIFont systemFontOfSize:16];
    dishNum.textAlignment = NSTextAlignmentRight;
    
    UILabel * dishName = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, SCREENWIDTH/4, 20)];
    dishName.text = [NSString stringWithFormat:@"%@",_singledishDS[indexPath.row].dishName];
    dishName.font = [UIFont systemFontOfSize:16];
    dishName.textAlignment = NSTextAlignmentLeft;
    
    //    UILabel * historyDataType = [[UILabel alloc]init];
    //    if([_historyDS[indexPath.row].type isEqualToString:@"0"]){
    //        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_order"];
    //        historyDataType.frame =CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80);
    //    }else if([_historyDS[indexPath.row].type isEqualToString:@"1"]){
    //        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_check"];
    //        historyDataType.frame =CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80);
    //    }else if([_historyDS[indexPath.row].type isEqualToString:@"2"]){
    //        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_call"];
    //        historyDataType.frame =CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80);
    //    }else if([_historyDS[indexPath.row].type isEqualToString:@"3"]){
    //        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_pay"];
    //        historyDataType.frame =CGRectMake(0, 15, (SCREENWIDTH-30)/4-10, 80);
    //    }else if([_historyDS[indexPath.row].type isEqualToString:@"4"]){
    //        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_pay"];
    //        historyDataType.frame =CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80);
    //    }else if([_historyDS[indexPath.row].type isEqualToString:@"5"]){
    //        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_delete"];
    //        historyDataType.frame =CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80);
    //    }else{
    //        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_check"];
    //        historyDataType.frame =CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80);
    //    }
    //    historyDataType.font = [UIFont systemFontOfSize:13];
    //    historyDataType.textAlignment = NSTextAlignmentCenter;
    //
    //    UIImageView * waiterPayImg = [[UIImageView alloc]init];
    //    if([_historyDS[indexPath.row].type isEqualToString:@"3"]){
    //
    //        waiterPayImg.frame = CGRectMake(rightView.frame.size.width/4, rightView.frame.size.width/10, rightView.frame.size.width/2, rightView.frame.size.width/2);
    //        waiterPayImg.image = [UIImage imageNamed:@"person"];
    //    }else{
    //
    //    }
    
    
    
    [cellView addSubview:dishPrice];
    [cellView addSubview:dishNum];
    [cellView addSubview:dishName];
    
    [cell addSubview:cellView];
    return cell;
}
#pragma mark--行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
