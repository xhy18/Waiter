//
//  BWTTableNumberViewController.m
//  waiter
//
//  Created by Haze_z on 2019/8/1.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BWTTableNumberViewController.h"
#import "Header.h"
#import "MyUtils.h"
#import "WaiterCollectionReusableView.h"
#import "BWTTableNumberModel.h"
#import "BWTTableNumDetailViewController.h"


@interface BWTTableNumberViewController ()
@property(nonatomic , strong)BWTTableNumberModel *tableNumModel;
//@property(nonatomic , strong)TableNumber *tableNumData;
@end

@implementation BWTTableNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"index_tableManage"];
    
    self.tableNumModel = [[BWTTableNumberModel alloc]init];
    [self.tableNumModel GetTableNumber];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_TableNumFromServer) name:@"Get_TableNumFromServer" object:nil];

    
//    [self.tableBtn addTarget:self action:@selector(ClickTheTableNumButton) forControlEvents:UIControlEventTouchUpInside];
}
    
-(void)Get_TableNumFromServer{
   
    self.tableDS = @[].mutableCopy;
    self.tableDS = self.tableNumModel.tableInfo.mutableCopy;
    if(self.tableDS.count !=0){
    CGFloat btnRange = 5;
    CGFloat btnWidth = 115;
    CGFloat w = 5;
    CGFloat h = 100;
        for (int i = 0; i<_tableDS.count; i++){
        self.tableBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        self.tableBtn.backgroundColor = SHALLOWGRAYCOLOR2;
        self.tableBtn.layer.cornerRadius = 10.0;
        [self.tableBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.tableBtn setTitle:_tableDS[i].tableNum forState:UIControlStateNormal];
        self.tableBtn.frame = CGRectMake(btnRange + w, h, btnWidth, 60);
        [self.tableBtn setTag:100 + i];
        [self.tableBtn addTarget:self action:@selector(ClickTheTableNumButton) forControlEvents:UIControlEventTouchUpInside];
        
        if(btnRange +w +btnWidth >self.view.frame.size.width){
            w = 5;
            h = h + self.tableBtn.frame.size.height + 10;
            self.tableBtn.frame = CGRectMake(btnRange + w, h, btnWidth, 60);
        }
        w = self.tableBtn.frame.size.width + self.tableBtn.frame.origin.x;
        [self.view addSubview:self.tableBtn];
    }
    }else{
        NSLog(@"WRONG!");
    }
}

-(void)ClickTheTableNumButton{
    BWTTableNumDetailViewController * QRimageVC = [[BWTTableNumDetailViewController alloc]init];
    QRimageVC.tableString = self.tableBtn.titleLabel.text;
    [self.navigationController pushViewController:QRimageVC animated:YES];
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
