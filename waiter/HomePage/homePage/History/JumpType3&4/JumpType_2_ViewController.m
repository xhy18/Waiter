//
//  JumpType_2_ViewController.m
//  waiter
//
//  Created by Haze_z on 2019/8/9.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_2_ViewController.h"
#import "Header.h"
#import "MyUtils.h"
#import "PayOrderViewController.h"
#import "JumpType_2_Model.h"
#import "JumpType_2_View.h"

@interface JumpType_2_ViewController ()<confirmPayDelegate>
@property(nonatomic,strong)JumpType_2_Model * unpayOrderModel;
@property(nonatomic,strong)JumpType_2_View * unpayOrderView;
@end

@implementation JumpType_2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"index_order"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.unpayOrderModel = [[JumpType_2_Model alloc]init];
    [self.unpayOrderModel GetOrderPaymentInfoList:self.orderId];
//    CGFloat sr =SCREENHEIGHT;
//    CGFloat tr =TOPOFFSET;
//    CGFloat offsetH =sr-tr;
//    self.unpayOrderView = [[JumpType_2_View alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH,offsetH) PayStatus:self.unpayOrderModel.payStatus];
//    [self.view addSubview:_unpayOrderView];
    // Do any additional setup after loading the view.
}
-(void)Set_UnpayOrder{
    CGFloat sr =SCREENHEIGHT;
    CGFloat tr =TOPOFFSET;
    CGFloat offsetH =sr-tr;
    self.unpayOrderView = [[JumpType_2_View alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH,offsetH) PayStatus:self.unpayOrderModel.payStatus];
    [self.view addSubview:_unpayOrderView];

    
    _unpayOrderView.confirmPayDelegate = self;
    [_unpayOrderView changeManageOrderDetailData:self.unpayOrderModel.unpaymentDetail];
}
-(void)pass_UnpayOrder{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)see_PayOrder{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)checkOrderDetail{
    PayOrderViewController * payOrderVC = [[PayOrderViewController alloc]init];
    payOrderVC.orderId = self.orderId;
    [self.navigationController pushViewController:payOrderVC animated:YES];
}
-(void)confirmPayment{
    [self.unpayOrderModel PayOrderByOrderId:self.orderId];
}
-(void)SecondConfirmPayment{
    [self.unpayOrderModel HaveSeeByOrderId:self.orderId];
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Set_UnpayOrder) name:@"Get_UnpayOrderDetail_FromServer" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pass_UnpayOrder) name:@"Pass_SingleOrder_Success" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(see_PayOrder) name:@"HaveSeen_Success" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
