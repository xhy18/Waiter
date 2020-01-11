//
//  CheckOrderDetailModel.m
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "CheckOrderDetailModel.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
@implementation CheckOrderDetailModel
-(void)GetOrderDetailList:(NSString *) orderId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",@"1",@"language_id",orderId,@"order_id",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/UnconfirmOrderInfo/",wbaseUrl];
            NSLog(@"%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"订单详情%@",responseObject[@"data"]);
            self.unconfirmOrderInfoList = [[NSMutableArray<unconfirmOrderInfo *> alloc]init];
                for (NSDictionary * dic in responseObject[@"data"][@"dish_list"]) {
                    unconfirmOrderInfo * orderInfo = [[unconfirmOrderInfo alloc]init];
                    orderInfo.average_consume = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"average_consume"]];
                    orderInfo.consume_times = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"consume_times"]];
                    orderInfo.customer = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"customer"]];
                    orderInfo.isAboutWaiter = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"is_about_waiter"]];
                    orderInfo.orderTime = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"make_order_time"]];
                    orderInfo.orderNum = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"order_num"]];
                    orderInfo.orderTable = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"table"]];

                    orderInfo.dishId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_id"]];
                    orderInfo.dishName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_name"]];
                    orderInfo.dishNumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_number"]];
                    orderInfo.dishOptions = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_options"]];
                    [self.unconfirmOrderInfoList addObject:orderInfo];
                }
            NSLog(@"待通过订单成功%lu",(unsigned long)self->_unconfirmOrderInfoList.count);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_UnconfirmOrderDetailFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)PassOrderByOrderId:(NSString *) orderId{
    [[SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",orderId, @"order_id",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@order/OrderConfirm/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"reject:%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PassSingleOrder_Success" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}
-(void)RefuseOrderByOrderId:(NSString *) orderId{
    [[SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
  
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",orderId, @"order_id",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@order/RejectOrder/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"reject:%@",responseObject);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefuseOrder_Success" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}
-(void)RefuseOrderAndDish:(NSString *) orderId DishArray:(NSMutableArray<NSDictionary *>*) dishArray{
    [[SCBLoadingShareView managerLoadView]showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dishArray options:kNilOptions error:nil];
    NSString *dishArrayJsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id",token, @"token",orderId, @"order_id",dishArrayJsonStr,@"lack_dishes",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@order/RejectOrderAndItem/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
                        NSLog(@"reject:%@",responseObject);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"PassOrder_Success" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }];
        
        
    });
}
@end
