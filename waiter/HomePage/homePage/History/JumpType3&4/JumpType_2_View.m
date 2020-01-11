//
//  JumpType_2_View.m
//  waiter
//
//  Created by Haze_z on 2019/8/9.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_2_View.h"
#import "Header.h"
#import "MyUtils.h"

@implementation JumpType_2_View
-(instancetype)initWithFrame:(CGRect)frame PayStatus:(NSString *)payStatus{
    self = [super initWithFrame:frame];
    if(self){
        NSLog(@"!!!!!%@",payStatus);
        [self initUI:payStatus];
    }
    return self;
}
-(void)initUI:(NSString *)payStatus{
    self.orderView = [[UIView alloc]init];
    _orderView.backgroundColor = GRAYCOLOR;
    [self addSubview:_orderView];
    self.orderNumLabel = [[UILabel alloc]init];
    _orderNumLabel.font = [UIFont boldSystemFontOfSize:14];
    _orderNumLabel.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderId"],@"---"];
    [_orderView addSubview:_orderNumLabel];
    self.orderTelLabel = [[UILabel alloc]init];
    _orderTelLabel.textAlignment = NSTextAlignmentRight;
    _orderTelLabel.font = [UIFont boldSystemFontOfSize:14];
    _orderTelLabel.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_telephone"],@"---"];
    [_orderView addSubview:_orderTelLabel];
    self.orderTableLabel = [[UILabel alloc]init];
    _orderTableLabel.font = [UIFont boldSystemFontOfSize:14];
    _orderTableLabel.text = [NSString stringWithFormat:@"%@%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_tableNum"],@"---"];
    [_orderView addSubview:_orderTableLabel];
    self.totalPriceLabel = [[UILabel alloc]init];
    _totalPriceLabel.textAlignment = NSTextAlignmentRight;
    _totalPriceLabel.font = [UIFont boldSystemFontOfSize:14];
    _totalPriceLabel.text = [NSString stringWithFormat:@"%@%.2f%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"],0.00,@"€"];
    [_orderView addSubview:_totalPriceLabel];
    
    
    self.orderPayView = [[UIView alloc]init];
    _orderPayView.backgroundColor = GRAYCOLOR;
    [self addSubview:_orderPayView];
    self.payTextLabel = [[UILabel alloc]init];
    _payTextLabel.font = [UIFont boldSystemFontOfSize:14];
    _payTextLabel.text = [MyUtils GETCurrentLangeStrWithKey:@"OrderManage_scanBeePayAmount"];
    [_orderPayView addSubview:_payTextLabel];
    self.payNumLabel = [[UILabel alloc]init];
    _payNumLabel.textAlignment = NSTextAlignmentRight;
    _payNumLabel.font = [UIFont boldSystemFontOfSize:14];
    _payNumLabel.text = [NSString stringWithFormat:@"%.2f%@",0.00,@"€"];
    [_orderPayView addSubview:_payNumLabel];
    
    
    self.remainPayView = [[UIView alloc]init];
    _remainPayView.backgroundColor = ORANGECOLOR;
    [self addSubview:_remainPayView];
    self.remainPayTextLabel = [[UILabel alloc]init];
    _remainPayTextLabel.font = [UIFont boldSystemFontOfSize:14];
    _remainPayTextLabel.text = [MyUtils GETCurrentLangeStrWithKey:@"OrderManage_remainPay"];
    [_remainPayView addSubview:_remainPayTextLabel];
    self.remainPayNumLabel = [[UILabel alloc]init];
    _remainPayNumLabel.textAlignment = NSTextAlignmentRight;
    _remainPayNumLabel.font = [UIFont boldSystemFontOfSize:14];
    _remainPayNumLabel.text = [NSString stringWithFormat:@"%.2f%@",0.00,@"€"];
    [_remainPayView addSubview:_remainPayNumLabel];
    
    
    self.checkOrderBtn = [[UIButton alloc]init];
    _checkOrderBtn.backgroundColor = GRAYCOLOR;
    _checkOrderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_checkOrderBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"OrderManage_showOrderDetail"] forState:UIControlStateNormal];
    [_checkOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_checkOrderBtn addTarget:self action:@selector(checkOrderDetail) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmPayBtn = [[UIButton alloc]init];
    _confirmPayBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _confirmPayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _confirmPayBtn.layer.cornerRadius = 28.0f;
    
    if([payStatus isEqualToString:@"0"]){
        [_confirmPayBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"OrderManage_confirmPay"] forState:UIControlStateNormal];
        [_confirmPayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirmPayBtn addTarget:self action:@selector(confirmPayment) forControlEvents:UIControlEventTouchUpInside];
    }else if([payStatus isEqualToString:@"1"]){
        [_confirmPayBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_haveSeen"] forState:UIControlStateNormal];
        [_confirmPayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirmPayBtn addTarget:self action:@selector(SecondConfirmPayment) forControlEvents:UIControlEventTouchUpInside];
    }else{
        _confirmPayBtn.hidden =YES;
    }
    
    [self addSubview:_checkOrderBtn];
    [self addSubview:_confirmPayBtn];
}
-(void)layoutSubviews{
    self.orderView.frame = CGRectMake(15, 20, SCREENWIDTH-30, 60);
    self.orderPayView.frame = CGRectMake(30, 100, SCREENWIDTH-60, 45);
    self.remainPayView.frame = CGRectMake(30, 145, SCREENWIDTH-60, 45);
    
    self.orderNumLabel.frame =CGRectMake(15, 0, (SCREENWIDTH-60)/2, 30);
    self.orderTelLabel.frame = CGRectMake(SCREENWIDTH/2, 0, (SCREENWIDTH-60)/2, 30);
    self.orderTableLabel.frame = CGRectMake(15,30, (SCREENWIDTH-60)/2, 30);
    self.totalPriceLabel.frame = CGRectMake(SCREENWIDTH/2, 30, (SCREENWIDTH-60)/2, 30);
    
    self.payTextLabel.frame = CGRectMake(15,0,(SCREENWIDTH-90)/2, 45);
    self.payNumLabel.frame = CGRectMake((SCREENWIDTH-90)/2,0, (SCREENWIDTH-90)/2,45);
    
    self.remainPayTextLabel.frame = CGRectMake(15,0,(SCREENWIDTH-90)/2, 45);
    self.remainPayNumLabel.frame = CGRectMake((SCREENWIDTH-90)/2,0,(SCREENWIDTH-90)/2, 45);
    
    self.checkOrderBtn.frame = CGRectMake(60, 210, SCREENWIDTH-120, 50);
    self.confirmPayBtn.frame = CGRectMake(SCREENWIDTH/6, SCREENHEIGHT - 150, SCREENWIDTH*2/3, 55);
    
}
-(void)changeManageOrderDetailData:(NSDictionary *)dataDic{
    self.unpayOrderDS = @[].mutableCopy;
    self.unpayOrderDS = dataDic.mutableCopy;
    _orderNumLabel.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderId"],[_unpayOrderDS objectForKey:@"order_num"]];
    _orderTelLabel.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_telephone"],[_unpayOrderDS objectForKey:@"customer"]];
    _orderTableLabel.text = [NSString stringWithFormat:@"%@%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_tableNum"],[_unpayOrderDS objectForKey:@"table"]];
    NSString * totalPrice = [_unpayOrderDS objectForKey:@"price"];
    _totalPriceLabel.text = [NSString stringWithFormat:@"%@%.2f%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"],totalPrice.doubleValue,@"€"];
    NSString * payNum = [_unpayOrderDS objectForKey:@"online_pay_amount"];
    _payNumLabel.text = [NSString stringWithFormat:@"%.2f%@",payNum.doubleValue,@"€"];
    NSString * remainPayNum = [_unpayOrderDS objectForKey:@"remain_pay_amount"];
    //    _remainPayNumLabel.text = [NSString stringWithFormat:@"%.2f%@",atof((remainPayNum).UTF8String),@"€"];
    
    _remainPayNumLabel.text = [NSString stringWithFormat:@"%.2f%@",remainPayNum.doubleValue,@"€"];
    
    
}

-(void)checkOrderDetail{
    [self.confirmPayDelegate checkOrderDetail];
}
-(void)confirmPayment{
    [self.confirmPayDelegate confirmPayment];
}
-(void)SecondConfirmPayment{
    [self.confirmPayDelegate SecondConfirmPayment];
}
@end
