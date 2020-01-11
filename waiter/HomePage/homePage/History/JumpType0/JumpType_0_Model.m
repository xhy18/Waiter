//
//  JumpType_0_Model.m
//  waiter
//
//  Created by Haze_z on 2019/8/10.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_0_Model.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
#import "MyUtils.h"

@implementation JumpType_0_Model

-(void)GetManagerOrderDetail:(NSString *)orderId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",orderId,@"order_id",[MyUtils GetDishLanguageNumType],@"language_id",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/WaiterOrderInfoById/",wbaseUrl];
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"response:%@",responseObject);
            
                self.tableNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"table"]];
                self.personNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"number_of_people"]];
                self.orderNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"order_num"]];
                self.orderPrice = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"total_price"]];
            //
            //            self.dishInfo = @[].mutableCopy;
            //
            //            for (NSDictionary * dic in responseObject[@"data"][@"dish_list"]) {
            //                OrderDish * dish = [[OrderDish alloc]init];
            //                dish.dishType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"model_category"]];
            //                if([dish.dishType isEqualToString:@"0"]){
            //                    dish.dishName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_name"]];
            //                    dish.dishPrice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_name"]];
            //                    dish.dishNumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"model_number"]];
            //                    dish.dishTaste = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_option_list"]];
            //
            //                }else if([dish.dishType isEqualToString:@"1"]){
            //                    dish.dishName1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_name"]];
            //                    dishInfo.dishPrice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_price"]];
            //                    dishInfo.dishType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_type"]];
            //                    dishInfo.payStatus = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pay_status"]];
            //                    dishInfo.orderNum = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"order_num"]];
            //                    dishInfo.orderTable = [NSString stringWithFormat:@"%@",[responseObject[@"data"] objectForKey:@"table"]];
            //                }
            //                [self.paymentDishOrderList addObject:dishInfo];
            //            }
            //
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetOrderDish_Detail" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}



@end
