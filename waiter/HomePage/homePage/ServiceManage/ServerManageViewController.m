//
//  ServerManageViewController.m
//  waiter
//
//  Created by renxin on 2019/4/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ServerManageViewController.h"
#import "serverManageView.h"
#import "serverManageModel.h"
#import "Header.h"
#import "MyUtils.h"
#import "ModifyViewController.h"
#import "CheckOriginalViewController.h"
@interface ServerManageViewController ()
@property(strong,nonatomic) serverManageView * serverView;
@property(strong,nonatomic) serverManageModel * serverModel;
@property(strong,nonatomic) NSString * currentDeleteWaiterId;
@end

@implementation ServerManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"serverManage_title"];
    self.serverModel = [[serverManageModel alloc]init];
    [_serverModel getAllWaiterList];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_WaiterFromServer) name:@"Get_WaiterListFromServer" object:nil];

    // Do any additional setup after loading the view.
}
-(void)Get_WaiterFromServer{
    
    CGFloat HEIGHT = SCREENHEIGHT - TOPOFFSET;
    _serverView = [[serverManageView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, HEIGHT) DataArry:_serverModel.waiterInfoList];
    _serverView.changeServerDelegate = self;
    [self.view addSubview:_serverView];
}
//实现view中定义的代理方法
-(void)deleteServerById:(NSString *)serverId Name:(NSString *)serverName{
//    self.currentDeleteWaiterId = serverId;
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"是否要删除服务员 %@?",serverName] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureBtn = [UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self->_serverModel deleteWaiterById:serverId];
    }];
    UIAlertAction * cancelBtn = [UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancell"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
    }];

    [alertVC addAction:cancelBtn];
    [alertVC addAction:sureBtn];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//实现view中定义的代理方法
-(void)modifyServerById:(NSString *)serverId Name:(NSString *)serverName{
    ModifyViewController * modifyVC = [[ModifyViewController alloc]init];
    modifyVC.modifyWaiterId = serverId;
    modifyVC.modifyWaiterName = serverName;
    [self.navigationController pushViewController:modifyVC animated:YES];
}
-(void)checkOriginal:(NSString *)img{
    CheckOriginalViewController * checkVC = [[CheckOriginalViewController alloc]init];
    checkVC.imgStr = img;
    [self.navigationController pushViewController:checkVC animated:YES];
}
-(void)addServer{
    ModifyViewController * modifyVC = [[ModifyViewController alloc]init];
    [self.navigationController pushViewController:modifyVC animated:YES];
}
//-(void)Delete_WaiterFromServer{
//    [self.serverModel getAllWaiterList];
//    [self.serverView reloadTable];
//}
-(void)UpdateWaiterSuccess_FromServer{
    [self.serverModel getAllWaiterList];
    [self.serverView reloadTable];
    
}
//-(void)AddWaiterSuccess_FromServer{
//    [self.serverModel getAllWaiterList];
//    [self.serverView reloadTable];
//
//}
-(void)viewWillAppear:(BOOL)animated{
    //设置参数
    NSLog(@"appear");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_WaiterFromServer) name:@"Get_WaiterListFromServer" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateWaiterSuccess_FromServer) name:@"Delete_WaiterSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateWaiterSuccess_FromServer) name:@"UpdateWaiterSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateWaiterSuccess_FromServer) name:@"AddWaiterSuccess" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
