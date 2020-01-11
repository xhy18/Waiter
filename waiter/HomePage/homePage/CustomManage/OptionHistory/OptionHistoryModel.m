//
//  OptionHistoryModel.m
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "OptionHistoryModel.h"
#import "Header.h"
#import "MyUtils.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
@implementation OptionHistoryModel
-(void)getWaiterHistoryList:(NSString *)tableName{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.waiterHistoryData = [[NSMutableArray <waiterHistory *> alloc]init];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",tableName,@"table",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/WaiterHistoryByTable/",wbaseUrl];
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
//            NSLog(@"RESPONSE%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"history_list"]){
                
                waiterHistory * history = [[waiterHistory alloc]init];
                history.historyId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"history_id"]];
                history.operateType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"operate_type"]];
                history.orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"order_id"]];
                history.table = [NSString stringWithFormat:@"%@",[dic objectForKey:@"table"]];
                history.waiter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"waiter"]];

                [self.waiterHistoryData addObject:history];
            }

            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_WaiterHistoryFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)dealCustomCall:(NSString *)table{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",table,@"table",nil];
        NSLog(@"PARAM:%@",paramDic);
        NSString *url = [NSString stringWithFormat:@"%@order/AnswerCall/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
                        NSLog(@"deal%@",responseObject[@"res_message"]);
            [[SCBLoadingShareView managerLoadView]dissmiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DealCustomCall_Success" object:nil];
        }];
        
        
    });
}
@end
