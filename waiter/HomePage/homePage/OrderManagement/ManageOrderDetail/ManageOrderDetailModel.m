//
//  ManageOrderDetailModel.m
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ManageOrderDetailModel.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
@implementation ManageOrderDetailModel
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
            self.unpaymentDetail = responseObject[@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_UnpayOrderDetailFromServer" object:nil];
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
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"PassSingleOrder_Success" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}
@end
