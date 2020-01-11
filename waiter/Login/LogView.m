//
//  LogView.m
//  waiter
//
//  Created by renxin on 2019/3/18.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "LogView.h"

@implementation LogView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //在此处创建view
        [self initUI];
        
    }
    return self;
}
-(void) initUI{
    UIImageView * backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    backImage.image = [UIImage imageNamed:@"Login"];
    [self addSubview:backImage];
    UILabel * label = [[UILabel alloc]init];
    label.text = @"id";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
