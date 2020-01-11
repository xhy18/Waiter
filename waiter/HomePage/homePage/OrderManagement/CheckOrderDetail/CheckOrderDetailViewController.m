//
//  CheckOrderDetailViewController.m
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "CheckOrderDetailViewController.h"
#import "CheckOrderDetailModel.h"
#import "CheckOrderDetailView.h"
#import "Header.h"
#import "MyUtils.h"
@interface CheckOrderDetailViewController ()
@property(strong,nonatomic)CheckOrderDetailModel * orderDetailModel;
@property(strong,nonatomic)CheckOrderDetailView * orderDetailView;
@end

@implementation CheckOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.orderId);
    self.orderDetailModel = [[CheckOrderDetailModel alloc]init];
    [self.orderDetailModel GetOrderDetailList:self.orderId];
    // Do any additional setup after loading the view.
}
-(void)Get_UnconfirmOrderDetailFromServer{
    CGFloat offsetH = SCREENHEIGHT-TOPOFFSET;
    self.orderDetailView = [[CheckOrderDetailView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, offsetH) DataArry: self.orderDetailModel.unconfirmOrderInfoList];
    _orderDetailView.submitDelegate = self;
    [self.view addSubview:_orderDetailView];
}

//实现代理方法
-(void)RefuseTheOrder{
    [self.orderDetailModel RefuseOrderByOrderId:self.orderId];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)PassTheOrder{
    [self.orderDetailModel PassOrderByOrderId:self.orderId];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)RefuseTheOrderAndDish:(NSMutableArray<NSDictionary *>*)dishArray{
    [self.orderDetailModel RefuseOrderAndDish:self.orderId DishArray:dishArray];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_UnconfirmOrderDetailFromServer) name:@"Get_UnconfirmOrderDetailFromServer" object:nil];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
