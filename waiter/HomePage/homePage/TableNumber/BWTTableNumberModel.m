//
//  BWTTableNumberModel.m
//  waiter
//
//  Created by Haze_z on 2019/8/5.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BWTTableNumberModel.h"
#import "MyUtils.h"
#import "Header.h"
#import "SCBLoadingShareView.h"
#import "MyAFNetWorking.h"


@implementation BWTTableNumberModel

-(void)GetTableNumber{
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.tableInfo = [[NSMutableArray <TableNumber *> alloc]init];//初始化餐桌信息数组
        NSString * URL = @"http://47.254.133.83:4321/v1/order/ShopTableNumber/";
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * shopId  = [defaults objectForKey:@"shopId"];
        NSString * token = [defaults objectForKey:@"token"];
        NSLog(@"shopId:%@,token:%@",shopId,token);
       
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id" ,token,@"token",nil];
//        NSString * URL = @"http://47.254.133.83:4321/v1/order/ShopTableNumber/";//[NSString stringWithFormat:@"%@manager/ShopTableInfo/",baseUrl];
        
        [MyAFNetWorking GetHttpDataWithUrlStr:URL Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"TableNumResult:%@",responseObject);
            
           
            for(NSDictionary * Dic in responseObject[@"data"][@"table_list"]){
                
                TableNumber * data = [[TableNumber alloc]init];
                data.tableNum = [NSString stringWithFormat:@"%@",[Dic objectForKey:@"table_number"]];

                [self.tableInfo addObject:data];
//                NSLog(@"%@",data.tableNum);
                
            }
//            NSLog(@"%@",_tableInfo.count);
            NSLog(@"Test_Notification!!!");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_TableNumFromServer" object:nil];

            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
        }];

    });
 
}


-(void)GetTable_QRCode:(NSString *)table{
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * URL = [NSString stringWithFormat:@"%@manager/TableQRCodeObtain/",wbaseUrl];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * shopId  = [defaults objectForKey:@"shopId"];
        NSString * token = [defaults objectForKey:@"token"];
        NSLog(@"shopId:%@,token:%@",shopId,token);
        
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shop_id" ,token,@"token",table,@"table",nil];
        
        
        [MyAFNetWorking GetHttpDataWithUrlStr:URL Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"TableNumResult:%@",responseObject);
            
            NSString * tableStr = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"qrcode"]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_TableQRImageFromServer" object:nil];
            
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
        }];
        
    });
    
    
}



@end
