//
//  JumpType_1_ViewController.m
//  waiter
//
//  Created by Haze_z on 2019/8/9.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "JumpType_1_ViewController.h"
#import "Header.h"
#import "MyUtils.h"
#import "JumpType_1_Model.h"
#import "JumpType_1_View.h"

@interface JumpType_1_ViewController ()
@property(nonatomic , strong)JumpType_1_View * dishDetailView;
@property(nonatomic , strong)JumpType_1_Model * dishDetailModel;
@end

@implementation JumpType_1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.dishDetailModel = [[JumpType_1_Model alloc]init];
    [self.dishDetailModel GetManagerOrderDetail:self.orderId];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetOrderDish_Detail) name:@"GetOrderDish_Detail" object:nil];
    // Do any additional setup after loading the view.
}

-(void)GetOrderDish_Detail{
    NSLog(@"😂");
    if([self.dishDetailModel.checkStatus isEqualToString:@"0"]){
        self.title = [MyUtils GETCurrentLangeStrWithKey:@"order_confirm"];
    }else{
        self.title = [MyUtils GETCurrentLangeStrWithKey:@"OrderManage_orderDetail"];
    }
    
    CGRect stateRect = [[UIApplication sharedApplication] statusBarFrame];
    self.dishDetailView = [[JumpType_1_View alloc]initWithFrame:CGRectMake(0,  stateRect.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - stateRect.size.height) DataArry:_dishDetailModel.dishInfo singleDataArry:_dishDetailModel.singledishInfo packDataArry:_dishDetailModel.packdishInfo];
    _dishDetailView.getDishDelegate = self;
    
    [self.view addSubview:self.dishDetailView];
    _dishDetailView.tableNum.text = [NSString stringWithFormat:@"%@%@",[MyUtils GETCurrentLangeStrWithKey:@"serverManage_table"],_dishDetailModel.tableNum];
    _dishDetailView.orderNum.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderId"],_dishDetailModel.orderNum];
    _dishDetailView.personNum.text = [NSString stringWithFormat:@"%@",_dishDetailModel.personNum];
    _dishDetailView.total.text = [NSString stringWithFormat:@"%@%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"],_dishDetailModel.orderPrice];
    if([self.dishDetailModel.checkStatus isEqualToString:@"0"]){
    }else{
        _dishDetailView.passBtn.hidden = YES;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    //设置参数
    //    NSLog(@"appear");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)dealloc{
    NSLog(@"消失了");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

