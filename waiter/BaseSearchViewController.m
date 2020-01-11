//
//  BaseSearchViewController.m
//  waiter
//
//  Created by ltl on 2019/9/10.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "MyUtils.h"
#import "header.h"

@interface BaseSearchViewController (){
    CGRect titleView;
    UIBarButtonItem * searchBarItem;
    UIBarButtonItem * hideBarItem;
}

@property (strong, nonatomic) UIView * canvas;

@end

@implementation BaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    titleView = self.navigationItem.titleView.frame;
    
    searchBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(changeBarButton)];
    searchBarItem.image = [MyUtils reSizeImage:[UIImage imageNamed:@"25_25-8.png"] toSize:CGSizeMake(35, 35)];
    searchBarItem.tag = 1;

    
    hideBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(changeBarButton)];
    hideBarItem.image = [MyUtils reSizeImage:[UIImage imageNamed:@"hide.png"] toSize:CGSizeMake(35, 35)];
    hideBarItem.tag = -1;
   
    self.navigationItem.rightBarButtonItem = searchBarItem;
}

- (void)changeBarButton{
    int tag = (int)self.navigationItem.rightBarButtonItem.tag;
    if( tag == 1 ){
        //显示搜索框
        self.navigationItem.rightBarButtonItem = hideBarItem;
        [self showSearchView];
    }else{
        //隐藏搜索框
        self.navigationItem.rightBarButtonItem = searchBarItem;
        [self hideSearchView];
    }
}

- (void)showSearchView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSLog(@"width---%f",width - 120);
    UIView * canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width - 120, 30)];
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width - 120, 30)];
    backgroundView.layer.cornerRadius = 3;
    backgroundView.userInteractionEnabled = YES;
    backgroundView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    backgroundView.layer.shadowOpacity = 0.5;
    backgroundView.layer.shadowOffset = CGSizeMake(0.8, 0.8);
    backgroundView.backgroundColor = GLOBALGRAYCOLOR;
    self.canvas = canvas;
    [canvas addSubview:backgroundView];
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 2, backgroundView.frame.size.width - backgroundView.frame.size.height + 4, backgroundView.frame.size.height - 4)];
    textField.font = [UIFont systemFontOfSize:14];
    self.textField = textField;
    [backgroundView addSubview:textField];
    
    UIImageView * search = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width - backgroundView.frame.size.height, 0, backgroundView.frame.size.height, backgroundView.frame.size.height)];
    search.image = [UIImage imageNamed:@"25_25-8.png"];
    search.userInteractionEnabled = YES;
    [backgroundView addSubview:search];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchfunction)];
    [search addGestureRecognizer:tap];
    
    
//    [UIView animateWithDuration:5
//                     animations:^{
//                         canvas.frame = CGRectMake(0, 0, width - 120, 30);
//
//                     }
//                     completion:^(BOOL finished) {
                         self.navigationItem.titleView =  canvas;
//                     }];

    /**
     * usingSpringWithDamping的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显
     * initialSpringVelocity则表示初始的速度，数值越大一开始移动越快。
     */
/*
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //阻尼动画
        canvas.frame = CGRectMake(0, 0, width - 120, 30);
        self.navigationItem.titleView =  canvas;
        
        //        self.normalNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
       
        //        self.highNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
       
    } completion:^(BOOL finished) {
        //        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ////            self.contentView.backgroundColor = [UIColor orangeColor];
        //        } completion:nil];
    }];
*/
    NSLog(@"ying--%f",self.navigationItem.titleView.frame.size.width);
}

- (void)hideSearchView{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.canvas.frame = CGRectMake(width - 120 - 60, 0, 0, 30);
//    } completion:^(BOOL finished) {
        self.navigationItem.titleView = nil;
//    }];
}

- (void)searchfunction{
    NSLog(@"在子类中重写");
}

@end
