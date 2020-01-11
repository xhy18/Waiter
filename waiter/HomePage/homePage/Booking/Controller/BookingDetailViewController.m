//
//  BookingDetailViewController.m
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BookingDetailViewController.h"
#import "BookingDetailView.h"
#import "BookingModel.h"

#import "AlertView.h"
#import "Header.h"
#import "MyUtils.h"

@interface BookingDetailViewController ()

@property(nonatomic, strong) BookingModel * bookingModel;
@property(nonatomic, strong) BookingDetailView * bookingDetailView;
@property(nonatomic, strong) AlertView * alertView;
@property(nonatomic, strong) UIBarButtonItem * rightBarItem;

@end

@implementation BookingDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"Booking_bookingDetail"];
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrder)];
    rightBarItem.image = [MyUtils reSizeImage:[UIImage imageNamed:@"delete.png"] toSize:CGSizeMake(30, 30)];
    rightBarItem.tag = 1;
    self.rightBarItem = rightBarItem;
    
    float sch = SCREENHEIGHT;
    float top = TOPOFFSET;
    float mainHeight = sch - top;
    
    
    if( [_orderType isEqualToString:@"0"] || [_orderType isEqualToString:@"1"]){
        //未完成，已完成
        BookingDetailView * detailView = [[BookingDetailView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight) orderType:self.orderType];
        [detailView.bottomBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_printTicket"] forState:UIControlStateNormal];
        [detailView.bottomBtn addTarget:self action:@selector(printClick:) forControlEvents:UIControlEventTouchUpInside];
        self.bookingDetailView = detailView;
        [self.view addSubview:detailView];
    }
//    if( [_orderType isEqualToString:@"1"] ){
//        //已完成
//        self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_packageDetail"];
//        PackageDetailView *detailView = [[PackageDetailView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
//        self.packageView = detailView;
//        [self.view addSubview:detailView];
//
//    }
    else if( [_orderType isEqualToString:@"2"] ){
        //扫描取餐
        self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"Booking_confirmOrder"];
        BookingDetailView * detailView = [[BookingDetailView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight) orderType:self.orderType];
        [detailView.bottomBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_confirm"] forState:UIControlStateNormal];
        [detailView.bottomBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        self.bookingDetailView = detailView;
        [self.view addSubview:detailView];
    }
    
    
    
    //注册获取预约订单详情通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBookingDetailFunction) name:@"getBookingDetailNotification" object:nil];
    //扫码取餐通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scanBookingSuccessFunction) name:@"scanBookingSuccessNotification" object:nil];
    
    //model
    self.bookingModel = [[BookingModel alloc] init];
    [self.bookingModel getDetailOrderData:self.bookingId];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 通知

- (void)getBookingDetailFunction{
    BookingOrderDetailObj * detail = self.bookingModel.bookingDetail;
    
    if( detail.pay_by_wechat && [self.orderType isEqualToString:@"0"] && [self compareCurrentTime:detail.reserve_get_time] ){
        self.navigationItem.rightBarButtonItem = self.rightBarItem;
    }
  
    if([self.orderType isEqualToString:@"0"]){
        //未完成订单布局,扫码取餐
        [self.bookingDetailView setNotCompletedOrderUI:self.bookingModel.bookingDetail];
    }else if([self.orderType isEqualToString:@"1"]){
        //已完成订单布局
        [self.bookingDetailView setHasCompletedOrderUI:self.bookingModel.bookingDetail];
    }else{
        //扫码订单布局，type==2
        [self.bookingDetailView setScanBookingOrderUI:self.bookingModel.bookingDetail];
    }
    
    self.bookingDetailView.dishDS = self.bookingModel.bookingDetail.dish_list.mutableCopy;
    [self.bookingDetailView.dishesTable reloadData];
}

- (void)scanBookingSuccessFunction{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -3)] animated:NO];
}

#pragma mark - 点击事件

- (void)printClick:(id)sender{
    if( [self.orderType isEqualToString:@"0"]){
        //打印小票
        [self.bookingModel printBookingOrder:self.bookingId];
    }
}

- (void)confirmClick:(id)sender{
    if( [_orderType isEqualToString:@"2"]){
        //确认取餐
        [self.bookingModel confirmBookingOrder:self.bookingId];
    }
}

- (void)cancelOrder{
    NSLog(@"取消订单");
    AlertView * cancelOrderAlert = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) title:[MyUtils GETCurrentLangeStrWithKey:@"Booking_cancelOrder"]];
    [cancelOrderAlert.sureBtn addTarget:self action:@selector(cancelSure) forControlEvents:UIControlEventTouchUpInside];
    [cancelOrderAlert showWithAnimation:YES];
    _alertView = cancelOrderAlert;
}

- (void)cancelSure{
    //取消订单
    [self.bookingModel cancelBookingOrder:self.bookingId];
    [_alertView hideWithAnimation:NO];
}

#pragma mark - 时间判断

- (BOOL)compareCurrentTime:(NSString *)eatingTime{
    BOOL permit = YES;
    //1.订单预约时间转时间戳
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate * nsDate = [formatter dateFromString:eatingTime];
    //时间转时间戳的方法
    NSInteger eating = [[NSNumber numberWithDouble:[nsDate timeIntervalSince1970] * 1000] integerValue];
    
    //2.系统时间转时间戳
    NSDate * systemDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval system = [systemDate timeIntervalSince1970] * 1000;//*1000精确到毫秒
    NSString * systemString = [NSString stringWithFormat:@"%.0f", system];//转为字符型
    
    if( [systemString integerValue] > eating){
        permit = NO;
    }
    return permit;
}

@end
