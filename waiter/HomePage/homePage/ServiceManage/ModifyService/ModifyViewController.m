//
//  ModifyViewController.m
//  waiter
//
//  Created by renxin on 2019/7/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ModifyViewController.h"
#import "Header.h"
#import "MyUtils.h"
#import "ModifyServiceModel.h"
#import "ModifyServiceView.h"
#import "serverManageModel.h"
#import "serverManageView.h"
@interface ModifyViewController ()
@property(strong,nonatomic) ModifyServiceModel * modifyModel;
@property(strong,nonatomic) ModifyServiceView * modifyView;
@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"serverManage_addTitle"];
    self.modifyModel = [[ModifyServiceModel alloc]init];
    if(self.modifyWaiterId == nil){
        [_modifyModel GetTableInformation];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_TableInfoFromServer) name:@"Get_TableInformation" object:nil];
    }
    else{
        [_modifyModel GetTableInfoByWaiterId:self.modifyWaiterId];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_TableWaiterInfoFromServer) name:@"Get_TableInfoByWaiterId" object:nil];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateWaiterSuccess_FromServer) name:@"UpdateWaiterSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AddWaiterSuccess_FromServer) name:@"AddWaiterSuccess" object:nil];

    
}
-(void)Get_TableInfoFromServer{
    
    CGFloat HEIGHT = SCREENHEIGHT - TOPOFFSET;
    self.modifyView = [[ModifyServiceView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, HEIGHT) DataArry:_modifyModel.tableInfo];
    _modifyView.modifyWaiterDelegate = self;
    [self.view addSubview:self.modifyView];
}

-(void)Get_TableWaiterInfoFromServer{
    CGFloat HEIGHT = SCREENHEIGHT - TOPOFFSET;
    self.modifyView = [[ModifyServiceView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, HEIGHT) DataArry:_modifyModel.tableWaiterInfo waiterName:self.modifyWaiterName];
    self.modifyView.modifyWaiterDelegate = self;
    [self.view addSubview:self.modifyView];
}

//实现view中定义的代理方法
-(void)addServerData:(NSMutableArray<NSDictionary *>*)dataArray waiterName:(NSString *)waiterName type:(NSString *)type{
    if(self.modifyWaiterId == nil){
        [self.modifyModel addWaiterInfo:dataArray nameInfo:waiterName];
    }
    else{
        [self.modifyModel updateWaiterInfo:dataArray nameInfo:waiterName idInfo:_modifyWaiterId type:type];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
