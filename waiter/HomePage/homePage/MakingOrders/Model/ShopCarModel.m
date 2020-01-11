//
//  ShopCarModel.m
//  waiter
//
//  Created by ltl on 2019/7/22.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel

- (void)InitShopCar{
    self.totalNum = 0;
    self.totalPrice = 0;
    self.shopCarSingleArray =  [[NSMutableArray alloc] init];
    self.shopCarSetMenuArray = [[NSMutableArray alloc] init];
}

- (void)AddSingleDishToShopcar:(ShopCarSingleObj *)dish{
    ShopCarSingleObj * singleDish = dish;
    BOOL flag = true;//true购物车中没有这道菜，否则有这道菜
    for(ShopCarSingleObj * tmp in self.shopCarSingleArray){
        //购物车中有这道菜
        if([singleDish.single_dish.dish_id isEqualToString:tmp.single_dish.dish_id] && [singleDish.single_dish.dish_option_string isEqualToString:tmp.single_dish.dish_option_string]){
            tmp.model_number++;
            tmp.single_dish_prices = tmp.model_number * tmp.single_dish.dish_price;
            flag = false;
            break;
        }
    }
    if(flag){
        [self.shopCarSingleArray addObject:singleDish];
    }
    self.totalNum = [self GetShopCarNum];
    self.totalPrice = [self GetShopCarTotalPrice];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addShopCar" object:nil];
}

- (void)AddSetMenuToShopcar:(ShopCarSetMenuObj *)dish{
    ShopCarSetMenuObj * setMenu = dish;
    BOOL flag = true;
    for(ShopCarSetMenuObj * tmp in self.shopCarSetMenuArray){
        //购物车中有这道菜
        if([setMenu.set_menu_id isEqualToString:tmp.set_menu_id]){
            if(setMenu.set_menu_dishes.count == tmp.set_menu_dishes.count){
                for( int i = 0 ; i < setMenu.set_menu_dishes.count; i++ ){
                    if( [setMenu.set_menu_dishes[i].dish_id isEqualToString:tmp.set_menu_dishes[i].dish_id] && [setMenu.set_menu_dishes[i].dish_option_string isEqualToString:tmp.set_menu_dishes[i].dish_option_string] ){
                        continue;
                    }else{
                        flag = false;
                        break;
                    }
                }
                if(flag){
                    tmp.model_number++;
                    tmp.set_menu_dish_prices = tmp.model_number * tmp.set_menu_price;
                    flag = false;
                    break;
                }
            }
        }
    }
    if(flag){
        [self.shopCarSetMenuArray addObject:setMenu];
    }
    self.totalNum = [self GetShopCarNum];
    self.totalPrice = [self GetShopCarTotalPrice];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addShopCar" object:nil];
}

- (void)addOrSubShopCar:(NSInteger)section row:(NSInteger)index state:(int)state{
    if(section == 0){
        //处理单点
        ShopCarSingleObj * single = self.shopCarSingleArray[index];
        if(state == 1){
            single.model_number++;
            single.single_dish_prices = single.model_number * single.single_dish.dish_price;
        }else{
            if(single.model_number > 1){
                single.model_number--;
                single.single_dish_prices = single.model_number * single.single_dish.dish_price;
            }else{
                [self.shopCarSingleArray removeObject:single];
            }
        }
    }
    if(section == 1){
        //处理套餐
        ShopCarSetMenuObj * setMenu = self.shopCarSetMenuArray[index];
        if(state == 1){
            setMenu.model_number++;
            setMenu.set_menu_dish_prices = setMenu.model_number * setMenu.set_menu_price;
        }else{
            if(setMenu.model_number > 1){
                setMenu.model_number--;
                setMenu.set_menu_dish_prices = setMenu.model_number * setMenu.set_menu_price;
            }else{
                [self.shopCarSetMenuArray removeObject:setMenu];
            }
        }
    }
    self.totalNum = [self GetShopCarNum];
    self.totalPrice = [self GetShopCarTotalPrice];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addShopCar" object:nil];
}

