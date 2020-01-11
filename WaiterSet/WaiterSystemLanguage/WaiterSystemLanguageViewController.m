//
//  WaiterSystemLanguageViewController.m
//  waiter
//
//  Created by renxin on 2019/4/10.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "WaiterSystemLanguageViewController.h"
#import "WaiterSystemModel.h"
#import "WaiterSystemUIView.h"
#import "MyUtils.h"
#import "Header.h"
@interface WaiterSystemLanguageViewController ()<SelectLanguageDelegate>
@property(nonatomic,strong)NSArray<SetLanguage *> *languageArray;
@property(nonatomic,strong)WaiterSystemModel * languageModel;
@property(nonatomic,strong)WaiterSystemUIView * theView;
@end

@implementation WaiterSystemLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"Setting_SystemLanguage"];
    
    self.theView = [[WaiterSystemUIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH)];
    self.theView.delegate = self;
    [self.view addSubview:self.theView];
    self.languageModel = [[WaiterSystemModel alloc]init];
    NSArray *languageName = @[@"Francais(France)",@"English(U.K)",@"简体中文"];
    NSArray *languageType = @[@"fr",@"en",@"zh-Hans"];
    NSArray *languageSmallName = @[[MyUtils GETCurrentLangeStrWithKey:@"sys_language_french"],[MyUtils GETCurrentLangeStrWithKey:@"sys_language_english"],[MyUtils GETCurrentLangeStrWithKey:@"sys_language_chinese"]];
    self.languageModel.NameArray = languageName.mutableCopy;
    self.languageModel.typeArray = languageType.mutableCopy;//得到可以修改的内存对象
    self.languageModel.SmallNameArray = languageSmallName.mutableCopy;
    [self.languageModel initLanguageArray];
    self.theView.languageArray = self.languageModel.languageArray.copy;//不可修改的内存对象
    [self.theView.languageTable reloadData];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//设置语言
-(void)SelectLanguageIndex:(NSUInteger)index{
    [self.languageModel SelectIndex:index HaveChangeLanguageArray:^(NSMutableArray<SetLanguage *> *array){
        //更新数据
        self.languageArray = @[].copy;
        self.languageArray = array.copy;
        //刷新tableView
        [self.theView.languageTable reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Change_theDefaultLanguage" object:nil];
//        self.tabBarController.selectedIndex = 0;
//        [self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
       
    }];
    
}
#pragma mark - Navigation

 -(void)viewWillAppear:(BOOL)animated{
 //设置参数
 NSLog(@"appear");
 self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
 self.navigationController.navigationBarHidden = NO;
 }
 -(void)viewWillDisappear:(BOOL)animated{
 self.navigationController.navigationBarHidden = YES;
 }

@end
