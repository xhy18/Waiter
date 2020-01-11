//
//  DishViewController.m
//  waiter
//
//  Created by renxin on 2019/4/30.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "DishViewController.h"
#import "MenuManageModel.h"
@interface DishViewController ()
@property(strong,nonatomic) MenuManageModel * dishModel;
@end

@implementation DishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dishModel = [[MenuManageModel alloc]init];
    [_dishModel GetAllDishList];
    // Do any additional setup after loading the view.
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
