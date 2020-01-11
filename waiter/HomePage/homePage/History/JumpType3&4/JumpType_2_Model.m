//
//  JumpType_2_Model.m
//  waiter
//
//  Created by Haze_z on 2019/8/9.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_2_Model.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"

@implementation JumpType_2_Model

-(void)GetOrderPaymentInfoList:(NSString *) orderId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    self.unpaymentDetail = [[NSDictionary alloc]init];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",orderId,@"order_id",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/OrderPaymentInfo/",wbaseUrl];
        NSLog(@"%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"response:%@",responseObject);
            self.payStatus = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"pay_status"]];
            self.unpaymentDetail = responseObject[@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_UnpayOrderDetail_FromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)PayOrderByOrderId:(NSString *) orderId{
    [[SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",orderId, @"order_id",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@order/OrderTotalPaid/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"pay:%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Pass_SingleOrder_Success" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}

-(void)HaveSeeByOrderId:(NSString *) orderId{
    [[SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",orderId, @"order_id",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@order/SecondConfirmByWaiter/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HaveSeen_Success" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}
@end
