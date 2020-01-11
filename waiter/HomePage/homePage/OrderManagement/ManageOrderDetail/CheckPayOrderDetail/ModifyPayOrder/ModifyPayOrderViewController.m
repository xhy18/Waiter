//
//  ModifyPayOrderViewController.m
//  waiter
//
//  Created by renxin on 2019/7/27.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ModifyPayOrderViewController.h"
#import "Header.h"
#import "MyUtils.h"
@interface ModifyPayOrderViewController (){
   int index;
}
@end

@implementation ModifyPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.paymentInfo = _paymentDishOrderDS[0];
    index = 1000;
    self.title = _paymentInfo.orderTable;
    self.view.backgroundColor = [UIColor whiteColor];
    self.modifyModel = [[ModifyPayOrderModel alloc]init];
    [self initUI];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    NSLog(@"INIT");
    CGFloat offsetH = SCREENHEIGHT-TOPOFFSET;
    NSLog(@"%f",(SCREENWIDTH-30)*2/3);
    NSLog(@"%f",(SCREENWIDTH));
    NSLog(@"%f",(SCREENWIDTH-30)/3);
    self.totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(15, TOPOFFSET+10, (SCREENWIDTH-30)*2/3,45)];
    _totalPrice.text = @"总价：0.00 €";
    _totalPrice.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:_totalPrice];
    
    self.deleteBtn= [[UIButton alloc]initWithFrame:CGRectMake(((SCREENWIDTH-15)*2/3), TOPOFFSET+15, (SCREENWIDTH-30)/3,40)];
    _deleteBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deletePayOrderDish) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.view addSubview:_deleteBtn];
    
    self.dishTableView = [[UITableView alloc]initWithFrame:CGRectMake(15, TOPOFFSET+65, SCREENWIDTH-30, offsetH-45-100) style:UITableViewStylePlain];
    self.dishTableView.delegate = self;
    self.dishTableView.dataSource = self;
    _dishTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_dishTableView];

    self.payOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH/6, SCREENHEIGHT - 100, SCREENWIDTH*2/3, 60)];
    _payOrderBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _payOrderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _payOrderBtn.layer.cornerRadius = 30.0f;
    [_payOrderBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"serverManage_addConfirm"] forState:UIControlStateNormal];
    [_payOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_payOrderBtn];
    [_payOrderBtn addTarget:self action:@selector(submitWaiter) forControlEvents:UIControlEventTouchUpInside];
}
-(void)submitWaiter{
    self.submitData = [[NSMutableArray<NSDictionary *> alloc]init];
    for (NSInteger i = 0;i<_paymentDishOrderDS.count;i++){
        paymentDishInfo * tempInfo = [[paymentDishInfo alloc]init];
        tempInfo = _paymentDishOrderDS[i];
        if([tempInfo.selectedPayDish isEqualToString:@"1"]){
            NSLog(@"%@",tempInfo.dishName);
            
            NSDictionary * tempDic = [[NSDictionary alloc]initWithObjectsAndKeys:tempInfo.dishType,@"dish_type",tempInfo.dishId,@"dish_id",nil];
            [_submitData addObject:tempDic];
        }
    }
    [self.modifyModel PayDishOrderByOrderId:_paymentInfo.dishId dishes:_submitData];
}
-(void)deletePayOrderDish{
    self.submitData = [[NSMutableArray<NSDictionary *> alloc]init];
    for (NSInteger i = 0;i<_paymentDishOrderDS.count;i++){
        paymentDishInfo * tempInfo = [[paymentDishInfo alloc]init];
        tempInfo = _paymentDishOrderDS[i];
        if([tempInfo.selectedPayDish isEqualToString:@"1"]){
            NSLog(@"%@",tempInfo.dishName);
            
            NSDictionary * tempDic = [[NSDictionary alloc]initWithObjectsAndKeys:tempInfo.dishType,@"dish_type",tempInfo.dishId,@"dish_id",nil];
            [_submitData addObject:tempDic];
        }
    }
    [self.modifyModel DeleteDishOrderByOrderId:_paymentInfo.dishId dishes:_submitData];
}
#pragma mark -- UITableViewDelegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.paymentDishOrderDS.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier =[NSString stringWithFormat:@"%@%ld",@"orderDetail",(long)indexPath.row];
    UITableViewCell *cell = [_dishTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    paymentDishInfo * payDishInfo = _paymentDishOrderDS[indexPath.row];
    cell.backgroundColor = GRAYCOLOR;
    UIView * orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-30, 40)];
    [cell.contentView addSubview:orderView];
    
    UILabel * dishNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, (SCREENWIDTH-30)*2/3, 40)];
    dishNameLabel.font = [UIFont systemFontOfSize:14];
    dishNameLabel.text = payDishInfo.dishName;
    [orderView addSubview:dishNameLabel];
    
    
    UILabel * dishPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-15)*2/3, 0, (SCREENWIDTH-30)/6, 40)];
    dishPriceLabel.font = [UIFont systemFontOfSize:14];
    dishPriceLabel.text = payDishInfo.dishPrice;
    [orderView addSubview:dishPriceLabel];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*5/6, 8, 23, 23)];
    imgView.image = [UIImage imageNamed:@"check"];
    imgView.backgroundColor = GRAYCOLOR;
    UITapGestureRecognizer * selectTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectLackDish:)];
    [imgView addGestureRecognizer:selectTapGesture];
    imgView.tag = indexPath.row;
    imgView.hidden = NO;
    [orderView addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    
    
    UIImageView * imgSelectedView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*5/6, 8, 23, 23)];
    imgSelectedView.backgroundColor = GRAYCOLOR;
    imgSelectedView.image = [UIImage imageNamed:@"selected"];
    UITapGestureRecognizer * cancelSelectGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelSelectLackDish:)];
    [imgSelectedView addGestureRecognizer:cancelSelectGesture];
    imgSelectedView.hidden = YES;
    imgSelectedView.tag = indexPath.row;
    [orderView addSubview:imgSelectedView];
    imgSelectedView.userInteractionEnabled = YES;
    
    if(index == 1001){
        imgView.hidden = YES;
        imgSelectedView.hidden = NO;
    }
    else{
        imgView.hidden = NO;
        imgSelectedView.hidden = YES;
    }
    return cell;
}
#pragma mark--行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)selectLackDish:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    self.paymentDishOrderDS[tap.view.tag].selectedPayDish = @"1";
    index = 1001;
    [_dishTableView reloadData];
}
-(void)cancelSelectLackDish:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    self.paymentDishOrderDS[tap.view.tag].selectedPayDish = @"0";
    index = 1000;
    [_dishTableView reloadData];
}
@end
