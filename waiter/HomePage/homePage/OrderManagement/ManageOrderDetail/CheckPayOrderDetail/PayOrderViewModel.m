//
//  PayOrderViewModel.m
//  waiter
//
//  Created by renxin on 2019/7/26.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "PayOrderViewModel.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
@implementation PayOrderViewModel
-(void)GetDishPaymentInfoList:(NSString *) orderId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    self.paymentDishOrderList = [[NSMutableArray<paymentDishInfo *> alloc]init];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",orderId,@"order_id",@"1",@"language_id",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/ItemPayment/",wbaseUrl];
        NSLog(@"%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"response:%@",responseObject);
            for (NSDictionary * dic in responseObject[@"data"][@"dish_list"]) {
                paymentDishInfo * dishInfo = [[paymentDishInfo alloc]init];
                dishInfo.dishId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_id"]];
                dishInfo.dishName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_name"]];
                dishInfo.dishPrice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_price"]];
                dishInfo.dishType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_type"]];
                dishInfo.payStatus = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pay_status"]];
                dishInfo.orderNum = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"order_num"]];
                dishInfo.orderTable = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"table"]];
                [self.paymentDishOrderList addObject:dishInfo];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_PayDishDetailFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
@end
