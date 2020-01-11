//
//  SetLanguageTableViewCell.m
//  waiter
//
//  Created by renxin on 2019/4/11.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "SetLanguageTableViewCell.h"

@implementation SetLanguageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    UILabel * theBigNameLabel = [[UILabel alloc]init];
    theBigNameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    _bigNameLabel = theBigNameLabel;
    UILabel * theSmallNameLabel = [[UILabel alloc]init];
    _smallNameLabel = theSmallNameLabel;
    UIImageView * theSelectImage = [[UIImageView alloc]init];
    theSelectImage.image = [UIImage imageNamed:@"choose"];
    theSelectImage.hidden = YES;
    _selectedImage = theSelectImage;
    [self.contentView addSubview:theBigNameLabel];
    [self.contentView addSubview:theSmallNameLabel];
    [self.contentView addSubview:theSelectImage];
}
//设置frame
-(void)layoutSubviews{
    self.bigNameLabel.frame = CGRectMake(20, 0,self.frame.size.width - 40 - 30, 30);
    self.smallNameLabel.frame = CGRectMake(20, 30,self.frame.size.width - 40 - 30, 20);
    self.selectedImage.frame = CGRectMake(self.frame.size.width - 30 - 20, 10 , 30 , 30);
}
@end
