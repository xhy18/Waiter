//
//  ServerTableViewCell.m
//  waiter
//
//  Created by renxin on 2019/7/18.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ServerTableViewCell.h"
#import "Header.h"
#import "PrefixHeader.pch"
@interface ServerTableViewCell()

@property(nonatomic,strong)UIView * backgroundview;
@property(nonatomic,strong)UILabel * waiterName;
@property(nonatomic,strong)UILabel * waiterTable;


@end
@implementation ServerTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIView * backView = [[UIView alloc]init];
        backView.backgroundColor = GRAYCOLOR;
        backView.layer.cornerRadius = 5.0f;
        backView.layer.masksToBounds = YES;
        backView.layer.borderWidth = 1.0f;
        backView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
        
        [self.contentView addSubview:backView];
        self.backgroundview = backView;
        //创建服务员名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.backgroundview addSubview:nameLabel];
        self.waiterName = nameLabel;
        //创建服务员对应桌号
        UILabel *tableLabel = [[UILabel alloc] init];
        tableLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.backgroundview addSubview:tableLabel];
        self.waiterTable = tableLabel;
        //创建服务员对应的二维码
        UIImageView *waiterCode = [[UIImageView alloc] init];
        waiterCode.userInteractionEnabled = YES;
        self.waiterCode.userInteractionEnabled = YES;
        [self.backgroundview addSubview:waiterCode];
        self.waiterCode = waiterCode;
        //删除服务员按钮
        UIButton * cancelWaiter = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelWaiter.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [cancelWaiter setBackgroundColor:[UIColor whiteColor]];
        [cancelWaiter.layer setCornerRadius:20];
        [cancelWaiter setTitle:[MyUtils GETCurrentLangeStrWithKey:@"serverManage_delete"] forState:UIControlStateNormal];
        
        [cancelWaiter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backgroundview addSubview:cancelWaiter];
        self.cancelBtn = cancelWaiter;
        //修改d服务员按钮
        UIButton * modifierWaiter = [UIButton buttonWithType:UIButtonTypeCustom];
        modifierWaiter.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [modifierWaiter setBackgroundColor:[UIColor blackColor]];
        [modifierWaiter.layer setCornerRadius:20];
        [modifierWaiter setTitle:[MyUtils GETCurrentLangeStrWithKey:@"serverManage_modify"] forState:UIControlStateNormal];
        [modifierWaiter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backgroundview addSubview:modifierWaiter];
        self.modifyBtn = modifierWaiter;
    }
    return self;
}

-(void)setEmportModel:(waiterInfo *)EmportModel{
    if(self.EmportModel == nil){
        _EmportModel = EmportModel;
        self.waiterName.text = [NSString stringWithFormat:@"%@ %@",[MyUtils GETCurrentLangeStrWithKey:@"serverManage_waiter"],self.EmportModel.waiterName];
        NSInteger length = self.EmportModel.waiterTable.length;
        NSString * tempStr = @"";
        if(length>0){
            tempStr = [self.EmportModel.waiterTable substringToIndex:length-1];
        }
        
        self.waiterTable.text = [NSString stringWithFormat:@"%@ %@",[MyUtils GETCurrentLangeStrWithKey:@"serverManage_table"],tempStr];
        NSString * newImg = [NSString stringWithFormat:@"%@%@%@%@",imgAddress,self.EmportModel.waiterCode,middleAddress,OSS_LIST_STYLE ];
//        NSLog(@"newImg:%@",newImg);
       [self.waiterCode sd_setImageWithURL:[NSURL URLWithString:newImg] placeholderImage:nil];
//        NSLog(@"code:%@",self.EmportModel.waiterCode);
        // 2.设置frame
        [self settingFrame];
    }
}
-(void)settingFrame{
    [self.backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREENWIDTH-40);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(160);
        make.left.mas_equalTo(20);
    }];
    [self.waiterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(SCREENWIDTH*0.4);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(10);
    }];
    [self.waiterCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.right.mas_equalTo(-10);
    }];
    [self.waiterTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.waiterName.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREENWIDTH*0.4);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.waiterTable.mas_bottom).offset(10);
        make.width.mas_equalTo(135);
        make.height.mas_equalTo(40);
    }];
    [self.modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.waiterTable.mas_bottom).offset(10);
        make.width.mas_equalTo(135);
        make.height.mas_equalTo(40);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
