//
//  ModifyPayOrderView.m
//  waiter
//
//  Created by renxin on 2019/8/1.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ModifyPayOrderView.h"
#import "Header.h"
#import "MyUtils.h"
@interface ModifyPayOrderView (){
    double totalNum;
}
@end
@implementation ModifyPayOrderView
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<paymentDishInfo*> *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        self.paymentDishOrderDS = @[].mutableCopy;
        for(NSInteger i = 0;i<dataArray.count;i++){
            paymentDishInfo * payDishInfo = dataArray[i];
            if([payDishInfo.payStatus isEqualToString:@"0"]){
                NSLog(@"%@",payDishInfo.payStatus);
                [self.paymentDishOrderDS addObject:dataArray[i]];
            }
        }

        [self initUI];
    }
    return self;
    
}
-(void)initUI{
  
    self.totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, (SCREENWIDTH-30)*2/3,45)];
    _totalPrice.text =[NSString stringWithFormat:@"%@%.2f%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"],0.00,@"€"];
    _totalPrice.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:_totalPrice];
    
    self.deleteBtn= [[UIButton alloc]initWithFrame:CGRectMake(((SCREENWIDTH-15)*2/3), 15, (SCREENWIDTH-30)/3,40)];
    _deleteBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deletePayOrderDish) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"serverManage_delete"] forState:UIControlStateNormal];
    [self addSubview:_deleteBtn];
    
    self.dishTableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 65, SCREENWIDTH-30, self.frame.size.height-60-85) style:UITableViewStylePlain];
    self.dishTableView.delegate = self;
    self.dishTableView.dataSource = self;
    _dishTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_dishTableView];
    
    self.payOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH/6, self.frame.size.height - 70, SCREENWIDTH*2/3, 50)];
    _payOrderBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _payOrderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _payOrderBtn.layer.cornerRadius = 25.0f;
    [_payOrderBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"OrderManage_payUseCash"] forState:UIControlStateNormal];
    [_payOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_payOrderBtn];
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
    [_modifyDishDelegate PayDishOrderDishes:_submitData];
//    [self.modifyModel PayDishOrderByOrderId:self.orderId dishes:_submitData];
}
-(void)deletePayOrderDish{
    self.submitData = [[NSMutableArray<NSDictionary *> alloc]init];
    for (NSInteger i = 0;i<_paymentDishOrderDS.count;i++){
        paymentDishInfo * tempInfo = [[paymentDishInfo alloc]init];
        tempInfo = _paymentDishOrderDS[i];
        if([tempInfo.selectedPayDish isEqualToString:@"1"]){
            NSLog(@"dishId:%@",tempInfo.dishId);
            
            NSDictionary * tempDic = [[NSDictionary alloc]initWithObjectsAndKeys:tempInfo.dishType,@"dish_type",tempInfo.dishId,@"dish_id",nil];
            [_submitData addObject:tempDic];
        }
    }
    [_modifyDishDelegate DeleteDishOrderDishes:_submitData];
//    [self.modifyModel DeleteDishOrderByOrderId:self.orderId dishes:_submitData];
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
    if([payDishInfo.payStatus isEqualToString:@"0"]){
        cell.backgroundColor = GRAYCOLOR;
        UIView * orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-30, 40)];
        [cell.contentView addSubview:orderView];
        
        UILabel * dishNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREENWIDTH/2, 40)];
        dishNameLabel.font = [UIFont systemFontOfSize:14];
        dishNameLabel.text = payDishInfo.dishName;
        [orderView addSubview:dishNameLabel];
        
        
        UILabel * dishPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-15)*2/3, 0, (SCREENWIDTH-30)/6, 40)];
        dishPriceLabel.font = [UIFont systemFontOfSize:14];
        dishPriceLabel.text = [NSString stringWithFormat:@"%.2f%@",atof(payDishInfo.dishPrice.UTF8String),@"€"];
        //    dishPriceLabel.text = payDishInfo.dishPrice;
        [orderView addSubview:dishPriceLabel];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*5/6 +10, 8, 23, 23)];
        imgView.image = [UIImage imageNamed:@"check"];
        imgView.backgroundColor = GRAYCOLOR;
        UITapGestureRecognizer * selectTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectLackDish:)];
        [imgView addGestureRecognizer:selectTapGesture];
        imgView.tag = indexPath.row;
        imgView.hidden = NO;
        [orderView addSubview:imgView];
        imgView.userInteractionEnabled = YES;
        
        
        UIImageView * imgSelectedView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*5/6+10, 8, 23, 23)];
        imgSelectedView.backgroundColor = GRAYCOLOR;
        imgSelectedView.image = [UIImage imageNamed:@"selected"];
        UITapGestureRecognizer * cancelSelectGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelSelectLackDish:)];
        [imgSelectedView addGestureRecognizer:cancelSelectGesture];
        imgSelectedView.hidden = YES;
        imgSelectedView.tag = indexPath.row;
        [orderView addSubview:imgSelectedView];
        imgSelectedView.userInteractionEnabled = YES;
        
        if([payDishInfo.selectedPayDish isEqualToString:@"1"]){
            imgView.hidden = YES;
            imgSelectedView.hidden = NO;
        }
        else{
            imgView.hidden = NO;
            imgSelectedView.hidden = YES;
        }
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
    [_dishTableView reloadData];
    totalNum += self.paymentDishOrderDS[tap.view.tag].dishPrice.doubleValue;
    _totalPrice.text =[NSString stringWithFormat:@"%@%.2f%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"],totalNum,@"€"];
}
-(void)cancelSelectLackDish:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    self.paymentDishOrderDS[tap.view.tag].selectedPayDish = @"0";
    [_dishTableView reloadData];
    totalNum -= self.paymentDishOrderDS[tap.view.tag].dishPrice.doubleValue;
    _totalPrice.text =[NSString stringWithFormat:@"%@%.2f%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"],totalNum,@"€"];
}

@end
