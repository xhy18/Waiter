//
//  CustomManageModel.m
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "CustomManageModel.h"
#import "Header.h"
#import "MyUtils.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
@implementation CustomManageModel
-(void)GetCustomCallList{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.customCallInfo = [[NSMutableArray <callInfo *> alloc]init];//初始化菜单数组
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",@"1",@"page",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/UserCallObtain/",wbaseUrl];
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
//            NSLog(@"%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"customer_tips_list"]){

                callInfo * call = [[callInfo alloc]init];
                call.send_time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"send_time"]];
                call.waiter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"waiter"]];
                call.tip_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"tip_id"]];
                call.table = [NSString stringWithFormat:@"%@",[dic objectForKey:@"table"]];
                [self.customCallInfo addObject:call];
            }
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_CallFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
@end
