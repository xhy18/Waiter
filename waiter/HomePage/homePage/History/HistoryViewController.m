//
//  HistoryViewController.m
//  waiter
//
//  Created by renxin on 2019/4/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "HistoryViewController.h"
#import "BWTHistoryView.h"
#import "BWTHistoryModel.h"

@interface HistoryViewController ()
@property(nonatomic , strong) BWTHistoryView *historyPageView;
@property(nonatomic , strong) BWTHistoryModel *historyModel;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.historyModel = [[BWTHistoryModel alloc]init];
    [self.historyModel GetHistoryList];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_HistoryDataFromServer) name:@"Get_HistoryDataFromServer" object:nil];

    
   
    // Do any additional setup after loading the view.
}


-(void)Get_HistoryDataFromServer{
    NSLog(@"😂");
    CGRect stateRect = [[UIApplication sharedApplication] statusBarFrame];
    self.historyPageView = [[BWTHistoryView alloc]initWithFrame:CGRectMake(0,  stateRect.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - stateRect.size.height)
                            DataArry:_historyModel.historyInfo];

    [self.historyPageView.backButton addTarget:self action:@selector(GoBackToHomePage) forControlEvents:UIControlEventTouchUpInside];
    _historyPageView.getTipDelegate = self;
    [self.view addSubview:self.historyPageView];
    
    
}

//-(void)getTipData:(NSString *)tableName{
//    OptionHistoryViewController * optionVC = [[OptionHistoryViewController alloc]init];
//    optionVC.tableName = tableName;
//    [self.navigationController pushViewController:optionVC animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)GoBackToHomePage{
    [self.navigationController popViewControllerAnimated:YES];
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
