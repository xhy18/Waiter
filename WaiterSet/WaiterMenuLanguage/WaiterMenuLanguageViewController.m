//
//  WaiterMenuLanguageViewController.m
//  waiter
//
//  Created by renxin on 2019/4/10.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "WaiterMenuLanguageViewController.h"
#import "SetLanguageTableViewCell.h"
#import "MyUtils.h"
#import "Header.h"
#define statusHeight [UIApplication sharedApplication].statusBarFrame.size.height
@interface WaiterMenuLanguageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger index;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray * tmpArray;
@property(nonatomic,strong)NSArray *subArray;
@property(nonatomic,strong)NSArray *languageSubmitArray;//提交到后台的语言内容字段
@end
@implementation WaiterMenuLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"Setting_MenuLanguage"];
    //self.navigationController.navigationBar.translucent = NO;
    //self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tmpArray = @[[MyUtils GETCurrentLangeStrWithKey:@"Chinese"],[MyUtils GETCurrentLangeStrWithKey:@"Chinese"],[MyUtils GETCurrentLangeStrWithKey:@"English"],[MyUtils GETCurrentLangeStrWithKey:@"Franch"],[MyUtils GETCurrentLangeStrWithKey:@"German"],[MyUtils GETCurrentLangeStrWithKey:@"Italian"],[MyUtils GETCurrentLangeStrWithKey:@"Japanese"],[MyUtils GETCurrentLangeStrWithKey:@"Korean"],[MyUtils GETCurrentLangeStrWithKey:@"Portuguese"],[MyUtils GETCurrentLangeStrWithKey:@"Russian"],[MyUtils GETCurrentLangeStrWithKey:@"Spanish"],[MyUtils GETCurrentLangeStrWithKey:@"Arabe"]];
    self.subArray = @[@"简体中文",@"English",@"Français",@"Deutsch",@"Italiano",@"日本語",@"한국어",@"Português",@"русский",@"Español",@"عربي"];
    self.languageSubmitArray = @[@"zh-cn",@"en-ww",@"fr-fr",@"de-de",@"it-it",@"ja-jp",@"ko-kr",@"pt-pt",@"ru-ru",@"es-ww",@"ar-ww"];
    //获取当前的语言
    NSString *currentLanguage = [MyUtils GetDishLanguage];
    for(int i = 0 ; i < self.languageSubmitArray.count ; i++){
        if([currentLanguage isEqualToString:self.languageSubmitArray[i]]){
            index = i;
            break;
        }
    }
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-statusHeight-40) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.01)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SetLanguageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfiglangIndexCell1"];
    if(!cell){
        cell = [[SetLanguageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ConfiglangIndexCell1"];
    }
    cell.smallNameLabel.text = self.tmpArray[indexPath.row];
    cell.bigNameLabel.text = self.subArray[indexPath.row];
    if(index == indexPath.row){
        cell.selectedImage.hidden = NO;
    }else{
        cell.selectedImage.hidden = YES;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    index = indexPath.row;
    [MyUtils SetDishLanguage:[NSString stringWithFormat:@"%@",self.languageSubmitArray[index]]];
    [self.tableView reloadData];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
