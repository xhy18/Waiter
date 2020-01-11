//
//  CustomManageView.m
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "CustomManageView.h"
#import "Header.h"
#import "MyUtils.h"
@implementation CustomManageView

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
        self.customCallDS = @[].mutableCopy;
        self.customCallDS = dataArray.mutableCopy;
    }
    return self;
}
-(void)initUI{
    self.callShowTable = [[UITableView alloc]init];
    _callShowTable.delegate = self;
    _callShowTable.dataSource = self;
    _callShowTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_callShowTable];
}
-(void)layoutSubviews{
    self.callShowTable.frame = CGRectMake(15, 10, SCREENWIDTH-30, SCREENHEIGHT-15);
}
#pragma mark -- UITableViewDelegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.customCallDS.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"customCall";
    UITableViewCell *cell = [_callShowTable dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSDate * callDate = [dateFormatter dateFromString: _customCallDS[indexPath.row].send_time];
    NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowSeconds = [nowDate timeIntervalSinceDate:callDate];
    NSString * differTime = [NSString stringWithFormat:@"%d", (int)nowSeconds/60];
    
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)*3/4, 80)];
    leftView.layer.cornerRadius = 5.0f;
    leftView.layer.masksToBounds = YES;
    leftView.layer.borderWidth = 1.0f;
    leftView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    UILabel * tableName = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH/4, 30)];
    
    tableName.text = [NSString stringWithFormat:@"%@%@",[MyUtils GETCurrentLangeStrWithKey:@"serverManage_table"],_customCallDS[indexPath.row].table];
//    tableName.font = [UIFont systemFontOfSize:14];
    tableName.textColor = [UIColor colorWithRed:24.0/255.0 green:120.0/255.0 blue:232.0/255.0 alpha:1];
    
    UILabel * WaiterName = [[UILabel alloc]initWithFrame:CGRectMake(15,tableName.frame.origin.y+tableName.frame.size.height, SCREENWIDTH/4, 30)];
    if([_customCallDS[indexPath.row].waiter isEqualToString:@""]){
        WaiterName.text = @"---";
    }
    else{
        WaiterName.text = _customCallDS[indexPath.row].waiter;
    }
    WaiterName.font = [UIFont systemFontOfSize:14];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*3/4+5, 0, (SCREENWIDTH-30)/4-10, 80)];
    rightView.layer.cornerRadius = 5.0f;
    rightView.layer.masksToBounds = YES;
    rightView.layer.borderWidth = 1.0f;
    rightView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    
    UILabel * tableTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80)];
    tableTime.text = [NSString stringWithFormat:@"%@%@",differTime,@"min"];
    tableTime.font = [UIFont systemFontOfSize:14];
    tableTime.textAlignment = NSTextAlignmentCenter;
    if(indexPath.row%2 == 0){
        leftView.backgroundColor = GRAYCOLOR;
        rightView.backgroundColor = GRAYCOLOR;

    }else{
        leftView.backgroundColor = [UIColor whiteColor];
        rightView.backgroundColor = [UIColor whiteColor];
    }
    [leftView addSubview:WaiterName];
    [leftView addSubview:tableName];
    [rightView addSubview:tableTime];
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
    [_getTipDelegate getTipData:_customCallDS[indexPath.row].table];
}
@end
