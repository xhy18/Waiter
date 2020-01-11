//
//  BookingViewController.m
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BookingViewController.h"
#import "BookingView.h"
#import "BookingModel.h"
#import "BookingDetailViewController.h"

#import "Header.h"
#import "MyUtils.h"
#import "MJRefresh.h"
#import "AlertView.h"

@interface BookingViewController ()<BookingViewDelegte>{
    int notPage;
    int hasPage;
}

@property(nonatomic, strong) BookingModel * bookingModel;
@property(nonatomic, strong) BookingView * bookingView;

@property(nonatomic, strong) AlertView * alertView;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    notPage = 1;
    hasPage = 1;
    
    //title
    self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"Booking_title"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //view
    float sch = SCREENHEIGHT;
    float top = TOPOFFSET;
    float mainHeight = sch - top;
    BookingView * bookingView = [[BookingView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
    [bookingView.isOpenBooking addTarget:self action:@selector(isChangeBooking:) forControlEvents:UIControlEventValueChanged];
    self.bookingView = bookingView;
    self.bookingView.delegate = self;
    [self.view addSubview:bookingView];
    
    //注册获取未完成预约通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotFinishBookingFunction) name:@"getNotFinishBookingNotification" object:nil];
    //注册未完成，上拉无新数据通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noMoreNotFinishFunction) name:@"noMoreNotFinishNotification" object:nil];
    //注册获取已完成预约通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCompletedBookingFunction) name:@"getCompletedBookingNotification" object:nil];
    //注册已完成，上拉无新数据通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noMoreCompletedFunction) name:@"noMoreCompletedNotification" object:nil];
    //注册获取预约状态通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBookingStatusFunction) name:@"getBookingStatusNotification" object:nil];
    //注册关闭预约通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeBookingFunction) name:@"closeBookingNotification" object:nil];
    //注册开启预约通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openBookingFunction) name:@"openBookingNotification" object:nil];
    //注册确认打印小票通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(printTicketFunction) name:@"printTicketNotification" object:nil];
    //注册取消订单通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelOrderFunction) name:@"cancelOrderNotification" object:nil];
    
    //model
    self.bookingModel = [[BookingModel alloc] init];
    [self.bookingModel getNotFinishBookingData:@"1"];
    [self.bookingModel getCompletedBookingData:@"1"];
    [self.bookingModel getBookingStatus];
}

#pragma mark - 视图控制

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 操作

- (void)isChangeBooking:(id)sender{
    UISwitch * switchButton = (UISwitch*)sender;
    BOOL isOn = [switchButton isOn];//点击后的状态
    if (isOn) {
        NSLog(@"开");
        AlertView * openAlert = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) title:[MyUtils GETCurrentLangeStrWithKey:@"Toast_ifConfirmToOpenBooking"]];
        [openAlert.cancelBtn addTarget:self action:@selector(openAlert_Cancel) forControlEvents:UIControlEventTouchUpInside];
        [openAlert.sureBtn addTarget:self action:@selector(openAlert_Sure) forControlEvents:UIControlEventTouchUpInside];
        [openAlert showWithAnimation:YES];
        self.alertView = openAlert;
        
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_open"]];
    }else{
        NSLog(@"关");
        AlertView * closeAlert = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) title:[MyUtils GETCurrentLangeStrWithKey:@"Toast_ifConfirmToCloseBooking"]];
        [closeAlert.cancelBtn addTarget:self action:@selector(closeAlert_Cancel) forControlEvents:UIControlEventTouchUpInside];
        [closeAlert.sureBtn addTarget:self action:@selector(closeAlert_Sure) forControlEvents:UIControlEventTouchUpInside];
        [closeAlert showWithAnimation:YES];
        self.alertView = closeAlert;
        
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_close"]];
    }
}

#pragma mark - 弹窗操作

- (void)openAlert_Cancel{
    self.bookingView.isOpenBooking.on = NO;
    self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_close"]];
    [self.alertView hideWithAnimation:NO];
}

- (void)openAlert_Sure{
    [self.bookingModel openBooking];
    [self.alertView hideWithAnimation:NO];
}

