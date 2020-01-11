//
//  serverManageModel.m
//  waiter
//
//  Created by renxin on 2019/7/16.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "serverManageModel.h"
#import "MyAFNetWorking.h"
#import "Header.h"
#import "SCBLoadingShareView.h"
@implementation serverManageModel
-(void)getAllWaiterList{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * page = @"1";
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shopId",page,@"page",nil];
        NSString * url = [NSString stringWithFormat:@"%@manager/WaiterInfo/",wbaseUrl];
        self.waiterInfoList = [[NSMutableArray<waiterInfo *> alloc]init];
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
//            NSLog(@"ResponseObject:%@",responseObject);
            for(NSDictionary * parDic in responseObject[@"data"][@"waiterList"]){
                
                waiterInfo * waiter = [[waiterInfo alloc]init];
               
                waiter.waiterId = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"waiterId"]];
                waiter.waiterName = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"waiterName"]];
                waiter.waiterTable= [NSString stringWithFormat:@"%@",[parDic objectForKey:@"waiterTable"]];
                waiter.waiterCode = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"qrCode"]];
                [self.waiterInfoList addObject:waiter];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_WaiterListFromServer" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){

        } OtherBlock:^(id other){

        }];
    });
}
-(void)deleteWaiterById:(NSString *) waiterId{
    [[SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",waiterId, @"waiter_id",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@manager/DeleteWaiter/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"delete:%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Delete_WaiterSuccess" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}
@end
