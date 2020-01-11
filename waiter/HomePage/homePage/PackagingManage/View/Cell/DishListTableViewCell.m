//
//  DishListTableViewCell.m
//  waiter
//
//  Created by ltl on 2019/7/17.
//  Copyright © 2019 renxin. All rights reserved.
//  详情页菜品cell

#import "DishListTableViewCell.h"
#import "MyUtils.h"
#import "Header.h"
#define FONTSIZE 15

@implementation DishListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        //1.底部灰色背景图
        UIView * grayBackground = [[UIView alloc]init];
        grayBackground.backgroundColor = GLOBALGRAYCOLOR;
        _grayBackground = grayBackground;
        [self.contentView addSubview:grayBackground];
        
        //2.菜品名
        UILabel *dishName = [[UILabel alloc]init];
        dishName.font = [UIFont systemFontOfSize:FONTSIZE];
        _dishName = dishName;
        [_grayBackground addSubview:dishName];
        
        //3.菜品数量
        UILabel *dishNum = [[UILabel alloc]init];
        dishNum.textAlignment = NSTextAlignmentCenter;
        dishNum.font = [UIFont systemFontOfSize:FONTSIZE];
        _dishNum = dishNum;
        [_grayBackground addSubview:dishNum];
        
        //4.备注内容
        UILabel *remarks = [[UILabel alloc]init];
        remarks.font = [UIFont systemFontOfSize:13];
        _remarks = remarks;
        [_grayBackground addSubview:remarks];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    CGFloat blank = 15;
    CGFloat selfWidth = self.contentView.frame.size.width;
    CGFloat selfHeight = self.contentView.frame.size.height;
    
    _grayBackground.frame = CGRectMake(blank, 0, selfWidth-blank, selfHeight);
    
    _dishName.frame = CGRectMake(0, 0, _grayBackground.frame.size.width-60, selfHeight/2);
    _dishNum.frame = CGRectMake(_dishName.frame.size.width, 0, 60, selfHeight/2);
    
    _remarks.frame = CGRectMake(0, selfHeight/2, _grayBackground.frame.size.width, selfHeight/2);
    
}

@end
