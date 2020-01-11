//
//  MenuManageModel.m
//  waiter
//
//  Created by renxin on 2019/4/28.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "MenuManageModel.h"
#import "MyUtils.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"
@implementation MenuManageModel
//获取所有的菜单列表
-(void)GetAllMenuList{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * language = @"1";
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.theMenuArray = [[NSMutableArray <menuInfo *> alloc]init];//初始化菜单数组
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shopId",language,@"language",nil];
        NSString * url = [NSString stringWithFormat:@"%@item/GetShopMenuFlag/",wbaseUrl];
        //    NSLog(@"%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
//            NSLog(@"%@",responseObject);
            NSLog(@"菜单成功");
            for(NSDictionary * dic in responseObject[@"data"][@"flag_data"]){
                
                menuInfo * menu = [[menuInfo alloc]init];
                menu.menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flagId"]];
                menu.menuName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flagName"]];
                menu.menuType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag_type"]];
                menu.menuIsBuffet = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_about_buffet"]];
                menu.status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
                [self.theMenuArray addObject:menu];
                
                
            }
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_MenuFromServer" object:nil];
            [[ SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)changeMenuStatus:(NSString *)status ById:(NSString *)flagId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId  = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
     [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shopId",token, @"token",flagId ,@"flagId",status,@"newStatus",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@item/ChangeFlagStatus/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"delete:%@",responseObject);
            [[SCBLoadingShareView managerLoadView]dissmiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMenuStatus_Success" object:nil];
        }];
        
        
    });
}
//获取所有的菜品列表
-(void)GetAllDishList{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [defaults objectForKey:@"token"];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * language = @"1";
    [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.theDishArray = [[NSMutableArray <menuInfo *> alloc]init];//初始化菜单数组
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"token",shopId,@"shop_id",language,@"language_id",nil];
        NSString * url = [NSString stringWithFormat:@"%@item/GetShopItem/",wbaseUrl];
        //    NSLog(@"%@",parDic);
        [MyAFNetWorking GetHttpDataWithUrlStr:url Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"菜品成功");
            for(NSDictionary * dic in responseObject[@"data"][@"dish_list"]){
                
                menuInfo * dish = [[menuInfo alloc]init];
               
                dish.menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_id"]];
                dish.menuName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_name"]];
                dish.status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
                [self.theDishArray addObject:dish];

            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Get_DishFromServer" object:nil];
            [[SCBLoadingShareView managerLoadView]dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}
-(void)changeDishStatus:(NSString *)status ById:(NSString *)dishId{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId  = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
     [[ SCBLoadingShareView managerLoadView]showTheLoadView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * paramDic = [[NSDictionary alloc] initWithObjectsAndKeys:shopId, @"shopId",token, @"token",dishId ,@"dishId",status,@"newStatus",nil];
        
        NSString *url = [NSString stringWithFormat:@"%@item/ChangeItemStatus/",wbaseUrl];
        [MyAFNetWorking PostHttpDataWithUrlStr:url Dic:paramDic SuccessBlock:^(id responseObject) {
            NSLog(@"delete:%@",responseObject);
           [[SCBLoadingShareView managerLoadView]dissmiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeDishStatus_Success" object:nil];
        }];
        
        
    });
}
@end
