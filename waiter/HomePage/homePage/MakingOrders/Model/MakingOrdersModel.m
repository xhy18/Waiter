//
//  MakingOrdersModel.m
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
//  点餐model数据请求

#import "MakingOrdersModel.h"
#import "MyUtils.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "SCBLoadingShareView.h"


@implementation MakingOrdersModel

- (void)getShopDishMode{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"请求商家点餐模式");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 token,@"token",
                                 nil];
        NSLog(@"model模式字典%@",parDic);
        self.dishModeDic = [[NSMutableDictionary alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/OrderType/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model模式%@",responseObject);
            [self.dishModeDic setValue:responseObject[@"data"][@"is_support_set_menu"] forKey:@"support_set_menu"];
            [self.dishModeDic setValue:responseObject[@"data"][@"is_support_single_ordering"] forKey:@"support_single_ordering"];
            NSLog(@"model中商家模式%@",self.dishModeDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getShopDishMode" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getSingleDishClassification{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"请求单点分类");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * language = [MyUtils GetDishLanguageNumType];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 token,@"token",
                                 language,@"language_id",
                                 nil];
        NSLog(@"model单点分类%@",parDic);
        self.singleClassifyArray = [[NSMutableArray<SingleDishObj *> alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@item/SingleOrderClassify/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model单点%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"class_list"]){
                SingleDishObj * singleDish = [[SingleDishObj alloc]init];
                singleDish.class_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"class_id"]];
                singleDish.class_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"class_name"]];
                [self.singleClassifyArray addObject:singleDish];
            }
            NSLog(@"model中单点%@",self.singleClassifyArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getSingleList" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getSingleDish:(NSString *)classId{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"id获取单点菜品");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * language = [MyUtils GetDishLanguageNumType];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 token,@"token",
                                 language,@"language_id",
                                 classId,@"class_id",
                                 nil];
        NSLog(@"model菜品%@",parDic);
        self.singleDishArray = [[NSMutableArray<SingleDishObj *> alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@item/SingleItemByClassify/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model菜品%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"dish_list"]){
                SingleDishObj * singleDish = [[SingleDishObj alloc]init];
                singleDish.class_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"class_id"]];
                singleDish.class_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"class_name"]];
                singleDish.dish_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_id"]];
                singleDish.dish_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"dish_name"]];
                singleDish.dish_price = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_price"]] doubleValue];
                
                NSLog(@"原价：%@",[dic objectForKey:@"dish_price"]);
                NSLog(@"高精度：%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"dish_price"]]]);
                NSLog(@"转换价：%f",singleDish.dish_price);
                NSLog(@"double：%f",[[dic objectForKey:@"dish_price"] doubleValue]);
                
                singleDish.is_contain_options = [[dic objectForKey:@"is_contain_options"] boolValue];
                
                [self.singleDishArray addObject:singleDish];
            }
            NSLog(@"model中单点菜品%@",self.singleDishArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getSingleDishList" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getComboMenu{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"请求套餐");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * language = [MyUtils GetDishLanguageNumType];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 token,@"token",
                                 language,@"language_id",
                                 nil];
        NSLog(@"model套餐%@",parDic);
        self.setMenuArray = [[NSMutableArray<SetMenuObj *> alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@item/PackageInfo/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model套餐%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"set_menu_list"]){
                SetMenuObj * setMenu = [[SetMenuObj alloc]init];
                setMenu.set_menu_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"set_menu_id"]];
                setMenu.set_menu_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"set_menu_name"]];
                setMenu.set_menu_price = [[NSString stringWithFormat:@"%@", [dic objectForKey:@"set_menu_price"]] doubleValue];
                [self.setMenuArray addObject:setMenu];
            }
            NSLog(@"model中套餐%@",self.setMenuArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getSetMenuList" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getDishTaste:(NSString *)dishId{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"请求口味");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * language = [MyUtils GetDishLanguageNumType];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 token,@"token",
                                 language,@"language_id",
                                 dishId,@"dish_id",
                                 nil];
        NSLog(@"model口味%@",parDic);
        self.dishTasteArray = [[NSMutableArray<TasteTypeObj *> alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@item/ItemTaste/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model口味%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"type_list"]){
                TasteTypeObj * taste = [[TasteTypeObj alloc]init];
                taste.type_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"type_id"]];
                taste.type_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"type_name"]];
                taste.whether_to_multiple = [[dic objectForKey:@"whether_to_multiple"] boolValue];
                
                taste.option_item = [[NSMutableArray<optionItemObj *> alloc] init];
                for(NSDictionary * optionItem in [dic objectForKey:@"option_item"]){
                    optionItemObj * option = [[optionItemObj alloc]init];
                    option.item_id = [NSString stringWithFormat:@"%@", [optionItem objectForKey:@"item_id"]];
                    option.item_name = [NSString stringWithFormat:@"%@", [optionItem objectForKey:@"item_name"]];
                    [taste.option_item addObject:option];
                }
                
                [self.dishTasteArray addObject:taste];
            }
            NSLog(@"model中口味%@",self.dishTasteArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getDishTaste" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getSetMenu:(NSString *)setMenuId{
    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"请求套餐详情");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * language = [MyUtils GetDishLanguageNumType];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 token,@"token",
                                 language,@"language_id",
                                 setMenuId,@"set_menu_id",
                                 nil];
        NSLog(@"model套餐详情%@",parDic);
        self.setMenuDetailArray = [[NSMutableArray<SetMenuDetailObj *> alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@item/PackageItem/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"mode套餐详情%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"class_list"]){
                SetMenuDetailObj * setMenuDetail = [[SetMenuDetailObj alloc]init];
                setMenuDetail.class_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"class_id"]];
                setMenuDetail.class_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"class_name"]];
                setMenuDetail.max_select_number = [[NSString stringWithFormat:@"%@", [dic objectForKey:@"max_select_number"]] intValue];
                
                setMenuDetail.dish_list = [[NSMutableArray<SetMenuDishListObj *> alloc] init];
                for(NSDictionary * dishList in [dic objectForKey:@"dish_list"]){
                    SetMenuDishListObj * detail = [[SetMenuDishListObj alloc]init];
                    detail.add_price = [[NSString stringWithFormat:@"%@", [dishList objectForKey:@"add_price"]] doubleValue];
                    detail.dish_id = [NSString stringWithFormat:@"%@", [dishList objectForKey:@"dish_id"]];
                    detail.dish_name = [NSString stringWithFormat:@"%@", [dishList objectForKey:@"dish_name"]];
                    detail.is_contain_options = [[dishList objectForKey:@"is_contain_options"] boolValue];
                    [setMenuDetail.dish_list addObject:detail];
                }
                
                [self.setMenuDetailArray addObject:setMenuDetail];
            }
            NSLog(@"model中套餐详情%@",self.setMenuDetailArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getSetMenuDetailList" object:nil];
            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)getShopTableNumber{
//    [[SCBLoadingShareView managerLoadView] showTheLoadView];
    NSLog(@"请求桌号");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 shopId,@"shop_id",
                                 token,@"token",
                                 nil];
        NSLog(@"model桌号%@",parDic);
        self.tableNumArray = [[NSMutableArray alloc] init];
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/ShopTableNumber/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"mode桌号%@",responseObject);
            for(NSDictionary * dic in responseObject[@"data"][@"table_list"]){
                NSString * num = [NSString stringWithFormat:@"%@", [dic objectForKey:@"table_number"]];
                [self.tableNumArray addObject:num];
            }
            NSLog(@"model中桌号%@",self.tableNumArray);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getTableNum" object:nil];
