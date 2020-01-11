//
//  OrderManageView.m
//  waiter
//
//  Created by renxin on 2019/7/22.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "OrderManageView.h"
#import "MyUtils.h"
#import "Header.h"
@interface OrderManageView(){
    int index;
}
@end
@implementation OrderManageView
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<NSMutableArray *> *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.tableView];
        self.userInteractionEnabled = YES;
        index = frame.origin.x/SCREENWIDTH;
        self.unconfirmOrderDS = @[].mutableCopy;
        if(index == 0){
            self.unconfirmOrderDS= dataArray.mutableCopy;
        }
        
        self.unpayOrderDS = @[].mutableCopy;
        if(index == 1){
            self.unpayOrderDS = dataArray.mutableCopy;
        }
    }
    return self;
    
}
-(UITableView *)tableView{
    if (_orderTableView == nil) {
        _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _orderTableView;
}
#pragma mark -- UITableViewDelegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(index == 0){
        return [self.unconfirmOrderDS count];
    }else{
        return [self.unpayOrderDS count];
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"orderCell";
    if (index == 0) {
        UITableViewCell *cell = [_orderTableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //桌号和服务员视图
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREENWIDTH-30, 48)];
        headView.backgroundColor = GRAYCOLOR;
        //桌号label
        UILabel * tableNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, (SCREENWIDTH-50)/2, 48)];
        tableNum.font = [UIFont boldSystemFontOfSize:14];
        //服务员label
        UILabel * tableWaiter = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)/2, 0, (SCREENWIDTH-50)/2, 48)];
        tableWaiter.font = [UIFont boldSystemFontOfSize:14];
        tableWaiter.textAlignment = NSTextAlignmentRight;
        
        //当前cell的数据结构
        NSMutableArray * currentArray = self.unconfirmOrderDS[indexPath.row];
        for(NSInteger i = 0;i<currentArray.count;i++){
            orderInfo * info = [currentArray objectAtIndex:i];
            tableNum.text = [NSString stringWithFormat:@"%@:%@",@"桌号",info.orderTable];
            tableWaiter.text = [NSString stringWithFormat:@"%@:%@",@"服务员",info.orderWaiter];
            //中间具体订单视图
            UIView * bodyView = [[UIView alloc]initWithFrame:CGRectMake(15, 50 + 50*i, SCREENWIDTH-30, 50)];
            bodyView.backgroundColor = GRAYCOLOR;
            bodyView.tag = i + 1000*indexPath.row;
            
            UILabel * dishNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)/2, 50)];
            dishNum.text =[NSString stringWithFormat:@"%@%@",info.dishNumber,@"道菜"];
            dishNum.font = [UIFont systemFontOfSize:14];
            dishNum.textColor = [UIColor grayColor];
            dishNum.textAlignment = NSTextAlignmentCenter;
            
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSTimeZone * zone = [NSTimeZone systemTimeZone];
            NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
            NSInteger nowInterval = [zone secondsFromGMTForDate:nowDate];
            NSDate * nowTime = [nowDate dateByAddingTimeInterval:nowInterval];
            
            NSDate * callDate = [dateFormatter dateFromString: info.orderTime];
            NSInteger orderInterval = [zone secondsFromGMTForDate: callDate];
            NSDate * callTime =[callDate dateByAddingTimeInterval:orderInterval];
            NSTimeInterval nowSeconds = [nowTime timeIntervalSinceDate:callTime];
            NSString * differTime = [NSString stringWithFormat:@"%d", (int)nowSeconds/60];

            UILabel * orderTime = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)/2, 0, (SCREENWIDTH-30)/2, 50)];
            orderTime.font = [UIFont systemFontOfSize:14];
            orderTime.textColor = [UIColor grayColor];
            orderTime.textAlignment = NSTextAlignmentCenter;
            orderTime.text = [NSString stringWithFormat:@"%@%@",differTime,@"min"];
            [bodyView addSubview:dishNum];
            [bodyView addSubview:orderTime];
            [cell.contentView addSubview:bodyView];
            UITapGestureRecognizer * bodyGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkOrderDetail:)];
            [bodyView addGestureRecognizer:bodyGesture];
            UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(15, bodyView.frame.origin.y+bodyView.frame.size.height+2, SCREENWIDTH-30, 48)];
            footView.backgroundColor = GRAYCOLOR;
            footView.tag = indexPath.row;
            UILabel * passLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH-30, 48)];
            passLabel.text = @"合单通过";
            passLabel.textAlignment = NSTextAlignmentCenter;
            passLabel.font = [UIFont systemFontOfSize:14];
            passLabel.textColor = [UIColor greenColor];
            [footView addSubview:passLabel];
            [cell.contentView addSubview:footView];
            UITapGestureRecognizer * passGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(InSinglePass:)];
            [footView addGestureRecognizer:passGesture];
        }
        
        [headView addSubview:tableNum];
        [headView addSubview:tableWaiter];
        [cell.contentView addSubview:headView];
        
        
        
        
        
        return cell;
        
    }else{
        UITableViewCell *cell = [_orderTableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //桌号和服务员视图
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREENWIDTH-30, 48)];
        headView.backgroundColor = GRAYCOLOR;
        //桌号label
        UILabel * tableNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, (SCREENWIDTH-50)/2, 48)];
        tableNum.font = [UIFont boldSystemFontOfSize:14];
        //服务员label
        UILabel * tableWaiter = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)/2, 0, (SCREENWIDTH-50)/2, 48)];
        tableWaiter.font = [UIFont boldSystemFontOfSize:14];
        tableWaiter.textAlignment = NSTextAlignmentRight;
        //当前cell的数据结构
        NSMutableArray * currentArray = self.unpayOrderDS[indexPath.row];

        for(NSInteger i = 0;i<currentArray.count;i++){
            orderInfo * info = [currentArray objectAtIndex:i];
        
            
            tableNum.text = [NSString stringWithFormat:@"%@:%@",@"桌号",info.orderTable];
            tableWaiter.text = [NSString stringWithFormat:@"%@:%@",@"服务员",info.orderWaiter];
            //中间具体订单视图
            UIView * bodyView = [[UIView alloc]initWithFrame:CGRectMake(15, 50 + 50*i, SCREENWIDTH-30, 50)];
            bodyView.backgroundColor = GRAYCOLOR;
            bodyView.tag = i + 1000*indexPath.row;
            
            UILabel * dishNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)/3, 50)];
            dishNum.text =[NSString stringWithFormat:@"%@%@",info.dishNumber,@"道菜"];
            dishNum.font = [UIFont systemFontOfSize:14];
            dishNum.textColor = [UIColor grayColor];
            dishNum.textAlignment = NSTextAlignmentCenter;
            
            UILabel * totalNum = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)/3, 0, (SCREENWIDTH-30)/3, 50)];
            totalNum.font = [UIFont systemFontOfSize:14];
            totalNum.textColor = [UIColor grayColor];
            totalNum.textAlignment = NSTextAlignmentCenter;
            totalNum.text = [NSString stringWithFormat:@"%.2f%@",atof(info.orderPrice.UTF8String),@"€"];
            
            UILabel * needPayNum = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*2/3, 0, (SCREENWIDTH-30)/3, 50)];
            needPayNum.font = [UIFont systemFontOfSize:14];
            needPayNum.textColor = [UIColor redColor];
            needPayNum.textAlignment = NSTextAlignmentCenter;
            needPayNum.text = [NSString stringWithFormat:@"%.2f%@",atof(info.orderPrice.UTF8String),@"€"];
            
            [bodyView addSubview:dishNum];
            [bodyView addSubview:totalNum];
            [bodyView addSubview:needPayNum];
            UITapGestureRecognizer * bodyGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkOrderManage:)];
            [bodyView addGestureRecognizer:bodyGesture];
            [cell.contentView addSubview:bodyView];
        }
        [headView addSubview:tableNum];
        [headView addSubview:tableWaiter];
        [cell.contentView addSubview:headView];
        return cell;
    }
    
    
}
#pragma mark--行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(index == 0){
        NSMutableArray * currentArray = [self.unconfirmOrderDS objectAtIndex:indexPath.row];
        NSInteger currentH = currentArray.count;
        return 110 + currentH*50;
    }
    else{
        NSMutableArray * currentArray = [self.unpayOrderDS objectAtIndex:indexPath.row];
        NSInteger currentH = currentArray.count;
        return 60 + currentH*50;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)checkOrderDetail:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    long table =tap.view.tag / 1000;
    long cell = tap.view.tag % 1000;
    orderInfo* orderInfo = _unconfirmOrderDS[table][cell];
    [self.selectDelegate CheckOrderDetailByOrderId:orderInfo.orderId];
//    NSLog(@"taag:%ld",tap.view.tag);
//    NSLog(@"cell:%ld",tap.view.tag % 1000);
//    NSLog(@"table:%ld",tap.view.tag/1000);
}
-(void)checkOrderManage:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    long table =tap.view.tag / 1000;
    long cell = tap.view.tag % 1000;
    orderInfo* orderInfo = _unpayOrderDS[table][cell];
    [self.selectDelegate ManageOrderByOrderId:orderInfo.orderId];
}
-(void)InSinglePass:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    orderInfo* orderInfo = _unconfirmOrderDS[tap.view.tag][0];
    [_selectDelegate PassTheOrderByTable:orderInfo.orderTable];
//    NSLog(@"PASS点击%@",orderInfo.orderTable);
}
-(void)reloadTable{
    [self.orderTableView reloadData];
}
@end
