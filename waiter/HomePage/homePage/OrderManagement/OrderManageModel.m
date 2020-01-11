//
//  OrderManageModel.m
//  waiter
//
//  Created by renxin on 2019/7/22.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "OrderManageModel.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
@implementation OrderManageModel

-(void)GetUnconfirmOrderList{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        self.orderInfoList = [[NSMutableArray<orderInfo *> alloc]init];
        self.theOrderArray = [[NSMutableArray<NSMutableArray *> alloc]init];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",@"1",@"page",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/UnconfirmOrderList/",wbaseUrl];
        //    NSLog(@"%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
//                        NSLog(@"daitongguo%@",responseObject);
//            NSLog(@"待通过订单成功");
            
            for(NSDictionary * dic in responseObject[@"data"][@"order_list"]){
                self.orderInfoList = [[NSMutableArray<orderInfo *> alloc]init];
                for (NSDictionary * dic1 in dic[@"orders"]) {
                    orderInfo * orderTable = [[orderInfo alloc]init];
                    orderTable.orderTable = [NSString stringWithFormat:@"%@",[dic objectForKey:@"table"]];
                    orderTable.orderWaiter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"waiter"]];
                    orderTable.orderId = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"order_id"]];
                    orderTable.orderTime = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"submit_order_time"]];
                    orderTable.dishNumber = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"number_of_dishes"]];
                    [self.orderInfoList addObject:orderTable];
                }
                [self.theOrderArray addObject:self.orderInfoList];
            }
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_UnconfirmOrderFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)GetUnpayOrderList{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.unpayOrderArray = [[NSMutableArray<NSMutableArray *> alloc]init];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",@"1",@"page",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/UnpayOrderList/",wbaseUrl];
        //    NSLog(@"%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
//                        NSLog(@"daizhifu%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"order_list"]){
                self.unpayOrderInfoList = [[NSMutableArray<orderInfo *> alloc]init];
                for (NSDictionary * dic1 in dic[@"orders"]) {
                    orderInfo * orderTable = [[orderInfo alloc]init];
                    orderTable.orderTable = [NSString stringWithFormat:@"%@",[dic objectForKey:@"table"]];
                    orderTable.orderWaiter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"waiter"]];
                    orderTable.orderId = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"order_id"]];
                    orderTable.orderTime = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"submit_order_time"]];
                    orderTable.dishNumber = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"number_of_dishes"]];
                    orderTable.orderOnlinePay =[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"online_pay_amount"]];
                    orderTable.orderRemainPay =[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"remain_pay_amount"]];
                    orderTable.orderPrice =[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"price"]];
                    [self.unpayOrderInfoList addObject:orderTable];
                }
                [self.unpayOrderArray addObject:self.unpayOrderInfoList];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_UnpayOrderListFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)PassOrderByTable:(NSString *)orderTable{
    [[SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",orderTable, @"table",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@order/JointOrderConfirm/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
//            NSLog(@"delete:%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PassOrder_Success" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}
@end
