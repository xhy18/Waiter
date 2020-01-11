//
//  CustomManageViewController.m
//  waiter
//
//  Created by renxin on 2019/4/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "CustomManageViewController.h"
#import "CustomManageView.h"
#import "CustomManageModel.h"
#import "OptionHistoryViewController.h"
#import "Header.h"
#import "MyUtils.h"
@interface CustomManageViewController ()
@property (nonatomic,strong)CustomManageModel * customModel;
@property(nonatomic,strong)CustomManageView * customView;
@end

@implementation CustomManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"呼叫管理";
    self.customModel = [[CustomManageModel alloc]init];
    [_customModel GetCustomCallList];
    // Do any additional setup after loading the view.
}


-(void)Get_CallInfoFromServer{
    CGFloat HEIGHT = SCREENHEIGHT - TOPOFFSET;
    self.customView = [[CustomManageView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, HEIGHT) DataArry:_customModel.customCallInfo];
    _customView.getTipDelegate = self;
    [self.view addSubview:self.customView];
}
//view中定义的代理方法
-(void)getTipData:(NSString *)tableName{
    OptionHistoryViewController * optionVC = [[OptionHistoryViewController alloc]init];
    optionVC.tableName = tableName;
    [self.navigationController pushViewController:optionVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    //设置参数
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_CallInfoFromServer) name:@"Get_CallFromServer" object:nil];

}
-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
