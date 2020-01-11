//
//  PackagingManageViewController.m
//  waiter
//
//  Created by ltl on 2019/7/12.
//  Copyright © 2019 renxin. All rights reserved.
//  打包管理控制器

#import "PackagingManageViewController.h"
#import "PackagingManageView.h"
#import "PackagingManageModel.h"

#import "PackageDetailViewController.h"
#import "PackageSetUpViewController.h"

#import "Header.h"
#import "MyUtils.h"

@interface PackagingManageViewController ()<PackagingManageViewDelegte>{
    int page;
}

@property(nonatomic, strong) PackagingManageModel * packageModel;
@property(nonatomic, strong) PackagingManageView * packageView;

@end

@implementation PackagingManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    
    //title
    self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_titlt"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置按钮
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(setUp)];
    rightBarItem.image = [self reSizeImage:[UIImage imageNamed:@"set.png"] toSize:CGSizeMake(35, 35)];
    rightBarItem.tag = 1;
    self.navigationItem.rightBarButtonItem = rightBarItem;
   
    //view
    float sch = SCREENHEIGHT;
    float top = TOPOFFSET;
    float mainHeight = sch - top;
    PackagingManageView * packageView = [[PackagingManageView alloc] initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
    self.packageView = packageView;
    self.packageView.delegate = self;
    [self.view addSubview:packageView];
    
    //model
    self.packageModel = [[PackagingManageModel alloc] init];
    [self.packageModel getNotPackageData:@"1"];
    [self.packageModel getHasPackageData:@"1"];
    
    //未完成订单通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_All_Not_Package_Data) name:@"getAllNotPackageData" object:nil];
    //已完成订单通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_All_Package_Data) name:@"getAllPackageData" object:nil];
    //打印完小票，刷新通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload_Table_Data) name:@"reloadTableData" object:nil];
    //取消订单，刷新通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(after_Cancel_Table_Data) name:@"afterCancelTableData" object:nil];

}

#pragma mark - 通知方法

//请求完未完成打包之后执行
- (void)get_All_Not_Package_Data{
    self.packageView.packageArray = self.packageModel.notPackageArray.mutableCopy;
    [self.packageView.notCompleteTable reloadData];
    [self.packageView endFreshHeader:self.packageView.notCompleteTable];
    [self.packageView endFreshFooter:self.packageView.notCompleteTable];
}

//请求完历史打包之后执行
- (void)get_All_Package_Data{
    self.packageView.hasPackageArray = self.packageModel.hasPackageArray.mutableCopy;
    [self.packageView.completeTable reloadData];
    [self.packageView endFreshHeader:self.packageView.completeTable];
}

//打小票后重新请求数据
- (void)reload_Table_Data{
    [self.packageModel getNotPackageData:@"1"];
}

//取消后重新请求数据
- (void)after_Cancel_Table_Data{
    [self.packageModel getNotPackageData:@"1"];
    [self.packageModel getHasPackageData:@"1"];
}

#pragma mark - 导航栏设置控制

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)setUp{
    PackageSetUpViewController * setUpVC = [[PackageSetUpViewController alloc] init];
    [self.navigationController pushViewController:setUpVC animated:TRUE];
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
    NSLog(@"移除所有通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - PackagingManageView视图代理

//下拉刷新
- (void)newData:(int)table{
    if(table == -1){
        [self.packageModel getNotPackageData:@"1"];
    }else{
        [self.packageModel getHasPackageData:@"1"];
    }
}

//上拉加载
- (void)moreData:(int)table{
    page++;
    NSLog(@"hahahhhaha-%d",page);
    [self.packageModel getNotPackageData:[NSString stringWithFormat:@"%d",page]];
}

//订单详情
- (void)orderType:(NSString *)orderType packageId:(NSString *)packageNum{
    NSLog(@"有没有view的单号%@",packageNum);
    NSLog(@"类型%@",orderType);
    
    PackageDetailViewController * detailsVC = [[PackageDetailViewController alloc] init];
    detailsVC.orderType = orderType;
    detailsVC.packageNum = packageNum;
    [self.navigationController pushViewController:detailsVC animated:TRUE];
}

@end
