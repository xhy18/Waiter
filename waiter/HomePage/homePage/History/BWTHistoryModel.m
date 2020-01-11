//
//  BWTHistoryModel.m
//  waiter
//
//  Created by Haze_z on 2019/8/7.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BWTHistoryModel.h"
#import "Header.h"
#import "MyUtils.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"

@implementation BWTHistoryModel
-(void)GetHistoryList{
    
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSLog(@"shopId:%@,token:%@",shopId,token);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.historyInfo = [[NSMutableArray <WaiterHistory *> alloc]init];//初始化历史记录信息数组
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",@"1",@"page",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/OptionHistory/",wbaseUrl];
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"HistoryData:%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"history_list"]){
                
                WaiterHistory * data = [[WaiterHistory alloc]init];
                data.historyId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"history_id"]];
                data.waiter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"waiter"]];
                data.orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"order_id"]];
                data.table = [NSString stringWithFormat:@"%@",[dic objectForKey:@"table"]];
                data.type = [NSString stringWithFormat:@"%@",[dic objectForKey:@"operate_type"]];
                [self.historyInfo addObject:data];
                
            }
        
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_HistoryDataFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
@end
