//
//  ViewControllerModel.m
//  waiter
//
//  Created by ltl on 2019/8/7.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "ViewControllerModel.h"
#import "MyUtils.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"

@implementation ViewControllerModel

- (void)getCustomManageNum{
    NSLog(@"请求呼叫");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * waiterId = [defaults objectForKey:@"userId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shopId",
                                 waiterId,@"waiterId",
                                 token,@"token",
                                 nil];
        NSLog(@"model呼叫%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/UnFinishedCallNeed/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model呼叫%@",responseObject);
            NSLog(@"model呼叫%@",responseObject[@"res_message"]);
            self.customManageNum = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"number"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCustomManageNum" object:nil];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getOrderManageNum{
    NSLog(@"请求订单");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * waiterId = [defaults objectForKey:@"userId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shopId",
                                 waiterId,@"waiterId",
                                 token,@"token",
                                 nil];
        NSLog(@"model订单%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/UnconfirmOrderNumber/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model订单%@",responseObject);
            NSLog(@"model订单%@",responseObject[@"res_message"]);
            self.orderManageNum = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"number"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOrderManageNum" object:nil];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getPackageNum{
    NSLog(@"请求打包");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * waiterId = [defaults objectForKey:@"userId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shopId",
                                 waiterId,@"waiterId",
                                 token,@"token",
                                 nil];
        NSLog(@"model打包%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/UnTakeoutOrderNumber/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model打包%@",responseObject);
            NSLog(@"model打包%@",responseObject[@"res_message"]);
            self.packageNum = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"number"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changePackageNum" object:nil];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

@end
