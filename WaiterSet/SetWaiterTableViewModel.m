//
//  SetWaiterTableViewModel.m
//  waiter
//
//  Created by ltl on 2019/8/8.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "SetWaiterTableViewModel.h"
#import "SCBLoadingShareView.h"
#import "MyAFNetWorking.h"
#import "MyUtils.h"
#import "Header.h"

@implementation SetWaiterTableViewModel

- (void)getShopStatus{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    self.shopTime = [[NSString alloc] init];
    self.serviceTime = [[NSString alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/OpenCountObtain/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"开店状态%@",responseObject);
            if([responseObject[@"res_code"] integerValue] == 0){
                self.shopStatus = [responseObject[@"data"][@"is_open"] boolValue];
                self.shopTime = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"service_time"]];
                self.serviceTime = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"service_times"]];
//                BOOL state = [responseObject[@"data"][@"is_open"] boolValue];
//                if(state){
//                    self.switchBtn.on = YES;
//                }else{
//                    self.switchBtn.on = NO;
//                }
//                NSString * day = [self weekDayStr:responseObject[@"data"][@"service_time"]];
//                self.time.text = [NSString stringWithFormat:@"%@ %@ -service%@", day, responseObject[@"data"][@"service_time"], responseObject[@"data"][@"service_times"]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getShopStatus" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

//开店请求
- (void)openShop{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/OpenShopbyManager/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"open状态%@",responseObject);
            if([responseObject[@"res_code"] integerValue] == 0){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"operateSuccess"]];
                self.switchBtnStatus = YES;
            }else{
                self.switchBtnStatus = NO;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"openShop" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

//关店请求
- (void)closeShop{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/CloseShopbyManager/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"guan状态%@",responseObject);
            NSLog(@"guan状态%@",responseObject[@"res_message"]);
            if([responseObject[@"res_code"] integerValue] == 0){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"operateSuccess"]];
                self.switchBtnStatus = NO;
            }else{
                self.switchBtnStatus = YES;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"closeShop" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

//获取未支付订单
- (void)getNotPaidOrder{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/UnPayOrderNumber/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"未支付%@",responseObject);
            NSLog(@"未支付%@",responseObject[@"res_message"]);
            if([responseObject[@"res_code"] integerValue] == 0){
                if( [responseObject[@"data"][@"number"] integerValue] != 0){
                    self.notPaidOrder = true;
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getNoPaid" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

@end
