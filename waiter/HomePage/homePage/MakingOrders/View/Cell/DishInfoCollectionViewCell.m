//
//  DishInfoCollectionViewCell.m
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
// 

#import "DishInfoCollectionViewCell.h"

@implementation DishInfoCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        //1.菜品名
        UILabel * dishName = [[UILabel alloc] init];
        dishName.frame = CGRectMake(0, 10, self.frame.size.width, self.frame.size.height*0.65-10);
        dishName.textAlignment = NSTextAlignmentCenter;
        dishName.textColor = [UIColor blackColor];
        dishName.font = [UIFont systemFontOfSize:14];
        dishName.numberOfLines = 0;
        _dishName = dishName;
        [self.contentView addSubview:dishName];
        
        //2.菜品价格
        UILabel * dishPrice = [[UILabel alloc] init];
        dishPrice.frame = CGRectMake(0, self.frame.size.height*0.65, self.frame.size.width, self.frame.size.height*0.35);
        dishPrice.textAlignment = NSTextAlignmentCenter;
        dishPrice.textColor = [UIColor grayColor];
        dishPrice.font = [UIFont systemFontOfSize:13];
        _dishPrice = dishPrice;
        [self.contentView addSubview:dishPrice];
        
    }
    return self;
}

@end
