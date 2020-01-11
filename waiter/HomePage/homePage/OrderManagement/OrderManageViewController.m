//
//  OrderManageViewController.m
//  waiter
//
//  Created by renxin on 2019/4/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "OrderManageViewController.h"
#import "ManageOrderDetailViewController.h"
#import "CheckOrderDetailViewController.h"
#import "MyUtils.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "OrderManageModel.h"
#import "OrderManageView.h"
#import "orderInfo.h"
@interface OrderManageViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) OrderManageModel * orderListModel;
@property(nonatomic,strong) OrderManageView * orderListView;
@property(nonatomic,strong)UIView * navView;//导航视图
@property(nonatomic,strong)UILabel * sliderLabel;//手势滑动焦点
@property(nonatomic,strong)UIButton * unconfirmBtn;
@property(nonatomic,strong)UIButton * unpayBtn;
@property(nonatomic,strong)UIScrollView * mainScrollView;//滚动视图
@end

@implementation OrderManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单管理";
    [self initUI];
    [self setMainScrollView];
    self.orderListModel = [[OrderManageModel alloc]init];
    [self.orderListModel GetUnconfirmOrderList];
    [self.orderListModel GetUnpayOrderList];
}
-(void)initUI{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH,60)];
    self.navView.backgroundColor = [UIColor whiteColor];
    self.unconfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unconfirmBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2, 50);
    self.unconfirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.unconfirmBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.unconfirmBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"menu_MenuManageBtn"] forState:UIControlStateNormal];
    [self.unconfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.unconfirmBtn.tag = 101;
    self.unconfirmBtn.selected = YES;
    [self.navView addSubview:self.unconfirmBtn];
    self.unpayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unpayBtn.frame = CGRectMake(self.unconfirmBtn.frame.origin.x + _unconfirmBtn.frame.size.width, 0, SCREENWIDTH/2, 50);
    self.unpayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.unpayBtn.tag = 102;
    [self.unpayBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.unpayBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"menu_FoodManageBtn"] forState:UIControlStateNormal];
    [self.unpayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.navView addSubview:self.unpayBtn];
    self.sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH/2-85)/2, 50, 85, 3)];
    self.sliderLabel.backgroundColor = [UIColor redColor];
    self.sliderLabel.layer.cornerRadius = 3;
    self.sliderLabel.layer.masksToBounds = YES;
    [self.navView addSubview:self.sliderLabel];
    
    [self.view addSubview:self.navView];
}
-(void)setMainScrollView{
    
    CGFloat scrollOff = TOPOFFSET + self.navView.frame.size.height + 3;
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollOff, SCREENWIDTH, SCREENHEIGHT-scrollOff)];
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH*2, SCREENHEIGHT-scrollOff);
    _mainScrollView.delegate = self;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
}
-(void)sliderAction:(UIButton *)button{
    //ScrollView滚动到特定的位置
    [_mainScrollView setContentOffset:CGPointMake(SCREENWIDTH * (button.tag - 101), 0) animated:YES];
    [button setSelected:YES];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curBtn = (_mainScrollView.contentOffset.x + SCREENWIDTH / 2) / SCREENWIDTH + 1;
    //    NSLog(@"按钮：%ld",(long)curBtn);
    for(NSInteger i = 1; i <= 2; ++i){
        UIButton *btn = (UIButton *)[[scrollView superview]viewWithTag: i + 100];
        if(btn.tag - 100 == curBtn){
            [btn setSelected:YES];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
                [self.sliderLabel setFrame:CGRectMake(btn.frame.origin.x + (SCREENWIDTH/2-85)/2, 50, 85, 3)];
            }];
        }else{
            [btn setSelected:NO];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }
    }
}
-(void)Get_UnconfirmOrderFromServer{
    CGFloat scrollOff = TOPOFFSET + self.navView.frame.size.height + 3;
    self.orderListView = [[OrderManageView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-scrollOff) DataArry:self.orderListModel.theOrderArray];
    self.orderListView.selectDelegate = self;
    [self.mainScrollView addSubview:self.orderListView];

}
-(void)Get_UnpayOrderFromServer{
    CGFloat scrollOff = TOPOFFSET + self.navView.frame.size.height + 3;
    self.orderListView = [[OrderManageView alloc]initWithFrame:CGRectMake(SCREENWIDTH,0, SCREENWIDTH, SCREENHEIGHT-scrollOff) DataArry:self.orderListModel.unpayOrderArray];
    self.orderListView.selectDelegate = self;
    [self.mainScrollView addSubview:self.orderListView];
}
//view中的代理方法
-(void)PassTheOrderByTable:(NSString *)orderTable{
    [self.orderListModel PassOrderByTable:orderTable];
}
-(void)Get_PassOrderSuccess{
    [self.orderListModel GetUnconfirmOrderList];
    [self.orderListModel GetUnpayOrderList];
    [self.orderListView reloadTable];
}
-(void)refresh_orderList{
    [self.orderListModel GetUnconfirmOrderList];
    [self.orderListView reloadTable];
}
-(void)CheckOrderDetailByOrderId:(NSString *)orderId{
    CheckOrderDetailViewController * checkVC = [[CheckOrderDetailViewController alloc]init];
    checkVC.orderId = orderId;
    [self.navigationController pushViewController:checkVC animated:YES];
}
-(void)ManageOrderByOrderId:(NSString *)orderId{
    ManageOrderDetailViewController * manageVC = [[ManageOrderDetailViewController alloc]init];
    manageVC.orderId = orderId;
    [self.navigationController pushViewController:manageVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_UnconfirmOrderFromServer) name:@"Get_UnconfirmOrderFromServer" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_UnpayOrderFromServer) name:@"Get_UnpayOrderListFromServer" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Get_PassOrderSuccess) name:@"PassOrder_Success" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh_orderList) name:@"PassSingleOrder_Success" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh_orderList) name:@"RefuseOrder_Success" object:nil];

}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
