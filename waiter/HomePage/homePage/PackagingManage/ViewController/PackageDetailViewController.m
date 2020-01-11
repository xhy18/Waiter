//
//  PackageDetailViewController.m
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//  打包详情控制器

#import "PackageDetailViewController.h"
#import "NotPackageDetailView.h"
#import "PackageDetailView.h"
#import "PackagingManageModel.h"
#import "ViewController.h"
#import "AlertView.h"
#import "Header.h"
#import "MyUtils.h"

@interface PackageDetailViewController ()
////<NotPackageDetailViewDelegte>

@property(nonatomic, strong) PackagingManageModel * packageModel;
@property(nonatomic, strong) NotPackageDetailView * notPackageView;
@property(nonatomic, strong) PackageDetailView * packageView;
@property(nonatomic, strong) AlertView * alertView;

//打包订单详情结构
@property(nonatomic, strong) PackageOrderDetailObj *packageDetail;

@end

@implementation PackageDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"推出%@",_orderType);
    NSLog(@"推出%@",_packageNum);
    self.packageDetail = [[PackageOrderDetailObj alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //model
    self.packageModel = [[PackagingManageModel alloc] init];
    [self.packageModel getDetailOrderData:self.packageNum];
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrder)];
    rightBarItem.image = [self reSizeImage:[UIImage imageNamed:@"cancel1.png"] toSize:CGSizeMake(30, 30)];
    rightBarItem.tag = 1;
    
    float sch = SCREENHEIGHT;
    float top = TOPOFFSET;
    float mainHeight = sch - top;
    
    if( [_orderType isEqualToString:@"0"] ){
        //未打包
        NSLog(@"0000000");
        self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_packageDetail"];
        NotPackageDetailView *detailView = [[NotPackageDetailView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
        [detailView.bottomBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_printTicket"] forState:UIControlStateNormal];
        [detailView.bottomBtn addTarget:self action:@selector(printClick:) forControlEvents:UIControlEventTouchUpInside];
        self.notPackageView = detailView;
        [self.view addSubview:detailView];
        self.navigationItem.rightBarButtonItem = rightBarItem;
        
        
    }if( [_orderType isEqualToString:@"1"] ){
        //已完成
        self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_packageDetail"];
        PackageDetailView *detailView = [[PackageDetailView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
        self.packageView = detailView;
        [self.view addSubview:detailView];
        
    }else if( [_orderType isEqualToString:@"2"] ){
        //扫描取餐
        self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_guestConfirmPackage"];
        NotPackageDetailView *detailView = [[NotPackageDetailView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
        [detailView.bottomBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_confirm"] forState:UIControlStateNormal];
        [detailView.bottomBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        self.notPackageView = detailView;
        [self.view addSubview:detailView];
    }
    
    //获取订单号通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change_Detail_Order) name:@"changeDetailOrder" object:nil];
    //获取订单号通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(package_Success) name:@"packageSuccess" object:nil];
}

#pragma mark - 点击事件

- (void)printClick:(id)sender{
    if( [_orderType isEqualToString:@"0"]){
        //打印小票
        [self.packageModel printPackageOrder:self.packageNum];
    }
}

- (void)confirmClick:(id)sender{
    if( [_orderType isEqualToString:@"2"]){
        //确认取餐
        [self.packageModel confirmPackageOrder:self.packageNum];
    }
}

- (void)cancelOrder{
    NSLog(@"取消订单");
    AlertView * cancelOrderAlert = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) title:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_isCancelPackage"]];
    [cancelOrderAlert.sureBtn addTarget:self action:@selector(cancelSure) forControlEvents:UIControlEventTouchUpInside];
    [cancelOrderAlert showWithAnimation:YES];
    _alertView = cancelOrderAlert;
    
    
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_isCancelPackage"] preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancel"] style:UIAlertActionStyleDefault handler:nil]];
//    [alert addAction:[UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        //取消订单
//        [self.packageModel cancelPackageOrder:self.packageNum];
//    }]];
//    [self presentViewController:alert animated:true completion:nil];
}

- (void)cancelSure{
    //取消订单
    [self.packageModel cancelPackageOrder:self.packageNum];
    [_alertView hideWithAnimation:NO];
}

#pragma mark - 通知

- (void)change_Detail_Order{
    self.packageDetail = self.packageModel.packageDetail;
    if( [_orderType isEqualToString:@"0"] || [_orderType isEqualToString:@"2"]){
        [self.notPackageView changeOrderInfo:self.packageDetail];
    }else{
        [self.packageView changeOrderInfo:self.packageDetail];
    }
}

- (void)package_Success{
    ViewController * vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 导航栏图标设置控制

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
