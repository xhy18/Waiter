//
//  ModifyServiceModel.m
//  waiter
//
//  Created by renxin on 2019/7/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ModifyServiceModel.h"
#import "Header.h"
#import "SCBLoadingShareView.h"

@implementation ModifyServiceModel
-(void)GetTableInformation{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    self.tableInfo = [[NSMutableArray<waiterTable *> alloc]init];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shopId",nil];
        NSString * url = [NSString stringWithFormat:@"%@manager/ShopTableInfo/",wbaseUrl];
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            
            for(NSDictionary * parDic in responseObject[@"data"][@"tableList"]){
                
                waiterTable * table = [[waiterTable alloc]init];
                
                table.tableId = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"tableId"]];
                table.tableName = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"tableName"]];
                table.selectedTable= [NSString stringWithFormat:@"%@",[parDic objectForKey:@"isSelected"]];
                [self.tableInfo addObject:table];
            }
//             NSLog(@"ResponseObject:%@",self.tableInfo);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_TableInformation" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)GetTableInfoByWaiterId:(NSString *)waiterId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    self.tableWaiterInfo = [[NSMutableArray<waiterTable *> alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shopId",waiterId,@"waiterId",nil];
        NSString * url = [NSString stringWithFormat:@"%@manager/ShopTableForWaiter/",wbaseUrl];
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            for(NSDictionary * parDic in responseObject[@"data"][@"tableList"]){
                
                waiterTable * table = [[waiterTable alloc]init];
                
                table.tableId = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"tableId"]];
                table.tableName = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"tableName"]];
                table.selectedTable= [NSString stringWithFormat:@"%@",[parDic objectForKey:@"isSelected"]];
                table.currentSelected = [NSString stringWithFormat:@"%@",[parDic objectForKey:@"isCurrentWaiterSelected"]];
                [self.tableWaiterInfo addObject:table];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_TableInfoByWaiterId" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)updateWaiterInfo:(NSMutableArray<NSDictionary *>*)waiterTable nameInfo:(NSString *)waiterName idInfo:(NSString *)waiterId type:(NSString *)type{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:waiterTable options:kNilOptions error:nil];
    NSString *waiterTableJsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shopId",token, @"token",waiterId, @"waiterId",waiterName,@"waiterName",waiterTableJsonStr,@"waiterTable",type,@"type",nil];
        NSString *url = [NSString stringWithFormat:@"%@manager/UpdateWaiterTable/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            [[SCBLoadingShareView managerLoadView]dissmiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateWaiterSuccess" object:nil];
        }];
        
        
    });
}
-(void)addWaiterInfo:(NSMutableArray<NSDictionary *>*)waiterTable nameInfo:(NSString *)waiterName{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:waiterTable options:kNilOptions error:nil];
    NSString *waiterTableJsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shopId",token, @"token",waiterName,@"waiterName",waiterTableJsonStr,@"waiterTable",nil];
        NSLog(@"PARAM:%@",paramDic);
        NSString *url = [NSString stringWithFormat:@"%@manager/AddWaiterTable/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
//            NSLog(@"d:%@",responseObject[@"res_message"]);
            [[SCBLoadingShareView managerLoadView]dissmiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddWaiterSuccess" object:nil];
        }];
        
        
    });
}
@end
