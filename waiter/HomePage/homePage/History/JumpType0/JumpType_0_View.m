//
//  JumpType_0_View.m
//  waiter
//
//  Created by Haze_z on 2019/8/10.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_0_View.h"
#import "Header.h"
#import "MyUtils.h"

@implementation JumpType_0_View
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
       
        //        self.historyDS = @[].mutableCopy;
        //        self.historyDS = dataArray.mutableCopy;
    }
    return self;
}
-(void)initUI{
    
    self.tableDataView = [[UIView alloc]init];
    self.tableDataView.backgroundColor = GRAYCOLOR;
    [self addSubview:self.tableDataView];
    
    self.dishListView = [[UIView alloc]init];
    self.dishListView.backgroundColor = [UIColor redColor];
    [self addSubview:self.dishListView];
    
    self.remarkView = [[UIView alloc]init];
    self.remarkView.backgroundColor = GRAYCOLOR;
    [self addSubview:self.remarkView];
    
    self.totalView = [[UIView alloc]init];
    self.totalView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.totalView];
    
    self.tableNum = [[UILabel alloc]init];
    self.tableNum.textAlignment = NSTextAlignmentLeft;
    self.tableNum.font = [UIFont boldSystemFontOfSize:16];
    [self.tableDataView addSubview:self.tableNum];
    
    self.orderNum = [[UILabel alloc]init];
    self.orderNum.textAlignment = NSTextAlignmentLeft;
    self.orderNum.font = [UIFont boldSystemFontOfSize:16];
    [self.tableDataView addSubview:self.orderNum];
    
    self.personNum = [[UILabel alloc]init];
    self.personNum.textAlignment = NSTextAlignmentRight;
    self.personNum.font = [UIFont boldSystemFontOfSize:16];
    [self.tableDataView addSubview:self.personNum];
    
    self.person = [[UIImageView alloc]init];
    self.person.image = [UIImage imageNamed:@"person"];
    self.person.backgroundColor = GRAYCOLOR;
    [self.tableDataView addSubview:self.person];
    
    
    self.remarkTF = [[UITextField alloc]init];
    self.remarkTF.backgroundColor = GRAYCOLOR;
    self.remarkTF.layer.borderColor = SHALLOWPURPLECOLOR.CGColor;
    self.remarkTF.layer.borderWidth = 1.0;
    self.remarkTF.layer.cornerRadius = 0.5;
    self.remarkTF.placeholder = [MyUtils changeLanguage:[MyUtils GetCurrentLanguage] strKey:@"PackageManage_remarks"];
    [self.remarkTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    self.remarkTF.delegate = self;
    self.remarkTF.keyboardType = UIKeyboardTypePhonePad;
    [self.remarkView addSubview:self.remarkTF];
    
    self.passBtn = [[UIButton alloc]init];
    self.passBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    self.passBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.passBtn.layer.cornerRadius = 28.0f;
    [self.passBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"order_confirm_pass"] forState:UIControlStateNormal];
    [self.passBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.passBtn addTarget:self action:@selector(confirmPayment) forControlEvents:UIControlEventTouchUpInside];
    [self.totalView addSubview:self.passBtn];
    
}

-(void)layoutSubviews{
    
    
    self.tableDataView.frame = CGRectMake(self.frame.size.width*0.05, 60, self.frame.size.width*0.9, self.frame.size.height*0.1);
    self.dishListView.frame = CGRectMake(self.frame.size.width*0.05, self.frame.size.height*0.19, self.frame.size.width*0.9, self.frame.size.height*0.5);
    self.remarkView.frame = CGRectMake(self.frame.size.width*0.05,self.frame.size.height*0.7 , self.frame.size.width*0.9, self.frame.size.height*0.1);
    self.totalView.frame = CGRectMake(self.frame.size.width*0.05,self.frame.size.height*0.81 , self.frame.size.width*0.9, self.frame.size.height*0.15);
    self.tableNum.frame = CGRectMake(20, 15, self.tableDataView.frame.size.width*0.5, self.tableDataView.frame.size.height*0.2);
    self.orderNum.frame = CGRectMake(20, 45, self.tableDataView.frame.size.width*0.3, self.tableDataView.frame.size.height*0.2);
    self.personNum.frame = CGRectMake(self.frame.size.width*0.57, 15, self.tableDataView.frame.size.width*0.3, self.tableDataView.frame.size.height*0.2);
    self.person.frame = CGRectMake(self.frame.size.width*0.73, 7, self.tableDataView.frame.size.width*0.08, self.tableDataView.frame.size.width*0.08);
    self.remarkTF.frame = CGRectMake(5, 5, self.tableDataView.frame.size.width*0.8, self.tableDataView.frame.size.height*0.8);
    self.passBtn.frame = CGRectMake((self.totalView.frame.size.width-SCREENWIDTH*2/3)/2, self.totalView.frame.size.height*0.5, SCREENWIDTH*2/3, 55);
    //
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
