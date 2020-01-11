//
//  NotCompletePackageTableViewCell.m
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//  未完成打包cell

#import "NotCompletePackageTableViewCell.h"
#import "MyUtils.h"
#import "Header.h"
#define FONTSIZE 15
@implementation NotCompletePackageTableViewCell

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
        grayBackground.layer.shadowColor = [UIColor grayColor].CGColor;
        grayBackground.layer.shadowOpacity = 0.3;
        grayBackground.layer.shadowOffset = CGSizeMake(0, 1);
        _grayBackground = grayBackground;
        [self.contentView addSubview:_grayBackground];
        
        //2.订单号行
        UILabel * orderId = [[UILabel alloc]init];
        orderId.text = @"";
        orderId.font = [UIFont systemFontOfSize:FONTSIZE];
        _orderId = orderId;
        [_grayBackground addSubview:_orderId];

        //3.下单时间行
        UILabel * orderTime = [[UILabel alloc]init];
        orderTime.text = @"";
        orderTime.font = [UIFont systemFontOfSize:FONTSIZE];
        _orderTime = orderTime;
        [_grayBackground addSubview:_orderTime];
        
        //4.取餐时间行
        UILabel * pickUpTime = [[UILabel alloc]init];
        pickUpTime.text = @"";
        pickUpTime.font = [UIFont systemFontOfSize:FONTSIZE];
        _pickUpTime = pickUpTime;
        [_grayBackground addSubview:_pickUpTime];
        
        //5.取餐客人行
        UILabel * guest = [[UILabel alloc]init];
        guest.text = @"";
        guest.font = [UIFont systemFontOfSize:FONTSIZE];
        _guest = guest;
        [_grayBackground addSubview:_guest];
        
        //6.打包状态行
        UILabel * packageState = [[UILabel alloc]init];
        packageState.text = @"";
        packageState.font = [UIFont systemFontOfSize:FONTSIZE];
        packageState.textAlignment = NSTextAlignmentRight;
        _packageState = packageState;
        [_grayBackground addSubview:_packageState];
       
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat topBlank = 5;
    CGFloat leftBlank = 15;
    
    _grayBackground.frame = CGRectMake(leftBlank, topBlank, SCREENWIDTH-2*leftBlank, 150);
    
    CGFloat rowWidth = _grayBackground.frame.size.width-10;
    CGFloat rowHeight = _grayBackground.frame.size.height/5;
    
    _orderId.frame = CGRectMake(10, 0, rowWidth, rowHeight);
    _orderTime.frame = CGRectMake(10, rowHeight, rowWidth, rowHeight);
    _pickUpTime.frame = CGRectMake(10, rowHeight*2, rowWidth, rowHeight);
    _guest.frame = CGRectMake(10, rowHeight*3, rowWidth, rowHeight);
    _packageState.frame = CGRectMake(10, rowHeight*4, rowWidth-10, rowHeight);
    
}

@end
