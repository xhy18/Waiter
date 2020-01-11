//
//  BWT_HistoryView.m
//  waiter
//
//  Created by Haze_z on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BWTHistoryView.h"
#import "Header.h"
#import "MyUtils.h"

@implementation BWTHistoryView

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
        self.historyDS = @[].mutableCopy;
        self.historyDS = dataArray.mutableCopy;
    }
    return self;
}

-(void)initUI{
    
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineView];
    
    self.DIYnavigationView = [[UIView alloc]init];
    self.DIYnavigationView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.DIYnavigationView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backButton.backgroundColor = [UIColor whiteColor];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[self.paltButton setTitle:@"+ Plat" forState:UIControlStateNormal];
    [self.DIYnavigationView addSubview:self.backButton];
    
    self.SearchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //        self.callWaiterButton.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
    //        self.callWaiterButton.layer.cornerRadius = 5.0;
    // CallWaiterImage
    [self.SearchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.DIYnavigationView addSubview:self.SearchButton];
    
    
    
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"历史记录";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [self.DIYnavigationView addSubview:self.titleLabel];
    
    
    self.HistoryTableView = [[UITableView alloc]init];
    self.HistoryTableView.backgroundColor = [UIColor redColor];
    self.HistoryTableView.delegate = self;
    self.HistoryTableView.dataSource = self;
    self.HistoryTableView.bounces = NO;
    self.HistoryTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.HistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.HistoryTableView];
    
}



-(void)layoutSubviews{
    

    self.SearchButton.frame = CGRectMake(self.frame.size.width - 50, 5, 40, 40);
    self.lineView.frame = CGRectMake(0, 1, self.frame.size.width, 1);
    self.DIYnavigationView.frame = CGRectMake(0, 1, self.frame.size.width, 50);
    self.titleLabel.frame = CGRectMake(80, 5, self.frame.size.width - 160, 40);
    self.backButton.frame = CGRectMake(2, 10, 30, 30);
    self.HistoryTableView.frame = CGRectMake(15, 50, SCREENWIDTH-30, SCREENHEIGHT-50);
    
    
    
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
   
    
    return self.historyDS.count;
//        return self.historyDS.count;
    
}
#pragma mark indexpath这行的 cell长什么样

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"historyData";
    UITableViewCell *cell = [_HistoryTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
//    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
//    NSDate * callDate = [dateFormatter dateFromString: _customCallDS[indexPath.row].send_time];
//    NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval nowSeconds = [nowDate timeIntervalSinceDate:callDate];
//    NSString * differTime = [NSString stringWithFormat:@"%d", (int)nowSeconds/60];
    
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)*3/4, 80)];
    leftView.layer.cornerRadius = 5.0f;
    leftView.layer.masksToBounds = YES;
    leftView.layer.borderWidth = 1.0f;
    leftView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    UILabel * tableName = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH/4, 30)];
    
    tableName.text = [NSString stringWithFormat:@"%@%@",[MyUtils GETCurrentLangeStrWithKey:@"serverManage_table"],_historyDS[indexPath.row].table];
    tableName.textColor = [UIColor blackColor];//[UIColor colorWithRed:24.0/255.0 green:120.0/255.0 blue:232.0/255.0 alpha:1];
    
    UILabel * WaiterName = [[UILabel alloc]initWithFrame:CGRectMake(15,tableName.frame.origin.y+tableName.frame.size.height, SCREENWIDTH/4, 30)];
    WaiterName.text = _historyDS[indexPath.row].waiter;
    WaiterName.font = [UIFont systemFontOfSize:14];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*3/4+5, 0, (SCREENWIDTH-30)/4-10, 80)];
    rightView.layer.cornerRadius = 5.0f;
    rightView.layer.masksToBounds = YES;
    rightView.layer.borderWidth = 1.0f;
    rightView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    
    UILabel * historyDataType = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)/4-10, 80)];
//    for(int i=0;i<indexPath.row;i++){
    if([_historyDS[indexPath.row].type isEqualToString:@"0"]){
        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_order"];
    }else if([_historyDS[indexPath.row].type isEqualToString:@"1"]){
        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_check"];
    }else if([_historyDS[indexPath.row].type isEqualToString:@"2"]){
        historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_call"];
    }else if ([_historyDS[indexPath.row].type isEqualToString:@"5"]){
         historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_delete"];
    }else{
         historyDataType.text = [MyUtils GETCurrentLangeStrWithKey:@"History_type_pay"];
}
    historyDataType.font = [UIFont systemFontOfSize:14];
    historyDataType.textAlignment = NSTextAlignmentCenter;
    if(indexPath.row%2 == 0){
        leftView.backgroundColor = GRAYCOLOR;
        rightView.backgroundColor = GRAYCOLOR;
        
    }else{
        leftView.backgroundColor = [UIColor whiteColor];
        rightView.backgroundColor = [UIColor whiteColor];
    }
    [leftView addSubview:WaiterName];
    [leftView addSubview:tableName];
    [rightView addSubview:historyDataType];
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
    [_getTipDelegate getTipData:_historyDS[indexPath.row].table];
}


//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//        BWTHistoryTableViewCell *cell = [_HistoryTableView dequeueReusableCellWithIdentifier:@"WaiterHistory"];
//        if(!cell){
//             cell = [[BWTHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WaiterHistory"];
//        }
//
//    cell.TestLabel.text = @"test";
//     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//
//       return cell;
//
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 34;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.001;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