- (int)GetShopCarNum{
    int totalNum = 0;
    for(ShopCarSingleObj * dish in self.shopCarSingleArray){
        totalNum += dish.model_number;
    }
    for(ShopCarSetMenuObj * dish in self.shopCarSetMenuArray){
        totalNum += dish.model_number;
    }
    return totalNum;
}

- (double)GetShopCarTotalPrice{
    double totalPrice = 0;
    for(ShopCarSingleObj * dish in self.shopCarSingleArray){
        totalPrice += dish.single_dish_prices;
    }
    for(ShopCarSetMenuObj * dish in self.shopCarSetMenuArray){
        totalPrice += dish.set_menu_dish_prices;
    }
    return totalPrice;
}

- (void)shopCarToDictionary:(finalDishList)block{
    NSMutableArray * final = [[NSMutableArray alloc] init];
    
    if( self.shopCarSingleArray.count > 0){
        for( int i = 0 ; i < self.shopCarSingleArray.count ; i ++ ){
            ShopCarSingleObj * dic = self.shopCarSingleArray[i];
            NSMutableDictionary * tmp = [[NSMutableDictionary alloc] init];
            [tmp setValue:dic.model_category forKey:@"model_category"];
            [tmp setValue:[NSString stringWithFormat:@"%d",dic.model_number] forKey:@"model_number"];
            [tmp setValue:dic.pay_type forKey:@"pay_type"];
            [tmp setValue:[NSString stringWithFormat:@"%f",dic.set_menu_dish_prices] forKey:@"set_menu_dish_prices"];
            [tmp setValue:dic.set_menu_dishes_remarks forKey:@"set_menu_dishes_remarks"];
            [tmp setValue:[NSString stringWithFormat:@"%f", dic.set_menu_price] forKey:@"set_menu_price"];
            [tmp setValue:dic.set_menu_waiter_remark forKey:@"set_menu_waiter_remark"];
            [tmp setValue:[NSString stringWithFormat:@"%f", dic.single_dish_prices] forKey:@"single_dish_prices"];
            
            ShopCarAddDishObj * dish = dic.single_dish;
            NSMutableDictionary * tmpDish = [[NSMutableDictionary alloc] init];
            [tmpDish setValue:[NSString stringWithFormat:@"%f", dish.add_price] forKey:@"add_price"];
            [tmpDish setValue:dish.dish_id forKey:@"dish_id"];
            [tmpDish setValue:dish.dish_name forKey:@"dish_name"];
            [tmpDish setValue:dish.dish_option_id_list forKey:@"dish_option_id_list"];
            [tmpDish setValue:dish.dish_option_string forKey:@"dish_option_string"];
            [tmpDish setValue:[NSString stringWithFormat:@"%f", dish.dish_price] forKey:@"dish_price"];
            [tmpDish setValue:dish.dish_type forKey:@"dish_type"];
            [tmpDish setValue:dish.dish_waiter_remark forKey:@"dish_waiter_remark"];
            [tmpDish setValue:dish.isPay forKey:@"isPay"];
            [tmpDish setValue:dish.is_have_options forKey:@"is_have_options"];
            [tmpDish setValue:dish.is_selected forKey:@"is_selected"];
            
            [tmp setValue:tmpDish forKey:@"single_dish"];
            
            [final addObject:tmp];
        }
    }
    
    
    
    
//[ { "model_category": 1, "model_number": 1, "pay_type": 0, "set_menu_dish_prices": 0.01, "set_menu_dishes": [ ], "set_menu_dishes_remarks": "", "set_menu_id": "e37a6220-4ada-11e9-ba61-00163e01796f", "set_menu_name": "小炒口蘑饭", "set_menu_price": 0.01, "set_menu_waiter_remark": "", "single_dish_prices": 0 }]
    
//    NSMutableArray * b = [[NSMutableArray alloc] init];
//    NSDictionary * a = @{
//                         @"model_category":@"1",
//                         @"model_number":@"1",
//                         @"pay_type":@"0",
//                         @"set_menu_dish_prices":@"0.01",
//                         @"set_menu_dishes":b,
//                         @"set_menu_dishes_remarks":@"",
//                         @"set_menu_id":@"e37a6220-4ada-11e9-ba61-00163e01796f",
//                         @"set_menu_name":@"小炒口蘑饭",
//                         @"set_menu_price":@"0.01",
//                         @"set_menu_waiter_remark":@"",
//                         @"single_dish_prices":@"0"
//                         };
//   [final addObject:a];
    
    
    if( self.shopCarSetMenuArray.count > 0){
        for( int j = 0 ; j < self.shopCarSetMenuArray.count ; j++ ){
            ShopCarSetMenuObj * dic = self.shopCarSetMenuArray[j];
            NSMutableDictionary * tmp = [[NSMutableDictionary alloc] init];
            [tmp setValue:dic.model_category forKey:@"model_category"];
            [tmp setValue:[NSString stringWithFormat:@"%d",dic.model_number] forKey:@"model_number"];
            [tmp setValue:dic.pay_type forKey:@"pay_type"];
            [tmp setValue:[NSString stringWithFormat:@"%f", dic.set_menu_dish_prices] forKey:@"set_menu_dish_prices"];
            [tmp setValue:dic.set_menu_name forKey:@"set_menu_name"];
            [tmp setValue:[NSString stringWithFormat:@"%f", dic.set_menu_price] forKey:@"set_menu_price"];
            [tmp setValue:dic.set_menu_dishes_remarks forKey:@"set_menu_dishes_remarks"];
            [tmp setValue:dic.set_menu_id forKey:@"set_menu_id"];
            [tmp setValue:dic.set_menu_waiter_remark forKey:@"set_menu_waiter_remark"];
            [tmp setValue:[NSString stringWithFormat:@"%f", dic.single_dish_prices] forKey:@"single_dish_prices"];
            
            NSMutableArray<ShopCarAddDishObj *> * dish = dic.set_menu_dishes;
            NSMutableArray * set_menu_dishes = [[NSMutableArray alloc] init];
            for( ShopCarAddDishObj * setMenu in dish ){
                NSMutableDictionary * tmpDish = [[NSMutableDictionary alloc] init];
                [tmpDish setValue:[NSString stringWithFormat:@"%f", setMenu.add_price] forKey:@"add_price"];
                [tmpDish setValue:setMenu.dish_id forKey:@"dish_id"];
                [tmpDish setValue:setMenu.dish_name forKey:@"dish_name"];
                
                [tmpDish setValue:setMenu.dish_option_id_list forKey:@"dish_option_id_list"];
                [tmpDish setValue:setMenu.dish_option_string forKey:@"dish_option_string"];
                [tmpDish setValue:@[] forKey:@"dish_option_id_list"];
                [tmpDish setValue:@"" forKey:@"dish_option_string"];
                
                [tmpDish setValue:[NSString stringWithFormat:@"%f", setMenu.dish_price] forKey:@"dish_price"];
                [tmpDish setValue:setMenu.dish_type forKey:@"dish_type"];
                [tmpDish setValue:setMenu.dish_waiter_remark forKey:@"dish_waiter_remark"];
                [tmpDish setValue:setMenu.isPay forKey:@"isPay"];
                [tmpDish setValue:setMenu.is_have_options forKey:@"is_have_options"];
                [tmpDish setValue:setMenu.is_selected forKey:@"is_selected"];
                
                [set_menu_dishes addObject:tmpDish];
            }
            
            [tmp setValue:set_menu_dishes forKey:@"set_menu_dishes"];
            [final addObject:tmp];
        }
    }
    
    block(final);
}

@end
