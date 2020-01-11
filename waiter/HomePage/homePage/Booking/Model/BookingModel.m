//
//  BookingModel.m
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BookingModel.h"
#import "MyUtils.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
#import "SVProgressHUD.h"

@implementation BookingModel

//获取未完成预约订单
- (void)getNotFinishBookingData:(NSString *)page{
    if ( [page intValue] == 1) {
        [[SCBLoadingShareView managerLoadView] showTheLoadView];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 page,@"page",
                                 token,@"token",
                                 nil];
        NSLog(@"model未完成预约%@",parDic);
        if([page intValue] == 1){
            self.notFinishArray = [[NSMutableArray<BookingOrderObj *> alloc] init];
        }
        if([MyAFNetWorking NetWorkIsOK]){
            [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/ReserveOrderList/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                self.interStatus1 = @"internetSuccess";
                NSLog(@"model未完成预约%@",responseObject);
                NSMutableArray * bookingList = responseObject[@"data"][@"booking_list"];
                if(bookingList.count == 0 && [page intValue] != 1){
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"noMoreNotFinishNotification" object:nil];
                }else{
                    for(NSDictionary * dic in responseObject[@"data"][@"booking_list"]){
                        BookingOrderObj * notFinish = [[BookingOrderObj alloc]init];
                        notFinish.booking_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"booking_id"]];
                        notFinish.customer_num = [NSString stringWithFormat:@"%@", [dic objectForKey:@"customer_num"]];
                        notFinish.make_order_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"make_order_time"]];
                        notFinish.order_num = [NSString stringWithFormat:@"%@", [dic objectForKey:@"order_num"]];
                        notFinish.reserve_get_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"reserve_get_time"]];
                        notFinish.status = [[dic objectForKey:@"status"] intValue];
                        
                        [self.notFinishArray addObject:notFinish];
                    }
                    NSLog(@"model中未完成%@",self.notFinishArray);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getNotFinishBookingNotification" object:nil];
                }
                [[SCBLoadingShareView managerLoadView] dissmiss];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                self.interStatus1 = @"internetError";
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_getPackageOrderError"]];
            } InvalidBlock:^(id invalid){
                self.interStatus1 = @"internetError";
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                self.interStatus1 = @"internetError";
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        }else{
            self.interStatus1 = @"internetError";
            [[SCBLoadingShareView managerLoadView] dissmiss];
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
        }
    });
}

//获取已完成预约订单
- (void)getCompletedBookingData:(NSString *)page{
    if ( [page intValue] == 1) {
        [[SCBLoadingShareView managerLoadView] showTheLoadView];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 page,@"page",
                                 token,@"token",
                                 nil];
        NSLog(@"model已完成字典%@",parDic);
        if([page intValue] == 1){
            self.completedArray = [[NSMutableArray<BookingOrderObj *> alloc] init];
        }
        if([MyAFNetWorking NetWorkIsOK]){
            [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/ReserveOrderHistory/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                self.interStatus2 = @"internetSuccess";
                NSLog(@"model完成%@",responseObject);
                NSMutableArray * bookingList = responseObject[@"data"][@"booking_list"];
                if(bookingList.count == 0 && [page intValue] != 1){
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"noMoreCompletedNotification" object:nil];
                }else{
                    for(NSDictionary * dic in responseObject[@"data"][@"booking_list"]){
                        BookingOrderObj * completed = [[BookingOrderObj alloc]init];
                        completed.booking_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"booking_id"]];
                        completed.customer_num = [NSString stringWithFormat:@"%@", [dic objectForKey:@"customer_num"]];
                        completed.make_order_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"make_order_time"]];
                        completed.order_num = [NSString stringWithFormat:@"%@", [dic objectForKey:@"order_num"]];
                        completed.reserve_real_get_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"reserve_real_get_time"]];
                        completed.status = [[dic objectForKey:@"status"] intValue];
                        
                        [self.completedArray addObject:completed];
                    }
                    NSLog(@"model中的完成订单%@",self.completedArray);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getCompletedBookingNotification" object:nil];
                }
                [[SCBLoadingShareView managerLoadView] dissmiss];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                self.interStatus2 = @"internetError";
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_getPackageOrderError"]];
            } InvalidBlock:^(id invalid){
                self.interStatus2 = @"internetError";
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                self.interStatus2 = @"internetError";
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        }else{
            self.interStatus2 = @"internetError";
            [[SCBLoadingShareView managerLoadView] dissmiss];
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
        }
    });
}

