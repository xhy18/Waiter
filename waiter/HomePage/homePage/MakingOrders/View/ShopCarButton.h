//
//  ShopCarButton.h
//  waiter
//
//  Created by ltl on 2019/7/25.
//  Copyright © 2019 renxin. All rights reserved.
//  购物车加减按钮

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarButton : UIButton

//section
@property (nonatomic, assign) NSInteger section;
//row
@property (nonatomic, assign) NSInteger row;
//增减(1:增，-1:减)
@property (nonatomic, assign) int changeNum;

@end

NS_ASSUME_NONNULL_END