//            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

- (void)postShopCarOrderdishList:(NSMutableArray *)dishList type:(NSString *)orderType table:(NSString *)tableNum people:(NSString *)peopleNum{
    NSLog(@"提交订单");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"token"];
        NSString * shopId = [defaults objectForKey:@"shopId"];
        NSString * waiterId = [defaults objectForKey:@"userId"];
        NSLog(@"waiterId-%@",waiterId);
        NSData * data=[NSJSONSerialization dataWithJSONObject:dishList options:kNilOptions error:nil];
        NSString * jsonDishList=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 orderType,@"order_type",
                                 shopId,@"shop_id",
                                 waiterId,@"waiter_id",
                                 tableNum,@"table",
                                 peopleNum,@"number_0f_people",
                                 token,@"token",
                                 jsonDishList,@"dish_list",
                                 nil];
        NSLog(@"model提交%@",parDic);
        [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@order/SubmitTakeOutOrderByWaiter/",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"model提交订单%@",responseObject);
            NSLog(@"model中提交订单%@",responseObject[@"res_message"]);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"submitSuccess" object:nil];
            //            [[SCBLoadingShareView managerLoadView] dissmiss];
        }FailedBlock:^(id error){
            NSLog(@"到底哪错了");
            NSLog(@"%@",error);
//            NSLog(@"%@",error);
//            NSData * a = error.userInfo[@"com.alamofire.error.serialization.response.error.data"];
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

@end
