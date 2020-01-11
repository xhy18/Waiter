//
//  ChooseTableInfoView.m
//  waiter
//
//  Created by ltl on 2019/7/21.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "ChooseTableInfoView.h"
#import "MyUtils.h"
#import "Header.h"

@implementation ChooseTableInfoView{
    int index;
}

static ChooseTableInfoView *singleInstance;
- (instancetype)initWithFrame:(CGRect)frame tableNumData:(NSMutableArray *)data{
    self = [super initWithFrame:frame];
    if(self){
        index = -1;
        self.tableNumArray = data.mutableCopy;
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.windowLevel = UIWindowLevelAlert - 1;
        singleInstance = self;
        NSLog(@"tableNumArray:%@",self.tableNumArray);
        
        //1.背景视图
        UIView * tableNumView = [[UIView alloc] init];
        tableNumView.backgroundColor = [UIColor whiteColor];
        tableNumView.layer.cornerRadius = 6;
        _tableNumView = tableNumView;
        [self addSubview:_tableNumView];
        
        //2.标题
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_changeTable"]];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
        [_tableNumView addSubview:_titleLabel];

        //3.创建桌号标签
        UILabel * tableLabel = [[UILabel alloc] init];
        tableLabel.font = [UIFont systemFontOfSize:15];
        tableLabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_tableNum"]];
        tableLabel.numberOfLines = 0;
        tableLabel.textAlignment = NSTextAlignmentRight;
        _tableLabel = tableLabel;
        [_tableNumView addSubview:_tableLabel];
        
        //4.桌号步进视图
        UIView * tableStepperView = [[UIView alloc] init];
        tableStepperView.layer.borderWidth = 1;
        tableStepperView.layer.borderColor = [UIColor blackColor].CGColor;
        tableStepperView.layer.cornerRadius = 6;
        _tableStepperView = tableStepperView;
        [_tableNumView addSubview:_tableStepperView];
        
        //5.竖线
        UILabel * tableLineLabel = [[UILabel alloc] init];
        tableLineLabel.backgroundColor = [UIColor blackColor];
        _tableLineLabel = tableLineLabel;
        [_tableStepperView addSubview:_tableLineLabel];
        
        //6.桌号加
        UIButton * addTableBtn = [[UIButton alloc] init];
        [addTableBtn setImage:[self reSizeImage:[UIImage imageNamed:@"up.png"] toSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        addTableBtn.tag = 1;
        [addTableBtn addTarget:self action:@selector(changeTableNum:) forControlEvents:UIControlEventTouchUpInside];
        _addTableBtn = addTableBtn;
        [_tableStepperView addSubview:_addTableBtn];
        
        //7.桌号减
        UIButton * subTableBtn = [[UIButton alloc] init];
        [subTableBtn setImage:[self reSizeImage:[UIImage imageNamed:@"down.png"] toSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        subTableBtn.tag = -1;
        [subTableBtn addTarget:self action:@selector(changeTableNum:) forControlEvents:UIControlEventTouchUpInside];
        _subTableBtn = subTableBtn;
        [_tableStepperView addSubview:_subTableBtn];
        
        //8.桌号输入框
        UITextField * tableTextField = [[UITextField alloc] init];
        tableTextField.textAlignment = NSTextAlignmentCenter;
        _tableTextField = tableTextField;
        [_tableStepperView addSubview:_tableTextField];
        
        //9.创建人数标签
        UILabel * numLabel = [[UILabel alloc] init];
        numLabel.font = [UIFont systemFontOfSize:15];
        numLabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_peopleNum"]];
        numLabel.numberOfLines = 0;
        numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel = numLabel;
        [_tableNumView addSubview:_numLabel];
        
        //10.
        UIView * numStepperView = [[UIView alloc] init];
        numStepperView.layer.borderWidth = 1;
        numStepperView.layer.borderColor = [UIColor blackColor].CGColor;
        numStepperView.layer.cornerRadius = 6;
        _numStepperView = numStepperView;
        [_tableNumView addSubview:numStepperView];
        
        //11.
        UILabel * numLineLabel = [[UILabel alloc] init];
        numLineLabel.backgroundColor = [UIColor blackColor];
        _numLineLabel = numLineLabel;
        [_numStepperView addSubview:_numLineLabel];
        
        //12.人数加
        UIButton * addPeopleBtn = [[UIButton alloc] init];
        [addPeopleBtn setImage:[self reSizeImage:[UIImage imageNamed:@"up.png"] toSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        addPeopleBtn.tag = 2;
        [addPeopleBtn addTarget:self action:@selector(changePeopleNum:) forControlEvents:UIControlEventTouchUpInside];
        _addPeopleBtn = addPeopleBtn;
        [_numStepperView addSubview:_addPeopleBtn];
        
        //13.人数减
        UIButton * subPeopleBtn = [[UIButton alloc] init];
        [subPeopleBtn setImage:[self reSizeImage:[UIImage imageNamed:@"down.png"] toSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
        subPeopleBtn.tag = -2;
        [subPeopleBtn addTarget:self action:@selector(changePeopleNum:) forControlEvents:UIControlEventTouchUpInside];
        _subPeopleBtn = subPeopleBtn;
        [_numStepperView addSubview:_subPeopleBtn];
        
        //14.人数输入框
        UITextField * peopleTextField = [[UITextField alloc] init];
        peopleTextField.textAlignment = NSTextAlignmentCenter;
        peopleTextField.text = @"1";
        _peopleTextField = peopleTextField;
        [_numStepperView addSubview:_peopleTextField];
        
        //15.创建取消按钮
        UIButton * cancelBtn = [[UIButton alloc] init];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.layer.borderColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
        cancelBtn.layer.borderWidth = 1.0;
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancel"] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelBtn addTarget:self action:@selector(hideWithAnimation:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = cancelBtn;
        [_tableNumView addSubview:_cancelBtn];
        
        //16.创建确定按钮
        UIButton * sureBtn = [[UIButton alloc] init];
        sureBtn.backgroundColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
        sureBtn.layer.borderColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
        sureBtn.layer.borderWidth = 1.0;
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [sureBtn addTarget:self action:@selector(submitTableAndPeople:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn = sureBtn;
        [_tableNumView addSubview:_sureBtn];
        
        //17.背景手势
        UITapGestureRecognizer * hidden = [[UITapGestureRecognizer alloc] init];
        hidden.numberOfTapsRequired = 1;
        hidden.numberOfTouchesRequired = 1;
        [hidden addTarget:self action:@selector(hiddenShopCarDetail:)];
        hidden.delegate = self;
        [self addGestureRecognizer:hidden];
    }
    return  self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat blank = 15;
    _tableNumView.frame = CGRectMake(20, (selfHeight-300)/2, selfWidth-2*20, 300);    
    _titleLabel.frame = CGRectMake(0, 0, _tableNumView.frame.size.width, 80);
    
    CGFloat btnWidth = (_tableNumView.frame.size.width-2*blank-14)/2;
    _cancelBtn.frame = CGRectMake(blank, _tableNumView.frame.size.height-40-blank, btnWidth, 40);
    _cancelBtn.layer.cornerRadius = 40/2;
    _sureBtn.frame = CGRectMake(btnWidth+blank+14, _tableNumView.frame.size.height-40-blank, btnWidth, 40);
    _sureBtn.layer.cornerRadius = 40/2;
    
    //中间单条宽度
    CGFloat innerHeight = (_tableNumView.frame.size.height - _titleLabel.frame.size.height - _cancelBtn.frame.size.height - blank)/4;
    
    _tableLabel.frame = CGRectMake(0, _titleLabel.frame.size.height + innerHeight * 0.5, _tableNumView.frame.size.width * 0.4, innerHeight);
    _tableStepperView.frame = CGRectMake(_tableLabel.frame.origin.x + _tableLabel.frame.size.width + 20, _titleLabel.frame.size.height + innerHeight * 0.5, 100, innerHeight);
    _tableLineLabel.frame = CGRectMake(_tableStepperView.frame.size.width * 0.75, 0, 1, innerHeight);
    _addTableBtn.frame = CGRectMake(_tableStepperView.frame.size.width * 0.75 + 1, 0, _tableStepperView.frame.size.width * 0.25 - 1, innerHeight/2);
    _subTableBtn.frame = CGRectMake(_tableStepperView.frame.size.width * 0.75 + 1, innerHeight/2, _tableStepperView.frame.size.width * 0.25 - 1, innerHeight/2);
    _tableTextField.frame = CGRectMake(0, 0, _tableStepperView.frame.size.width * 0.75, innerHeight);
    
    _numLabel.frame = CGRectMake(0, _titleLabel.frame.size.height + innerHeight * 2, _tableNumView.frame.size.width * 0.4, innerHeight);
    _numStepperView.frame = CGRectMake(_tableLabel.frame.origin.x + _tableLabel.frame.size.width + 20, _titleLabel.frame.size.height + innerHeight * 2, 100, innerHeight);
    _numLineLabel.frame = CGRectMake(_numStepperView.frame.size.width * 0.75, 0, 1, innerHeight);
    _addPeopleBtn.frame = CGRectMake(_numStepperView.frame.size.width * 0.75 + 1, 0, _numStepperView.frame.size.width * 0.25 - 1, innerHeight/2);
    _subPeopleBtn.frame = CGRectMake(_numStepperView.frame.size.width * 0.75 + 1, innerHeight/2, _numStepperView.frame.size.width * 0.25 - 1, innerHeight/2);
    _peopleTextField.frame = CGRectMake(0, 0, _numStepperView.frame.size.width * 0.75, innerHeight);
}

#pragma mark - 事件

- (void)submitTableAndPeople:(id)sender{
    NSString * tableNum = _tableTextField.text;
    NSString * peopleNum = _peopleTextField.text;
    if([tableNum isEqualToString:@""]){
        tableNum = @"---";
    }
    if([peopleNum isEqualToString:@""]){
        peopleNum = @"1";
        _peopleTextField.text = @"1";
    }
    NSLog(@"/////%@:%@",tableNum,peopleNum);
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableNum: numOfPeople:)]) {
        [self.delegate tableNum:tableNum numOfPeople:peopleNum];
    }
    [self hideWithAnimation:YES];
}

- (void)changeTableNum:(UIButton *)btn{
    if(btn.tag == 1){
        if( index  == self.tableNumArray.count - 1){
            //正向循环
            index = 0;
        }else{
            index++;
        }
        
    }else if(btn.tag == -1){
        index--;
        if( index <= -1){
            index = (int)self.tableNumArray.count - 1;
        }
    }
    NSLog(@"%d",index);
    self.tableTextField.text = [NSString stringWithFormat:@"%@",self.tableNumArray[index] ];
}

- (void)changePeopleNum:(UIButton *)btn{
    NSInteger people = [self.peopleTextField.text integerValue];
    if( btn.tag == 2){
        people++;
        
    }else if(btn.tag == -2){
        if(people > 1){
            people--;
        }
    }
    self.peopleTextField.text = [NSString stringWithFormat:@"%ld",(long)people];
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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

- (void)hiddenShopCarDetail:(id)sender{
    [self hideWithAnimation:YES];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    NSString * touchClass = NSStringFromClass([touch.view class]);
    NSLog(@"手势类型%@",touchClass);
    if ([touchClass isEqualToString:@"ChooseTableInfoView"]) {
        return true;
    }else{
        return false;
    }
}

@end
