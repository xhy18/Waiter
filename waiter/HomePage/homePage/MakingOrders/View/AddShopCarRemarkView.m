//
//  AddShopCarRemarkView.m
//  waiter
//
//  Created by ltl on 2019/7/27.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "AddShopCarRemarkView.h"
#import "MyUtils.h"
#import "Header.h"

@implementation AddShopCarRemarkView

static AddShopCarRemarkView *singleInstance;
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.windowLevel = UIWindowLevelAlert - 1;
        singleInstance = self;
        
        //1.背景视图
        UIView * remarkView = [[UIView alloc] init];
        remarkView.backgroundColor = [UIColor whiteColor];
        remarkView.layer.cornerRadius = 3;
        _remarkView = remarkView;
        [self addSubview:_remarkView];
        
        //2.标题
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_remark"]];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
        [_remarkView addSubview:_titleLabel];
        
        //3.关闭按钮
        UIButton * closeBtn = [[UIButton alloc] init];
        [closeBtn setImage:[UIImage imageNamed:@"close_dialog.png"]forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(submitRemark) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn = closeBtn;
        [_remarkView addSubview:_closeBtn];
        
        //4.分割线
        UILabel * lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = GLOBALGRAYCOLOR;
        _lineLabel = lineLabel;
        [_remarkView addSubview:_lineLabel];
        
        //5.备注输入框
        UITextField * remarkField = [[UITextField alloc] init];
        remarkField.placeholder = [MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_remark"];
//        remarkField.backgroundColor = [UIColor redColor];
//        remarkField.textAlignment = NSTextAlignmentCenter;
        [remarkField sizeToFit];
        _remarkField = remarkField;        
        [_remarkView addSubview:_remarkField];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    _remarkView.frame = CGRectMake(25, (selfHeight-270)/2, selfWidth-2*25, 270);
    _titleLabel.frame = CGRectMake(0, 0, _remarkView.frame.size.width, 50);
    _closeBtn.frame = CGRectMake(_remarkView.frame.size.width - 10 - 20, 15, 20, 20);
    _lineLabel.frame = CGRectMake(0, _titleLabel.frame.size.height, _remarkView.frame.size.width, 1);
    _remarkField.frame = CGRectMake(0, _titleLabel.frame.size.height + 1, _remarkView.frame.size.width, _remarkView.frame.size.height - _titleLabel.frame.size.height - 1);
}

#pragma mark - 事件

- (void)remarkField:(NSString *)str{
    _remarkField.text = str;
    [self showWithAnimation:NO];
}

- (void)submitRemark{
    NSString * remark = self.remarkField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(newRemark:)]) {
        [self.delegate newRemark:remark];
    }
}

- (void)showWithAnimation:(BOOL)animation{
    [self makeKeyAndVisible];
    
    [UIView animateWithDuration:animation ? 0.3 : 0.0
                     animations:^{
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)hideWithAnimation:(BOOL)animation{
    [UIView animateWithDuration:animation ? 0.3 : 0.0
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         //                         singleInstance = nil;
                         [self removeFromSuperview];
                     }];
}

- (void)dealloc{
    [self resignKeyWindow];
}

@end
