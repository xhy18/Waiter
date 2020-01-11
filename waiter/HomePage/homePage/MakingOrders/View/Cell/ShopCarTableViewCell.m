//
//  ShopCarTableViewCell.m
//  waiter
//
//  Created by ltl on 2019/7/25.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "ShopCarTableViewCell.h"

@implementation ShopCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
//        self.contentView.layer.borderWidth = 2;
        
        UILabel * dishName = [[UILabel alloc] init];
        dishName.text = @"";
        dishName.font = [UIFont systemFontOfSize:14];
        dishName.userInteractionEnabled = YES;
        _dishName = dishName;
        [self.contentView addSubview:dishName];
        
        UILabel * price = [[UILabel alloc] init];
//        price.backgroundColor = [UIColor orangeColor];
        price.font = [UIFont systemFontOfSize:13];
        price.textAlignment = NSTextAlignmentRight;
        price.text = @"";
        _price = price;
        [self.contentView addSubview:price];
        
        ShopCarButton * sub = [[ShopCarButton alloc] init];
        [sub setBackgroundImage:[UIImage imageNamed:@"shopCarSub.png"] forState:UIControlStateNormal];
        _sub = sub;
        [self.contentView addSubview:sub];
        
        UILabel * num = [[UILabel alloc] init];
//        num.backgroundColor = [UIColor orangeColor];
        num.font = [UIFont systemFontOfSize:14];
        num.text = @"";
        num.textAlignment = NSTextAlignmentCenter;
        _num = num;
        [self.contentView addSubview:num];
        
        ShopCarButton * add = [[ShopCarButton alloc] init];
        [add setBackgroundImage:[UIImage imageNamed:@"shopCarAdd.png"] forState:UIControlStateNormal];
        _add = add;
        [self.contentView addSubview:add];

        UILabel * remarkLabel = [[UILabel alloc] init];
//        remarkLabel.backgroundColor = [UIColor orangeColor];
        remarkLabel.font = [UIFont systemFontOfSize:12];
        remarkLabel.text = [MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_remarks"];
        _remarkLabel = remarkLabel;
        [self.contentView addSubview:remarkLabel];
        
        UIView * remark = [[UIView alloc] init];
//        remark.backgroundColor = [UIColor purpleColor];
        _remark = remark;
        [self.contentView addSubview:remark];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //CGFloat width = self.contentView.frame.size.width;
    CGFloat width = SCREENWIDTH;
    NSLog(@"width:%f",width);
    _dishName.frame =  CGRectMake(20, 0, width*0.55-20, 30);
    _price.frame = CGRectMake(width * 0.55, 0, width * 0.45-100, 30);
    _sub.frame = CGRectMake(_price.frame.size.width + _price.frame.origin.x + 10, 5, 20, 20);
    _num.frame = CGRectMake(_price.frame.size.width + _price.frame.origin.x + 10 + 20 + 5, 0, 30, 30);
    _add.frame = CGRectMake(_num.frame.size.width + _num.frame.origin.x + 5, 5, 20, 20);
    [self initRemark];
}

- (void)initRemark{
    //CGFloat width = self.contentView.frame.size.width;
    CGFloat width = SCREENWIDTH;
    
    CGFloat remarkWidth=[(NSString *)_remarkLabel.text boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width;
    _remarkLabel.frame = CGRectMake(20, 30, remarkWidth+5, 20);
    
    float totalHeight = 0;
    CGFloat right = width-remarkWidth-20-15;
    
    [self.remark.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _remark.frame = CGRectMake(_remarkLabel.frame.size.width + _remarkLabel.frame.origin.x, 30, right, 20);
  
    if(self.type == 0){
        if(self.dish != nil){
            //CGSizeMake(200, SCREENHEIGHT)设置文本范围。200代表宽度最大为200，到了200则换到下一行；MAXFLOAT代表长度不限。
            CGFloat height=[(NSString *)self.dish.single_dish.dish_waiter_remark boundingRectWithSize:CGSizeMake(right, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
            if(height<=20){
                height = 20;
            }else if(height>20 && height<=40){
                height = 40;
            }
            UILabel * waiterRemark = [[UILabel alloc] init];
            waiterRemark.text = self.dish.single_dish.dish_waiter_remark;
            waiterRemark.font = [UIFont systemFontOfSize:12];
            waiterRemark.frame = CGRectMake(0, 0, right, height);
            waiterRemark.numberOfLines = 0;
//            waiterRemark.backgroundColor = [UIColor redColor];
//            NSMutableParagraphStyle  * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//            [paragraphStyle  setLineSpacing:15];
//            NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:self.dish.single_dish.dish_waiter_remark];
//            [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.dish.single_dish.dish_waiter_remark length])];
//            [waiterRemark  setAttributedText:setString];
            [self.remark addSubview:waiterRemark];
            totalHeight = height;
        }
    }
    
    else if(self.type == 1){
        if(self.setMenu != nil){
            int index = 0;
            for(ShopCarAddDishObj * obj in self.setMenu.set_menu_dishes){
                NSString * name = [[NSString alloc] init];
                if([obj.dish_option_string isEqualToString:@""]){
                    name = obj.dish_name;
                }else{
                    name = [NSString stringWithFormat:@"%@(%@)", obj.dish_name,obj.dish_option_string];
                }
                UILabel * dishName = [[UILabel alloc] init];
//                dishName.backgroundColor = [UIColor grayColor];
                dishName.font = [UIFont systemFontOfSize:12];
                dishName.text = name;
                dishName.frame = CGRectMake(0, 20*index, right, 20);
                [self.remark addSubview:dishName];
                totalHeight += 20;
                index++;
            }
            CGFloat height=[(NSString *)self.setMenu.set_menu_waiter_remark boundingRectWithSize:CGSizeMake(right, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
            NSLog(@"height---%f",height);
            NSLog(@"height---++%@",self.setMenu.set_menu_waiter_remark);
            if([self.setMenu.set_menu_waiter_remark isEqualToString:@""]){
                height = 0;
            }else if( height<20 ){
                height = 20;
            }else if(height>20 && height<=40){
                height = 40;
            }
            UILabel * waiterRemark = [[UILabel alloc] init];
            waiterRemark.text = self.setMenu.set_menu_waiter_remark;
            waiterRemark.font = [UIFont systemFontOfSize:12];
            waiterRemark.frame = CGRectMake(0, 20*index, right, height);
//            waiterRemark.backgroundColor = [UIColor redColor];
            waiterRemark.numberOfLines = 0;
            [self.remark addSubview:waiterRemark];
            totalHeight += height;
        }
    }
    
    _remark.frame = CGRectMake(_remarkLabel.frame.size.width + _remarkLabel.frame.origin.x, 30, right, totalHeight);
    NSLog(@"hahahahahhh--%f",_remarkLabel.frame.size.width + _remarkLabel.frame.origin.x);
}

@end
