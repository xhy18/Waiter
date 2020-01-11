//
//  OptionHistoryViewController.m
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "OptionHistoryViewController.h"
#import "OptionHistoryView.h"
#import "OptionHistoryModel.h"
#import "Header.h"
#import "MyUtils.h"
@interface OptionHistoryViewController ()
@property(nonatomic,strong) OptionHistoryModel * optionModel;
@property(nonatomic,strong) OptionHistoryView * optionView;
@end

@implementation OptionHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%@:%@",@"桌号",_tableName];
    self.optionModel = [[OptionHistoryModel alloc]init];
    [self.optionModel getWaiterHistoryList:self.tableName];
    // Do any additional setup after loading the view.
}
-(void)Get_WaiterHistoryFromServer{
    NSLog(@"通知");
    CGFloat HEIGHT = SCREENHEIGHT - TOPOFFSET;
    self.optionView = [[OptionHistoryView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, HEIGHT) DataArry:self.optionModel.waiterHistoryData];
    _optionView.dealCallDelegate = self;
    [self.view addSubview:self.optionView];
}
-(void)getTipData{
    [_optionModel dealCustomCall:self.tableName];
}
-(void)DealCustomCall_SuccessFromServer{
    [self.optionModel getWaiterHistoryList:self.tableName];
}
-(void)viewWillAppear:(BOOL)animated{
    //设置参数
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_WaiterHistoryFromServer) name:@"Get_WaiterHistoryFromServer" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DealCustomCall_SuccessFromServer) name:@"DealCustomCall_Success" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
