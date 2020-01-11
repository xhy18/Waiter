//
//  AlertView.m
//  waiter
//
//  Created by ltl on 2019/8/6.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "AlertView.h"
#import "MyUtils.h"
#import "Header.h"

@implementation AlertView

static AlertView *singleInstance;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)context{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.windowLevel = UIWindowLevelAlert - 1;
        singleInstance = self;
        
        //1.背景视图
        UIView * backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.cornerRadius = 6;
        _backgroundView = backgroundView;
        [self addSubview:backgroundView];
        
        //2.提示语
        UILabel * contextLabel = [[UILabel alloc] init];
        contextLabel.font = [UIFont systemFontOfSize:15];
        contextLabel.text = context;
        contextLabel.numberOfLines = 0;
        contextLabel.textAlignment = NSTextAlignmentCenter;
        _contextLabel = contextLabel;
        [_backgroundView addSubview:_contextLabel];
        
        //3.创建取消按钮
        UIButton * cancelBtn = [[UIButton alloc] init];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.layer.borderColor = [UIColor blackColor].CGColor;
        cancelBtn.layer.borderWidth = 1.0;
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancel"] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelBtn addTarget:self action:@selector(hideWithAnimation:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = cancelBtn;
        [_backgroundView addSubview:_cancelBtn];
        
        //4.创建确定按钮
        UIButton * sureBtn = [[UIButton alloc] init];
        sureBtn.backgroundColor = [UIColor blackColor];
        sureBtn.layer.borderColor = [UIColor blackColor].CGColor;
        sureBtn.layer.borderWidth = 1.0;
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        _sureBtn = sureBtn;
        [_backgroundView addSubview:_sureBtn];
    }
    return  self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    _backgroundView.frame = CGRectMake(20, (selfHeight-150)/2, selfWidth-2*20, 150);
    
    CGFloat blank = 20;
    CGFloat btnWidth = (_backgroundView.frame.size.width-2*blank-20)/2;
    _cancelBtn.frame = CGRectMake(blank, _backgroundView.frame.size.height-36-10, btnWidth, 36);
    _cancelBtn.layer.cornerRadius = 36/2;
    _sureBtn.frame = CGRectMake(btnWidth+blank+20, _backgroundView.frame.size.height-36-10, btnWidth, 36);
    _sureBtn.layer.cornerRadius = 36/2;
    
    _contextLabel.frame = CGRectMake(5, 5, _backgroundView.frame.size.width-2*5, _cancelBtn.frame.origin.y-2*5);
    
}

#pragma mark - 显示和隐藏

- (void)showWithAnimation:(BOOL)animation{
    [self makeKeyAndVisible];
    
    [UIView animateWithDuration:animation ? 0.3 : 0.0
                     animations:^{
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
                         singleInstance = nil;
                     }];
}

- (void)dealloc{
    [self resignKeyWindow];
}

@end
