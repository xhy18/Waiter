//
//  PackageSetUpViewController.m
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//  打包设置

#import "PackageSetUpViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
#import "MyUtils.h"
#import "MyAFNetWorking.h"
#import "AlertView.h"

@interface PackageSetUpViewController ()

//打包开关
@property(nonatomic, strong) UISwitch * isOpenPackage;
@property(nonatomic, strong) AlertView * alertView;

@end

@implementation PackageSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_setUp"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * setUpView = [[UILabel alloc]initWithFrame:CGRectMake(20, TOPOFFSET, SCREENWIDTH*0.8-30, 50)];
    setUpView.text = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_openPackage"];
    setUpView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:setUpView];
    
    UISwitch * isOpenPackage = [[UISwitch alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.80, TOPOFFSET+10, SCREENWIDTH*0.2, 100)];
    isOpenPackage.on = NO;
    isOpenPackage.transform = CGAffineTransformMakeScale( 1.2, 1.2);//缩放
    [isOpenPackage addTarget:self action:@selector(isClosePackage:) forControlEvents:UIControlEventValueChanged];
    _isOpenPackage = isOpenPackage;
    [self.view addSubview:isOpenPackage];
    
    [self getPackageState];
}

- (void)isClosePackage:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];//点击后的状态
    if (isButtonOn) {
        NSLog(@"开");
        AlertView * openAlert = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) title:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_isOpenPackage"]];
        [openAlert.cancelBtn addTarget:self action:@selector(openCancel) forControlEvents:UIControlEventTouchUpInside];
        [openAlert.sureBtn addTarget:self action:@selector(openSure) forControlEvents:UIControlEventTouchUpInside];
        [openAlert showWithAnimation:YES];
        _alertView = openAlert;
    }else{
        NSLog(@"关");
        
        AlertView * closeAlert = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) title:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_isClosePackage"]];
        [closeAlert.cancelBtn addTarget:self action:@selector(closeCancel) forControlEvents:UIControlEventTouchUpInside];
        [closeAlert.sureBtn addTarget:self action:@selector(closeSure) forControlEvents:UIControlEventTouchUpInside];
        [closeAlert showWithAnimation:YES];
        _alertView = closeAlert;
    }
}

#pragma mark - 弹窗事件

- (void)openCancel{
    self.isOpenPackage.on = NO;
    [_alertView hideWithAnimation:NO];
}

- (void)openSure{
    [self changePackageState:true];
    [_alertView hideWithAnimation:NO];
}

- (void)closeCancel{
    self.isOpenPackage.on = YES;
    [_alertView hideWithAnimation:NO];
}

- (void)closeSure{
    [self changePackageState:false];
    [_alertView hideWithAnimation:NO];
}

#pragma mark - 大堂经理修改商家打包开关开启状态

- (void)changePackageState:(BOOL)state{
    NSString * openState = state?@"True":@"False";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];

    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             openState,@"new_open_status",
                             nil];
    NSLog(@"%@",parDic);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MyAFNetWorking PostHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/UpdateTakeOutStatus/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"changePackageState改打包状态%@",responseObject);
            //success
            if([responseObject[@"res_code"] integerValue] == 0){
                [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"ChangeSuccess"]];
            }
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){

        } OtherBlock:^(id other){

        }];
    });
}

#pragma mark - 大堂经理获取商家打包状态

- (void)getPackageState{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * shopId = [defaults objectForKey:@"shopId"];
    NSString * token = [defaults objectForKey:@"token"];
    NSDictionary * parDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             shopId,@"shop_id",
                             token,@"token",
                             nil];
    NSLog(@"%@",parDic);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MyAFNetWorking GetHttpDataWithUrlStr:[NSString stringWithFormat:@"%@manager/TakeOutStatusObtain/?",wbaseUrl] Dic:parDic SuccessBlock:^(id responseObject){
            NSLog(@"getPackageState获取打包状态%@",responseObject);
            if([responseObject[@"res_code"] integerValue] == 0){
                BOOL state = [responseObject[@"data"][@"is_open"] boolValue];
                if(state){
                    self.isOpenPackage.on = YES;
                }else{
                    self.isOpenPackage.on = NO;
                }
            }
        }FailedBlock:^(id error){
            NSLog(@"%@",error);
        } InvalidBlock:^(id invalid){
            
        } OtherBlock:^(id other){
            
        }];
    });
}

@end
