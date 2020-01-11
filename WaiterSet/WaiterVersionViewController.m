//
//  WaiterVersionViewController.m
//  waiter
//
//  Created by renxin on 2019/4/11.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "WaiterVersionViewController.h"
#import "MyUtils.h"
#import "header.h"
@interface WaiterVersionViewController ()

@end

@implementation WaiterVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"Setting_Version"];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    //设置参数
    NSLog(@"appear");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)initUI{
    UIImageView * scanbee = [[UIImageView alloc] init];
    scanbee.frame = CGRectMake((SCREENWIDTH-100)/2, (SCREENHEIGHT-100)/2-30, 100, 100);
    scanbee.image = [UIImage imageNamed:@"bee.png"];
    [self.view addSubview:scanbee];
    UILabel * version = [[UILabel alloc] init];
    version.frame = CGRectMake(0, scanbee.frame.size.height+scanbee.frame.origin.y+5, SCREENWIDTH, 30);
    version.text = [MyUtils GETCurrentLangeStrWithKey:@"Setting_versionNumber"];
    version.font = [UIFont systemFontOfSize:13];
    version.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:version];
}

@end
