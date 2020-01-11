//
//  BookingDishTableViewCell.m
//  waiter
//
//  Created by ltl on 2019/10/25.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BookingDishTableViewCell.h"
#import "MyUtils.h"
#import "Header.h"
#define FONTSIZE 15

@implementation BookingDishTableViewCell

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
        _grayBackground = grayBackground;
        [self.contentView addSubview:grayBackground];
        
        //2.菜品名
        UILabel *dishName = [[UILabel alloc]init];
        dishName.font = [UIFont systemFontOfSize:FONTSIZE];
        _dishName = dishName;
        [_grayBackground addSubview:dishName];
        
        //3.折叠图标
        UIButton *foldBtn = [[UIButton alloc]init];
        _foldBtn = foldBtn;
        [_grayBackground addSubview:foldBtn];
        
        
        //3.菜品数量
        UILabel *dishNum = [[UILabel alloc]init];
        dishNum.textAlignment = NSTextAlignmentCenter;
        dishNum.font = [UIFont systemFontOfSize:FONTSIZE];
        _dishNum = dishNum;
        [_grayBackground addSubview:dishNum];
        
        //4.备注内容
        UILabel *remarkLabel = [[UILabel alloc]init];
        remarkLabel.font = [UIFont systemFontOfSize:13];
        remarkLabel.text = [MyUtils GETCurrentLangeStrWithKey:@"Booking_remark"];
        _remarkLabel = remarkLabel;
        [_grayBackground addSubview:remarkLabel];
        UIView * remark = [[UIView alloc] init];
        _remark = remark;
        [_grayBackground addSubview:remark];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    NSLog(@"名字：%@",_dish.dish_name);
    NSLog(@"状态：%@",_dish.dish_fold?@"yes":@"no");
    CGFloat blank = 15;
    CGFloat rowHeight = 30;
    CGFloat selfWidth = self.contentView.frame.size.width;
    CGFloat selfHeight = self.contentView.frame.size.height;
    
    _grayBackground.frame = CGRectMake(blank, 0, selfWidth-blank, selfHeight);
//    [self.grayBackground.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat nameWidth = _grayBackground.frame.size.width-30-60;
    NSLog(@"宽度：%f",nameWidth);
    if(_dish.dish_fold){
        //展开
        CGFloat nameHeight = [self setContent:nameWidth rowHeight:rowHeight];
        NSLog(@"高度：%f",nameHeight);
        _dishName.numberOfLines = 0;
        _dishName.lineBreakMode = NSLineBreakByWordWrapping;
        _dishName.frame = CGRectMake(0, 0, nameWidth, nameHeight);
        [_foldBtn setImage:[UIImage imageNamed:@"up-1.png"] forState:UIControlStateNormal];

    }else{
        //折叠
        _dishName.numberOfLines = 1;
        _dishName.lineBreakMode = NSLineBreakByTruncatingTail;
        _dishName.frame = CGRectMake(0, 0, nameWidth, rowHeight);
        [_foldBtn setImage:[UIImage imageNamed:@"down-1.png"] forState:UIControlStateNormal];
    }

    _foldBtn.frame = CGRectMake(_dishName.frame.size.width, 0, 30, rowHeight);
    _dishNum.frame = CGRectMake(_dishName.frame.size.width + _foldBtn.frame.size.width, 0, 60, rowHeight);
    
    [self initRemark];
}

- (CGFloat)setContent:(CGFloat)maxWidth rowHeight:(CGFloat)row{
    CGFloat height = [(NSString *)self.dish.dish_name boundingRectWithSize:CGSizeMake(maxWidth, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    if( height < row ){
        height = row;
    }else if(height > row && height <= row * 2 - 10){
        height = row * 2 - 10;
    }
    NSLog(@"最大宽：%f",maxWidth);
    NSLog(@"高：%f",height);
    return height;
}

- (void)initRemark{
    CGFloat width = self.grayBackground.frame.size.width;
    
    CGFloat remarkWidth=[(NSString *)self.remarkLabel.text boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width;
    _remarkLabel.frame = CGRectMake(0, _dishName.frame.size.height, remarkWidth+5, 30);
    
    float remarkHeight = 30;
    CGFloat right = width - self.remarkLabel.frame.size.width;
    
    [self.remark.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    _remark.frame = CGRectMake(_remarkLabel.frame.size.width + _remarkLabel.frame.origin.x, 30, right, 20);
    
    if(self.dish != nil){
        //CGSizeMake(200, SCREENHEIGHT)设置文本范围。200代表宽度最大为200，到了200则换到下一行；MAXFLOAT代表长度不限。
        CGFloat height=[(NSString *)self.dish.dish_options boundingRectWithSize:CGSizeMake(right, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        if(height<=30){
            height = 30;
        }else if(height>30 && height<=60){
            height = 60;
        }
        UILabel * dishOptions = [[UILabel alloc] init];
        dishOptions.text = self.dish.dish_options;
        dishOptions.font = [UIFont systemFontOfSize:14];
        dishOptions.frame = CGRectMake(0, 0, right, height);
        dishOptions.numberOfLines = 0;
        [self.remark addSubview:dishOptions];
        remarkHeight = height;
    }
    _remark.frame = CGRectMake(_remarkLabel.frame.size.width + _remarkLabel.frame.origin.x, _dishName.frame.size.height, right, remarkHeight);
    
//    NSLog(@"hahahahahhh--%f",_remarkLabel.frame.size.width + _remarkLabel.frame.origin.x);
}


@end
