//
//  BWTTableNumDetailViewController.m
//  waiter
//
//  Created by Haze_z on 2019/8/5.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BWTTableNumDetailViewController.h"
#import "Header.h"
#import "BWTTableNumberModel.h"

@interface BWTTableNumDetailViewController ()
@property(nonatomic , strong)BWTTableNumberModel * tableNumModel;

@end

@implementation BWTTableNumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"蜀味";
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    NSLog(@"!!!!:%@",self.tableString);
    self.tableNumModel = [[BWTTableNumberModel alloc]init];
    [self.tableNumModel GetTable_QRCode:self.tableString];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_TableQRImageFromServer) name:@"Get_TableQRImageFromServer" object:nil];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)Get_TableQRImageFromServer{
    
    
    self.TableNumView = [[UIView alloc]init];
    self.TableNumView.backgroundColor = SHALLOWGRAYCOLOR2;//[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    self.TableNumView.frame = CGRectMake(38, 100, self.view.frame.size.width*0.8, 35);
    [self.view addSubview:self.TableNumView];
    
    self.tableNumLabel = [[UILabel alloc]init];
    self.tableNumLabel.text = @"桌号：1";
    self.tableNumLabel.textColor = [UIColor blackColor];
    self.tableNumLabel.textAlignment = NSTextAlignmentCenter;
    self.tableNumLabel.font = [UIFont boldSystemFontOfSize:16.0];
    self.tableNumLabel.frame = CGRectMake(100, 15, 80, 10);
    [self.TableNumView addSubview:self.tableNumLabel];
    
    self.QRCodeImage = [[UIImageView alloc]init];
    self.QRCodeImage.backgroundColor = [UIColor redColor];
    self.QRCodeImage.frame = CGRectMake(80, 170, self.view.frame.size.width*0.5, self.view.frame.size.width*0.5);
//    [self.QRCodeImage
    [self.view addSubview:self.QRCodeImage];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