- (void)getDetailOrderData:(NSString *)orderId{
    NSLog(@"请求详细订单数据%@",orderId);
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * order_id = orderId;
        NSString * language = [MyUtils GetDishLanguageNumType];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 order_id,@"order_id",
                                 token,@"token",
                                 language,@"language_id",
                                 nil];
        NSLog(@"model请求详细字典%@",parDic);
        self.bookingDetail = [[BookingOrderDetailObj alloc] init];
        self.bookingDetail.dish_list = [[NSMutableArray<DishInfoObj *> alloc] init];
        if([MyAFNetWorking NetWorkIsOK]){
            [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/ReserveInfo/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"model详细%@",responseObject);
                
                self.bookingDetail.customer = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"customer"]];
                self.bookingDetail.reserve_get_time = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"reserve_get_time"]];
                self.bookingDetail.make_order_time = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"make_order_time"]];
                self.bookingDetail.order_num = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"order_num"]];
                self.bookingDetail.phone = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"phone"]];
                self.bookingDetail.reserve_real_get_time = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"reserve_real_get_time"]];
                self.bookingDetail.status = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"status"]];
                
                self.bookingDetail.pay_by_wechat = [responseObject[@"data"][@"pay_by_wechat"] boolValue];

                for(NSDictionary * dic in responseObject[@"data"][@"dish_list"]){
                    DishInfoObj * dishInfo = [[DishInfoObj alloc]init];
                    dishInfo.dish_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_id"]];
                    dishInfo.dish_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_name"]];
                    dishInfo.dish_number = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_number"]];
                    dishInfo.dish_options = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_options"]];

                    [self.bookingDetail.dish_list addObject:dishInfo];
                }
                NSLog(@"model详细%@",self.bookingDetail);
                NSLog(@"model详细%@",self.bookingDetail.dish_list);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getBookingDetailNotification" object:nil];
                [[SCBLoadingShareView managerLoadView] dissmiss];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_getOrderDetailError"]];
            } InvalidBlock:^(id invalid){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        }else{
            [[SCBLoadingShareView managerLoadView] dissmiss];
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
        }
    });
}

- (void)cancelBookingOrder:(NSString *)orderId{
    NSLog(@"取消订单%@",orderId);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * order_id = orderId;
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 order_id,@"order_id",
                                 token,@"token",
                                 @"3",@"order_type",
                                 nil];
        NSLog(@"model取消字典%@",parDic);
        if([MyAFNetWorking NetWorkIsOK]){
            [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/TakeOutFlag4/",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"model取消%@",responseObject);
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"operateSuccess"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelOrderNotification" object:nil];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            } InvalidBlock:^(id invalid){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        }else{
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
        }
    });
}

- (void)printBookingOrder:(NSString *)orderId{
    NSLog(@"打印小票%@",orderId);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * order_id = orderId;
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 order_id,@"order_id",
                                 token,@"token",
                                 nil];
        NSLog(@"model打印小票%@",parDic);
        if([MyAFNetWorking NetWorkIsOK]){
            [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/ReserveOrderPrint/",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"model小票%@",responseObject);
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_printSuccess"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"printTicketNotification" object:nil];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_printFailed"]];
            } InvalidBlock:^(id invalid){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        }else{
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
        }
    });
}

- (void)confirmBookingOrder:(NSString *)orderId{
    NSLog(@"取餐%@",orderId);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * order_id = orderId;
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 order_id,@"order_id",
                                 token,@"token",
                                 nil];
        NSLog(@"model取餐%@",parDic);
        if([MyAFNetWorking NetWorkIsOK]){
            [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/ConfirmReserveorder/",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"model取餐%@",responseObject);
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_orderHaveFinished"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"scanBookingSuccessNotification" object:nil];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            } InvalidBlock:^(id invalid){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        }else{
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
        }
    });
}

#pragma mark - 管理：预约开关状态

- (void)getBookingStatus{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    if([MyAFNetWorking NetWorkIsOK]){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/ReserveStatusObtain/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"预约状态%@",responseObject);
                self.bookingSwitchStatus = [responseObject[@"data"][@"is_open"] boolValue];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getBookingStatusNotification" object:nil];
                [[SCBLoadingShareView managerLoadView] dissmiss];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_getServiceInfoError"]];
            } InvalidBlock:^(id invalid){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        });
    }else{
        [[SCBLoadingShareView managerLoadView] dissmiss];
        [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
    }
}

//开启预约
- (void)openBooking{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             @"true",@"new_open_status",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    if([MyAFNetWorking NetWorkIsOK]){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/ReserveStatusUpdate/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"open状态%@",responseObject);
                if([responseObject[@"res_code"] integerValue] == 0){
                    [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"operateSuccess"]];
                    self.bookingSwitchStatus = YES;
                }else{
                    self.bookingSwitchStatus = NO;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"openShopNSNotification" object:nil];
                [[SCBLoadingShareView managerLoadView] dissmiss];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_modifyFailed"]];
            } InvalidBlock:^(id invalid){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        });
    }else{
        [[SCBLoadingShareView managerLoadView] dissmiss];
        [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
    }
}

//关闭预约
- (void)closeBooking{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             @"false",@"new_open_status",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    if([MyAFNetWorking NetWorkIsOK]){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/ReserveStatusUpdate/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
                NSLog(@"guan状态%@",responseObject);
                NSLog(@"guan状态%@",responseObject[@"res_message"]);
                if([responseObject[@"res_code"] integerValue] == 0){
                    [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"operateSuccess"]];
                    self.bookingSwitchStatus = NO;
                }else{
                    self.bookingSwitchStatus = YES;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"closeBookingNotification" object:nil];
                [[SCBLoadingShareView managerLoadView] dissmiss];
            }FailedBlock:^(id error){
                NSLog(@"%@",error);
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_modifyFailed"]];
            } InvalidBlock:^(id invalid){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_tokenOutOfData"]];
            } OtherBlock:^(id other){
                [[SCBLoadingShareView managerLoadView] dissmiss];
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_operationError"]];
            }];
        });
    }else{
        [[SCBLoadingShareView managerLoadView] dissmiss];
        [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"Toast_internetError"]];
    }
}

@end
