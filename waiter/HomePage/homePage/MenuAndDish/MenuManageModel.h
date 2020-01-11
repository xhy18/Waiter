//
//  MenuManageModel.h
//  waiter
//
//  Created by renxin on 2019/4/28.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "menuInfo.h"

//宏定义block:setMenuListArry
//typedef void (^setMenuListArry)(NSMutableArray<menuInfo *> * theMenuArray);
@interface MenuManageModel : NSObject
@property(nonatomic,strong)NSMutableArray <menuInfo *> * theMenuArray; //存放当前的菜单的数组
@property(nonatomic,strong)NSMutableArray <menuInfo *> * theDishArray;//存放当前的菜品的数组
-(void)GetAllMenuList;
-(void)changeMenuStatus:(NSString *)status ById:(NSString *)flagId;
-(void)GetAllDishList;
-(void)changeDishStatus:(NSString *)status ById:(NSString *)dishId;
@end



