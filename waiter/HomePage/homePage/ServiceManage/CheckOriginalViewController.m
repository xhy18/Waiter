//
//  CheckOriginalViewController.m
//  waiter
//
//  Created by renxin on 2019/7/22.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "CheckOriginalViewController.h"
#import "Header.h"
#import "PrefixHeader.pch"
@interface CheckOriginalViewController ()

@end

@implementation CheckOriginalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat offsetX = (SCREENWIDTH-SCREENHEIGHT/3)/2;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(offsetX, SCREENHEIGHT/3, SCREENHEIGHT/3, SCREENHEIGHT/3)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:nil];
    [self.view addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BackToWaiter)];
    [imgView addGestureRecognizer:tapGesture];
}
-(void)BackToWaiter{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
@end
