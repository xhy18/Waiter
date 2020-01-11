//
//  SCBAlertView.m
//  Scan bee
//
//  Created by 秦焕 on 2018/12/6.
//  Copyright © 2018年 秦焕. All rights reserved.
//

#import "SCBAlertView.h"
#import <Masonry.h>
#import "Header.h"
@implementation SCBAlertView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)message{
    if (self = [super initWithFrame:frame]) {
        //在此处创建view
        self.labelTitle = message;
        [self setUI];
        
        
    }
    return self;
}
-(void)setUI{
    UIView * alertView =[[UIView alloc]init];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 10.0;
    [self addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(SCREENWIDTH-80);
        make.height.mas_equalTo(200);
    }];
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"Close_View"] forState:UIControlStateNormal];
    [alertView addSubview:_closeButton];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5);
    }];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = self.labelTitle;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(alertView).offset(-10);
        make.centerX.mas_equalTo(alertView);
        make.width.mas_equalTo(alertView.mas_width);
    }];
    

    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton setTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _deleteButton.layer.cornerRadius=20;
    _deleteButton.layer.borderColor = [UIColor blackColor].CGColor;
    _deleteButton.layer.borderWidth = 1;
    _deleteButton.layer.masksToBounds = YES;
    [alertView addSubview:_deleteButton];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo((SCREENWIDTH-80-60)/2);
        make.height.mas_equalTo(40);
    }];
    
    _cancellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancellButton setTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancell"] forState:UIControlStateNormal];
    [_cancellButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancellButton.backgroundColor = [UIColor blackColor];
    _cancellButton.layer.cornerRadius=20;
    _cancellButton.layer.borderColor = [UIColor blackColor].CGColor;
    _cancellButton.layer.borderWidth = 3;
    _cancellButton.layer.masksToBounds = YES;
    [alertView addSubview:_cancellButton];
    [_cancellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(30);
        make.left.mas_equalTo(self->_deleteButton.mas_right).offset(20);
        make.width.mas_equalTo((SCREENWIDTH-80-60)/2);
        make.height.mas_equalTo(40);
    }];
}

@end
