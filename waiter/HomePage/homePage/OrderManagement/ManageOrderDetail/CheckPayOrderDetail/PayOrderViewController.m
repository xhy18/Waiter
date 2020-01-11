//
//  PayOrderViewController.m
//  waiter
//
//  Created by renxin on 2019/7/26.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "PayOrderViewController.h"
#import "PayOrderView.h"
#import "PayOrderViewModel.h"
#import "Header.h"
#import "ModifyPayOrderViewController.h"
@interface PayOrderViewController ()
@property(strong,nonatomic) PayOrderViewModel * payOrderModel;
@property(strong,nonatomic)PayOrderView * payOrderView;
@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.payOrderModel = [[PayOrderViewModel alloc]init];
    [_payOrderModel GetDishPaymentInfoList:self.orderId];
    // Do any additional setup after loading the view.
}
-(void)Set_PayDishDetailFromServer{
    CGFloat offsetH = SCREENHEIGHT-TOPOFFSET;
    self.payOrderView = [[PayOrderView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, offsetH) DataArry: self.payOrderModel.paymentDishOrderList];
    _payOrderView.mdifyDelegate = self;
    [self.view addSubview:_payOrderView];
}
-(void)ModifyThePayOrder{
    ModifyPayOrderViewController * modifyVC = [[ModifyPayOrderViewController alloc]init];
    modifyVC.paymentDishOrderDS = self.payOrderModel.paymentDishOrderList;
    [self.navigationController pushViewController:modifyVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Set_PayDishDetailFromServer) name:@"Get_PayDishDetailFromServer" object:nil];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
