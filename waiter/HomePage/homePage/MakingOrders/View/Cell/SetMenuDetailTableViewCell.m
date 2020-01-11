//
//  SetMenuDetailTableViewCell.m
//  waiter
//
//  Created by ltl on 2019/7/20.
//  Copyright © 2019 renxin. All rights reserved.
//  套餐详情cell

#import "SetMenuDetailTableViewCell.h"

@implementation SetMenuDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.backgroundColor = [UIColor blueColor];
        //        self.contentView.backgroundColor = [UIColor greenColor];
        //        CGFloat cellHeight = self.contentView.frame.size.height;
        //        NSLog(@"%f",cellHeight);
        //        CGFloat cellWidth = self.frame.size.width;
        //        NSLog(@"%f",cellWidth);
        
        
        //1.底部灰色背景图
        UILabel * dishLabel = [[UILabel alloc]init];
        dishLabel.font = [UIFont systemFontOfSize:15];
        _dishLabel = dishLabel;
        [self.contentView addSubview:dishLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellWidth = self.contentView.frame.size.width;
    CGFloat cellHeight = self.contentView.frame.size.height;
    _dishLabel.frame = CGRectMake(20, 0, cellWidth-20, cellHeight);
}

@end
