//
//  OptionHistoryView.m
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "OptionHistoryView.h"
#import "Header.h"
#import "MyUtils.h"
@implementation OptionHistoryView

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
        self.waiterHistoryDS = @[].mutableCopy;
        self.waiterHistoryDS = dataArray.mutableCopy;
        NSLog(@"%@",self.waiterHistoryDS);
    }
    return self;
}
-(void)initUI{
    self.dealDetailTable = [[UITableView alloc]init];
    _dealDetailTable.delegate = self;
    _dealDetailTable.dataSource = self;
    _dealDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_dealDetailTable];
    
    self.dealBtn = [[UIButton alloc]init];
    _dealBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _dealBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _dealBtn.layer.cornerRadius = 30.0f;
    [_dealBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"customCall_processed"] forState:UIControlStateNormal];
    [_dealBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    [self addSubview:_dealBtn];
    [_dealBtn addTarget:self action:@selector(dealOrder) forControlEvents:UIControlEventTouchUpInside];
}
-(void)layoutSubviews{
    self.dealDetailTable.frame = CGRectMake(15, 10, SCREENWIDTH-30, SCREENHEIGHT-15);
    self.dealBtn.frame = CGRectMake(SCREENWIDTH/6, SCREENHEIGHT - 150, SCREENWIDTH*2/3, 60);

}
-(void)dealOrder{
    [_dealCallDelegate getTipData];
}
#pragma mark -- UITableViewDelegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.waiterHistoryDS.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"waiterHistory";
    UITableViewCell *cell = [_dealDetailTable dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)*3/4, 80)];
    leftView.layer.cornerRadius = 5.0f;
    leftView.layer.masksToBounds = YES;
    leftView.layer.borderWidth = 1.0f;
    leftView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    leftView.backgroundColor = GRAYCOLOR;
    
    UILabel * waiterName = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, (SCREENWIDTH-30)*3/4, 80)];
    waiterName.text = _waiterHistoryDS[indexPath.row].waiter;
    waiterName.font = [UIFont systemFontOfSize:14];
    waiterName.textAlignment = NSTextAlignmentLeft;


    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*3/4+5, 0, (SCREENWIDTH-30)/4-10, 80)];
    rightView.layer.cornerRadius = 5.0f;
    rightView.layer.masksToBounds = YES;
    rightView.layer.borderWidth = 1.0f;
    rightView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    rightView.backgroundColor = GRAYCOLOR;
    
    
    if([_waiterHistoryDS[indexPath.row].operateType isEqualToString:@"3"]){
        UILabel * oprateType = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, (SCREENWIDTH-30)/4-10, 30)];
        oprateType.font = [UIFont systemFontOfSize:14];
        oprateType.textAlignment = NSTextAlignmentCenter;
        oprateType.text = [MyUtils GETCurrentLangeStrWithKey:@"customCall_pay"];
        UIImageView * person =[[UIImageView alloc]initWithFrame:CGRectMake(((SCREENWIDTH-30)/4-10)/4, 10, ((SCREENWIDTH-30)/4-10)/2, 40)];
        person.image = [UIImage imageNamed:@"person"];
        [rightView addSubview:oprateType];
        [rightView addSubview:person];
    }
    else{
        UILabel * oprateType = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80)];
        oprateType.font = [UIFont systemFontOfSize:14];
        oprateType.textAlignment = NSTextAlignmentCenter;
        if([_waiterHistoryDS[indexPath.row].operateType isEqualToString:@"1"] || [_waiterHistoryDS[indexPath.row].operateType isEqualToString:@"5"]){
            
            oprateType.text = [MyUtils GETCurrentLangeStrWithKey:@"customCall_check"];
        }
        else if([_waiterHistoryDS[indexPath.row].operateType isEqualToString:@"0"]){
            
            oprateType.text = [MyUtils GETCurrentLangeStrWithKey:@"index_orderDish"];
        }
        else if([_waiterHistoryDS[indexPath.row].operateType isEqualToString:@"4"]){
            
            oprateType.text = [MyUtils GETCurrentLangeStrWithKey:@"customCall_pay"];
        }
        else{
            
        }
        [rightView addSubview:oprateType];
    }
    
    
    [leftView addSubview:waiterName];
    
    [cell addSubview:leftView];
    [cell addSubview:rightView];
    return cell;
}
#pragma mark--行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
