//
//  ManageOrderDetailViewController.m
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ManageOrderDetailViewController.h"
#import "ManageOrderDetailView.h"
#import "ManageOrderDetailModel.h"
#import "Header.h"
#import "MyUtils.h"
#import "PayOrderViewController.h"
@interface ManageOrderDetailViewController ()
@property(nonatomic,strong)ManageOrderDetailModel * unpayOrderModel;
@property(nonatomic,strong)ManageOrderDetailView * unpayOrderView;
@end

@implementation ManageOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
    self.view.backgroundColor = [UIColor whiteColor];
    self.unpayOrderModel = [[ManageOrderDetailModel alloc]init];
    [self.unpayOrderModel GetOrderPaymentInfoList:self.orderId];
    // Do any additional setup after loading the view.
}
-(void)Set_UnpayOrder{
    CGFloat offsetH =SCREENHEIGHT-TOPOFFSET;
    self.unpayOrderView = [[ManageOrderDetailView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH,offsetH) DataArry: self.unpayOrderModel.unpaymentDetail];
    _unpayOrderView.confirmPayDelegate = self;
    [self.view addSubview:_unpayOrderView];
}
-(void)checkOrderDetail{
    PayOrderViewController * payOrderVC = [[PayOrderViewController alloc]init];
    payOrderVC.orderId = self.orderId;
    [self.navigationController pushViewController:payOrderVC animated:YES];
}
-(void)confirmPayment{
    [self.unpayOrderModel PayOrderByOrderId:self.orderId];
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Set_UnpayOrder) name:@"Get_UnpayOrderDetailFromServer" object:nil];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
