//
//  PackagingManageModel.m
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//  打包管理model请求

#import "PackagingManageModel.h"
#import "MyUtils.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
#import "SVProgressHUD.h"

@implementation PackagingManageModel

- (void)getNotPackageData:(NSString *)page{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 page,@"page",
                                 token,@"token",
                                 nil];
        NSLog(@"model未打包%@",parDic);
        if([page intValue] == 1){
            NSLog(@"qingkong");
            self.notPackageArray = [[NSMutableArray<packageManage *> alloc] init];
        }
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/UnPrepareTakeOutList/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model未打包%@",responseObject);
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject[@"data"][@"package_list"] options:0 error:nil];
//            NSDictionary *packageList = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//            for(NSDictionary * dic in packageList){
            for(NSDictionary * dic in responseObject[@"data"][@"package_list"]){
                packageManage * notPackage = [[packageManage alloc]init];
                notPackage.package_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"package_id"]];
                notPackage.make_order_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"make_order_time"]];
                notPackage.reserve_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"reserve_time"]];
                notPackage.customer = [NSString stringWithFormat:@"%@", [dic objectForKey:@"customer"]];
                notPackage.status = [NSString stringWithFormat:@"%@", [dic objectForKey:@"status"]];
                notPackage.order_num = [NSString stringWithFormat:@"%@", [dic objectForKey:@"order_num"]];
                [self.notPackageArray addObject:notPackage];
            }
//            block(self.packageArray);
            NSLog(@"model中未打包%@",self.notPackageArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getAllNotPackageData" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getHasPackageData:(NSString *)page{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"请求完成的数据");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 page,@"page",
                                 token,@"token",
                                 nil];
        NSLog(@"model已打包字典%@",parDic);
        if([page intValue] == 1){
            NSLog(@"qingkong222");
            self.hasPackageArray = [[NSMutableArray<packageManage *> alloc] init];
        }
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/TakeOutHistoryList/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model打包%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"package_list"]){
                packageManage * notPackage = [[packageManage alloc]init];
                notPackage.package_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"package_id"]];
                notPackage.make_order_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"make_order_time"]];
                notPackage.reserve_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"reserve_time"]];
                notPackage.customer = [NSString stringWithFormat:@"%@", [dic objectForKey:@"customer"]];
                notPackage.real_time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"real_time"]];
                notPackage.order_num = [NSString stringWithFormat:@"%@", [dic objectForKey:@"order_num"]];
                [self.hasPackageArray addObject:notPackage];
            }
            NSLog(@"model中的历史订单%@",self.hasPackageArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getAllPackageData" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getDetailOrderData:(NSString *)orderId{
    NSLog(@"请求详细订单数据%@",orderId);
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
        self.packageDetail = [[PackageOrderDetailObj alloc] init];
        self.packageDetail.dish_list = [[NSMutableArray<DishInfoObj *> alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/TakeOutInfo/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model详细%@",responseObject);
            
            self.packageDetail.customer = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"customer"]];
            self.packageDetail.make_order_time = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"make_order_time"]];
            self.packageDetail.order_num = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"order_num"]];
            self.packageDetail.phone = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"phone"]];
            self.packageDetail.real_time = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"real_time"]];
            self.packageDetail.reserver_time = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"reserver_time"]];
            self.packageDetail.status = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"status"]];
            self.packageDetail.waiter = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"waiter"]];
            
            for(NSDictionary * dic in responseObject[@"data"][@"dish_list"]){
                DishInfoObj * dishInfo = [[DishInfoObj alloc]init];
                dishInfo.dish_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_id"]];
                dishInfo.dish_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_name"]];
                dishInfo.dish_number = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_number"]];
                dishInfo.dish_options = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_options"]];
                
                [self.packageDetail.dish_list addObject:dishInfo];
            }
            NSLog(@"model详细%@",self.packageDetail);
            NSLog(@"model详细%@",self.packageDetail.dish_list);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeDetailOrder" object:nil];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)cancelPackageOrder:(NSString *)orderId{
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
                                 nil];
        NSLog(@"model取消字典%@",parDic);
        [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/TakeOutFlag4/",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model取消%@",responseObject);
            //            NSLog(@"model详细%@",self.hasPackageArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"afterCancelTableData" object:nil];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)printPackageOrder:(NSString *)orderId{
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
        [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/TakeOutConfirmAndPrint/",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model小票%@",responseObject);
            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_printSuccess"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableData" object:nil];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)confirmPackageOrder:(NSString *)orderId{
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
        [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/TakeOutFlag3/",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model取餐%@",responseObject);
//            [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_printSuccess"]];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableData" object:nil];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

@end
