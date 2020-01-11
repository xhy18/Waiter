//
//  LogViewController.m
//  waiter
//
//  Created by renxin on 2019/3/18.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "LogViewController.h"
#import "LogView.h"
@interface LogViewController ()
@property(nonatomic,strong)LogView * loginView;
@end
@implementation LogViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _loginView = [[LogView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width)];
    [self.view addSubview:_loginView];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"deviceStringtongzhi"object:nil];
    
    // Do any additional setup after loading the view.
}
@end
