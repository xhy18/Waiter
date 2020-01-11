//
//  BookingTableViewCell.m
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BookingTableViewCell.h"
#import "MyUtils.h"
#import "Header.h"
#define FONTSIZE 16

@implementation BookingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //1.底部灰色背景图
        UIView * grayBackground = [[UIView alloc]init];
        grayBackground.backgroundColor = GLOBALGRAYCOLOR;
        grayBackground.layer.cornerRadius = 3;
//        grayBackground.layer.shadowColor = [UIColor grayColor].CGColor;
//        grayBackground.layer.shadowOpacity = 0.3;
//        grayBackground.layer.shadowOffset = CGSizeMake(0, 1);
        _grayBackground = grayBackground;
        [self.contentView addSubview:_grayBackground];
        
        //2.订单号行
        UILabel * orderId = [[UILabel alloc]init];
        orderId.text = @"";
//        orderId.backgroundColor = [UIColor redColor];
        orderId.font = [UIFont systemFontOfSize:FONTSIZE];
        _orderId = orderId;
        [_grayBackground addSubview:_orderId];
        
        //3.就餐人数
        UILabel * numberOfPeople = [[UILabel alloc]init];
        numberOfPeople.text = @"";
//        numberOfPeople.backgroundColor = [UIColor greenColor];
        numberOfPeople.font = [UIFont systemFontOfSize:FONTSIZE];
        _numberOfPeople = numberOfPeople;
        [_grayBackground addSubview:_numberOfPeople];
        
        //4.就餐时间
        UILabel * bookingTime = [[UILabel alloc]init];
        bookingTime.text = @"";
//        bookingTime.backgroundColor = [UIColor orangeColor];
        bookingTime.font = [UIFont systemFontOfSize:FONTSIZE];
        _bookingTime = bookingTime;
        [_grayBackground addSubview:_bookingTime];
      
        //6.预约状态
        UILabel * bookingState = [[UILabel alloc]init];
        bookingState.text = @"";
//        bookingState.backgroundColor = [UIColor yellowColor];
        bookingState.font = [UIFont systemFontOfSize:FONTSIZE];
        bookingState.textAlignment = NSTextAlignmentCenter;
        _bookingState = bookingState;
        [_grayBackground addSubview:_bookingState];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat topBlank = 5;
    CGFloat leftBlank = 15;
    
    _grayBackground.frame = CGRectMake(leftBlank, topBlank, SCREENWIDTH-2*leftBlank, 30*4+15+10);
    
    CGFloat rowWidth = _grayBackground.frame.size.width-10;
    CGFloat rowHeight = 30;
    
    _orderId.frame = CGRectMake(10, 0+10, rowWidth, rowHeight);
    _numberOfPeople.frame = CGRectMake(10, rowHeight+10, rowWidth, rowHeight);
    _bookingTime.frame = CGRectMake(10, rowHeight*2+10, rowWidth, rowHeight);
    _bookingState.frame = CGRectMake(rowWidth*0.7, rowHeight*3+10, rowWidth*0.3, rowHeight+10);
    
}

@end