- (void)closeAlert_Cancel{
    self.bookingView.isOpenBooking.on = YES;
    self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_open"]];
    [self.alertView hideWithAnimation:NO];
}

- (void)closeAlert_Sure{
    [self.bookingModel closeBooking];
    [self.alertView hideWithAnimation:NO];
}

#pragma mark - 通知方法

//未完成预约通知实现
- (void)getNotFinishBookingFunction{
    //1.先reload，直接看到新数据
    self.bookingView.notCompleteArray = self.bookingModel.notFinishArray.mutableCopy;
    [self.bookingView.notCompleteTable reloadData];
    //2.更新刷新状态
    [self.bookingView.notCompleteTable.mj_header endRefreshing];
    self.bookingView.notCompleteTable.mj_footer.state = MJRefreshStateIdle;
}

//未完成 无新数据通知实现
- (void)noMoreNotFinishFunction{
    [self.bookingView.notCompleteTable.mj_footer endRefreshingWithNoMoreData];
}

//已完成预约通知实现
- (void)getCompletedBookingFunction{
    //1.先reload，直接看到新数据
    self.bookingView.hasCompleteArray = self.bookingModel.completedArray.mutableCopy;
    [self.bookingView.completeTable reloadData];
    //2.更新刷新状态
    [self.bookingView.completeTable.mj_header endRefreshing];
    self.bookingView.completeTable.mj_footer.state = MJRefreshStateIdle;
}

//已完成 无新数据通知实现
- (void)noMoreCompletedFunction{
    [self.bookingView.completeTable.mj_footer endRefreshingWithNoMoreData];
}

//获取预约状态通知实现
- (void)getBookingStatusFunction{
    if(self.bookingModel.bookingSwitchStatus){
        self.bookingView.isOpenBooking.on = YES;
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_open"]];
    }else{
        self.bookingView.isOpenBooking.on = NO;
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_close"]];
    }
}

//关闭预约通知实现
- (void)closeBookingFunction{
    self.bookingView.isOpenBooking.on = self.bookingModel.bookingSwitchStatus;
    if(self.bookingView.isOpenBooking){
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_close"]];
    }else{
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_open"]];
    }
}

//开启预约通知实现
- (void)openBookingFunction{
    self.bookingView.isOpenBooking.on = self.bookingModel.bookingSwitchStatus;
    if(self.bookingView.isOpenBooking){
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_open"]];
    }else{
        self.bookingView.bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_close"]];
    }
}

//打印小票通知实现
- (void)printTicketFunction{
    [self.navigationController popViewControllerAnimated:YES];
    [self.bookingModel getNotFinishBookingData:@"1"];
}

//取消订单通知实现
- (void)cancelOrderFunction{
    [self.navigationController popViewControllerAnimated:YES];
    [self.bookingModel getNotFinishBookingData:@"1"];
}

#pragma mark - PackagingManageView delegate

//下拉刷新（左表-1，右表1）
- (void)newData:(int)table{
    if(table == -1){
        notPage = 1;
        [self.bookingModel getNotFinishBookingData:@"1"];
    }else{
        hasPage = 1;
        [self.bookingModel getCompletedBookingData:@"1"];
    }
}

//上拉加载
- (void)moreData:(int)table{
    if(table == -1){
        if([self.bookingModel.interStatus1 isEqualToString:@"internetSuccess"]){
            notPage++;
        }
        [self.bookingModel getNotFinishBookingData:[NSString stringWithFormat:@"%d",notPage]];
        self.bookingView.notCompleteTable.mj_footer.state = MJRefreshStateIdle;
    }else{
        if([self.bookingModel.interStatus2 isEqualToString:@"internetSuccess"]){
            hasPage++;
        }
        [self.bookingModel getCompletedBookingData:[NSString stringWithFormat:@"%d",hasPage]];
        self.bookingView.completeTable.mj_footer.state = MJRefreshStateIdle;
    }
}

//订单详情
- (void)orderType:(NSString *)type bookingOrderId:(NSString *)orderId{
    BookingDetailViewController * detailsVC = [[BookingDetailViewController alloc] init];
    detailsVC.orderType = type;
    detailsVC.bookingId = orderId;
    [self.navigationController pushViewController:detailsVC animated:TRUE];
}

@end
