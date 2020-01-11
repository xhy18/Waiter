//
//  SCBNavigationViewController.m
//  Scan bee
//
//  Created by 秦焕 on 2018/11/14.
//  Copyright © 2018年 秦焕. All rights reserved.
//

#import "SCBNavigationViewController.h"
#import "Header.h"
@interface SCBNavigationViewController ()

@end

@implementation SCBNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count >0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    [viewController.navigationController setNavigationBarHidden:NO];
    //去掉返回按钮的文字

    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    //    这句代码去掉了导航栏所有的文字
//    viewController.navigationController.navigationBar.topItem.title = @"";
    self.navigationBar.tintColor = BLACKCOLOR ;   //设置返回按钮为主色调
    self.navigationBar.shadowImage = [UIImage new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
