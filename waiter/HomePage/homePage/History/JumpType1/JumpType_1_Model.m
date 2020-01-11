//
//  JumpType_1_Model.m
//  waiter
//
//  Created by Haze_z on 2019/8/16.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_1_Model.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
#import "MyUtils.h"

@implementation JumpType_1_Model
-(void)GetManagerOrderDetail:(NSString *)orderId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",orderId,@"order_id",[MyUtils GetDishLanguageNumType],@"language_id",nil];
        NSString * url = [NSString stringWithFormat:@"%@order/UnconfirmOrderInfo/",wbaseUrl];
        self.dishInfo = [[NSMutableArray <OrderDish *> alloc]init];//初始化历史记录信息数组
        if([MyAFNetWorking NetWorkIsOK]){
            [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"response:%@",responseObject);
//
//                self.tableNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"table"]];
//                self.personNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"number_of_people"]];
//                self.orderNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"order_num"]];
//                self.orderPrice = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"total_price"]];
//                self.checkStatus = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"is_checked"]];
//
//                self.dishDic = [[NSDictionary alloc]init];
//                for (self->_dishDic in responseObject[@"data"][@"dish_list"]) {
//                    OrderDish * dish = [[OrderDish alloc]init];
//
//                    dish.dishType = [NSString stringWithFormat:@"%@",self->_dishDic[@"model_category"]];
//                    dish.dishNumber = [NSString stringWithFormat:@"%@",self->_dishDic[@"model_number"]];
//                    dish.dishPrice = [NSString stringWithFormat:@"%@",self->_dishDic[@"single_dish_prices"]];
//                    dish.packdishPrice = [NSString stringWithFormat:@"%@",self->_dishDic[@"set_menu_dish_price"]];
//                    dish.packdishName = [NSString stringWithFormat:@"%@",self->_dishDic[@"set_menu_name"]];
//
//
//                    [self.dishInfo addObject:dish];
//
//                }
//
//                self.singledishInfo = [[NSMutableArray <OrderSingleDish *> alloc]init];//初始化历史记录信息数组
//                for(NSDictionary * sindic in responseObject[@"data"][@"dish_list"]){
//                    OrderSingleDish * dish = [[OrderSingleDish alloc]init];
//                    dish.dishName = [NSString stringWithFormat:@"%@",sindic[@"dish_name"]];
//                    //                    dish.dishTaste = [NSString stringWithFormat:@"%@",sindic[@"dish_option_list"]];
//
//                    [self.singledishInfo addObject:dish];
//                }
//
//                NSLog(@"kjhagbred!%@",self.dishInfo);
//
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"GetOrderDish_Detail" object:nil];
                [[ SCBLoadingShareView managerLoadView]dissmiss];
            }FailedBlock:^(id error){
                [[SCBLoadingShareView managerLoadView]dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_getHistoryError"]];//获取历史记录出错
            } InvalidBlock:^(id invalid){
                [[SCBLoadingShareView managerLoadView]dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];//token失效
            } OtherBlock:^(id other){
                [[SCBLoadingShareView managerLoadView]dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];//操作失败
            }];
        }else{
            [[SCBLoadingShareView managerLoadView]dissmiss];
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];//网络错误
        }
    });
}



@end
