//
//  MyButton.h
//  waiter
//
//  Created by ltl on 2019/7/22.
//  Copyright © 2019 renxin. All rights reserved.
//  自定义button

#import <UIKit/UIKit.h>
#import "ShopCarAddDishObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyButton : UIButton

//-----选择套餐详情附加餐品用到的属性（用button代替cell记录菜品信息）-----
//所属section
@property (nonatomic, assign) NSInteger section;
//所属row
@property (nonatomic, assign) NSInteger row;
//菜品对象
@property (nonatomic, strong) ShopCarAddDishObj * addDishDetail;
//是否有口味
@property (nonatomic, assign) BOOL haveTaste;


//-----选择餐品口味用到的属性(循环生成按钮)-----
//口味id
@property (nonatomic, assign) NSString * item_id;
//口味名称
@property (nonatomic, assign) NSString * item_name;

@end

NS_ASSUME_NONNULL_END
