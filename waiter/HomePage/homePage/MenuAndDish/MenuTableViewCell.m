//
//  MenuTableViewCell.m
//  waiter
//
//  Created by renxin on 2019/5/7.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "Masonry.h"
#import "Header.h"
@implementation MenuTableViewCell
//在这个方法里添加需要显示的控件
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //添加需要的控件
        UIView * backView = [[UIView alloc]init];
        [self.contentView addSubview:backView];
        self.backgroundView = backView;
        //创建label
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.backgroundView addSubview:nameLabel];
        self.menuName = nameLabel;
        
        
        //创建switch控件
        
//        UISwitch * choose = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
//        choose.transform = CGAffineTransformMakeScale(1.3, 1.2);
//        choose.on = YES;
//        [self.backgroundView addSubview:choose];
//        self.isChoosed = choose;
        
        [self.menuName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo((SCREENWIDTH-60)*0.7);
            make.height.mas_equalTo(50);
            
        }];
        
//        [self.isChoosed mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(20);
//            make.top.mas_equalTo(20);
//            make.width.mas_equalTo((SCREENWIDTH-60)*0.3);
//            make.height.mas_equalTo(50);
//        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
