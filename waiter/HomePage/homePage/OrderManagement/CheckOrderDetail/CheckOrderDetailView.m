//
//  CheckOrderDetailView.m
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "CheckOrderDetailView.h"
#import "Header.h"
#import "MyUtils.h"
@implementation CheckOrderDetailView{
    CGFloat tempH ;
    CGFloat orderH;
    NSString * selectedDishLack;
}
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<unconfirmOrderInfo*> *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        selectedDishLack = @"0";
        self.userInteractionEnabled = YES;
        self.unconfirmOrderDetailDS = @[].mutableCopy;
        self.unconfirmOrderDetailDS = dataArray.mutableCopy;
        self.lackDishArray = @[].mutableCopy;
        [self initUI];
    }
    return self;
    
}
-(void)initUI{
    NSLog(@"%f",SCREENHEIGHT);
    NSLog(@"%f",self.frame.size.height);
    unconfirmOrderInfo * info = _unconfirmOrderDetailDS[0];
   
    self.customerLabel = [[UILabel alloc]init];
    _customerLabel.text = info.customer;
    _customerLabel.font = [UIFont boldSystemFontOfSize:14];
        
    self.consumeAverageLabel = [[UILabel alloc]init];
    _consumeAverageLabel.text = [NSString stringWithFormat:@"%@%@ / %@%@",info.average_consume,@"€", info.consume_times,@"次"];
    _consumeAverageLabel.font = [UIFont boldSystemFontOfSize:14];
   
    self.orderTimeLabel = [[UILabel alloc]init];
    _orderTimeLabel.text = [NSString stringWithFormat:@"%@:%@",@"下单时间",info.orderTime];
    _orderTimeLabel.font = [UIFont boldSystemFontOfSize:14];
    
    self.orderNumLabel = [[UILabel alloc]init];
    _orderNumLabel.text = [NSString stringWithFormat:@"%@:%@",@"订单号",info.orderNum];
    _orderNumLabel.font = [UIFont boldSystemFontOfSize:14];
    
    self.orderTableLabel = [[UILabel alloc]init];
    _orderTableLabel.text = [NSString stringWithFormat:@"%@:%@",@"桌号",info.orderTable];
    _orderTableLabel.font = [UIFont boldSystemFontOfSize:14];
    
    self.lackBtn = [[UIButton alloc]init];
    _lackBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _lackBtn.layer.cornerRadius = 20.0f;
    _lackBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _lackBtn.tag = 1001;
    
    [_lackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lackBtn addTarget:self action:@selector(lackDish:) forControlEvents:UIControlEventTouchUpInside];
    [_lackBtn setTitle:@"缺菜" forState:UIControlStateNormal];
    
    
    self.orderDetailTable = [[UITableView alloc]init];
    _orderDetailTable.delegate = self;
    _orderDetailTable.dataSource = self;
    _orderDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.refuseBtn = [[UIButton alloc]init];
    [_refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [_refuseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_refuseBtn addTarget:self action:@selector(refuseOrder) forControlEvents:UIControlEventTouchUpInside];
    _refuseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _refuseBtn.backgroundColor = [UIColor whiteColor];
    _refuseBtn.layer.borderColor = [[UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1]CGColor];
    _refuseBtn.layer.borderWidth = 1.0f;
    _refuseBtn.layer.cornerRadius = 24.0f;

    
    self.passBtn = [[UIButton alloc]init];
    [_passBtn setTitle:@"通过" forState:UIControlStateNormal];
    [_passBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_passBtn addTarget:self action:@selector(passOrder) forControlEvents:UIControlEventTouchUpInside];
    _passBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _passBtn.layer.cornerRadius = 24.0f;
    _passBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
   
    [self addSubview:_customerLabel];
    [self addSubview:_consumeAverageLabel];
    [self addSubview:_orderTimeLabel];
    [self addSubview:_orderNumLabel];
    [self addSubview:_orderTableLabel];
    [self addSubview:_lackBtn];
    [self addSubview:_refuseBtn];
    [self addSubview:_passBtn];
    [self addSubview:_orderDetailTable];
}
-(void)layoutSubviews{
    unconfirmOrderInfo * info = _unconfirmOrderDetailDS[0];
    if([info.isAboutWaiter isEqualToString:@"0"]){
        self.customerLabel.frame = CGRectMake(15, 0, (SCREENWIDTH-30)*2/3, 50);
        self.consumeAverageLabel.frame = CGRectMake((SCREENWIDTH-30)*2/3, 0, (SCREENWIDTH-30)/3, 50);
    }
    else{
        self.customerLabel.frame = CGRectMake(15, 0, (SCREENWIDTH-30)*2/3, 0);
        self.consumeAverageLabel.frame = CGRectMake((SCREENWIDTH-30)*2/3, 0, (SCREENWIDTH-30)/3, 0);
    }
    CGFloat customH = self.customerLabel.frame.origin.y+self.customerLabel.frame.size.height;
    self.orderTimeLabel.frame = CGRectMake(15,customH, SCREENWIDTH-30, 50);
    self.orderNumLabel.frame = CGRectMake(15, customH+50, SCREENWIDTH-30, 50);
    self.orderTableLabel.frame = CGRectMake(15, customH+50*2, (SCREENWIDTH-30)*2/3, 50);
    self.lackBtn.frame = CGRectMake((SCREENWIDTH-30)*2/3, customH+50*2, (SCREENWIDTH-30)/3, 40);
    CGFloat orderH = self.orderTableLabel.frame.origin.y+self.orderTableLabel.frame.size.height;
    self.orderDetailTable.frame = CGRectMake(0, orderH, SCREENWIDTH, SCREENHEIGHT-orderH-150);
    self.refuseBtn.frame = CGRectMake(SCREENWIDTH/21, SCREENHEIGHT-130, (SCREENWIDTH)*3/7, 45);
    self.passBtn.frame = CGRectMake(SCREENWIDTH*43/82, SCREENHEIGHT - 130, (SCREENWIDTH)*3/7, 45);
}
#pragma mark -- UITableViewDelegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.unconfirmOrderDetailDS.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier =[NSString stringWithFormat:@"%@%ld",@"orderDetail",(long)indexPath.row];
    UITableViewCell *cell = [_orderDetailTable dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //动态计算备注的高度
    NSString * remark = [NSString stringWithFormat:@"%@ : %@",@"备注",_unconfirmOrderDetailDS[indexPath.row].dishOptions];
    CGFloat labelH = [remark boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width;
    int needLine = (int)ceil(labelH/(SCREENWIDTH-30));
    tempH = 15*needLine;
    
    
    UIView * orderView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREENWIDTH-30, 30+tempH)];
    [cell.contentView addSubview:orderView];
    
    UILabel * dishNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH-30)*5/6, 30)];
    dishNameLabel.text = _unconfirmOrderDetailDS[indexPath.row].dishName;
    dishNameLabel.font = [UIFont systemFontOfSize:14];
    [orderView addSubview:dishNameLabel];
    
    
    UILabel * dishNumLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*5/6, 0, (SCREENWIDTH-30)/6, 30)];
    dishNumLabel.text =[ NSString stringWithFormat:@"%@%@",@"×",_unconfirmOrderDetailDS[indexPath.row].dishNumber];
    dishNumLabel.hidden = YES;
    [orderView addSubview:dishNumLabel];
    
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*5/6, 5, 23, 23)];
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.image = [UIImage imageNamed:@"check"];
    UITapGestureRecognizer * selectTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectLackDish:)];
    [imgView addGestureRecognizer:selectTapGesture];
    imgView.tag = indexPath.row;
    imgView.hidden = YES;
    [orderView addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    
    
    UIImageView * imgSelectedView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-30)*5/6, 5, 23, 23)];
    imgSelectedView.backgroundColor = [UIColor whiteColor];
    imgSelectedView.image = [UIImage imageNamed:@"selected"];
    UITapGestureRecognizer * cancelSelectGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelSelectLackDish:)];
    [imgSelectedView addGestureRecognizer:cancelSelectGesture];
    imgSelectedView.hidden = YES;
    imgSelectedView.tag = indexPath.row;
    [orderView addSubview:imgSelectedView];
    imgSelectedView.userInteractionEnabled = YES;
    
    if([selectedDishLack isEqualToString:@"0"]){
        dishNumLabel.hidden = NO;
        imgView.hidden = YES;
    }
    else{
//        NSLog(@"缺菜模式");
        dishNumLabel.hidden = YES;
        imgView.hidden = NO;
        if([_unconfirmOrderDetailDS[indexPath.row].selectedLackDish isEqualToString:@"1"]){
//            NSLog(@"黑色");
            imgSelectedView.hidden = NO;
        }
        else{
//            NSLog(@"白色");
            imgSelectedView.hidden = YES;
        }
    }
    
    UILabel * dishOptions = [[UILabel alloc]initWithFrame:CGRectMake(0,30, SCREENWIDTH-30, 20*needLine)];
    dishOptions.font = [UIFont systemFontOfSize:12];
    dishOptions.textColor = [UIColor darkGrayColor];
    dishOptions.text = remark;
    dishOptions.numberOfLines =0;
    [orderView addSubview:dishOptions];
    
    return cell;
}
#pragma mark--行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat cellH = 40 + tempH;
    return cellH;
}
//缺菜模式
-(void)lackDish:(id)sender{
    
    
    if(_lackBtn.tag == 1001){
        NSLog(@"缺菜");
        selectedDishLack = @"1";
        [_lackBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_orderDetailTable reloadData];
        _lackBtn.tag = 1002;
    }
    else{
        for(NSInteger i = 0;i < _unconfirmOrderDetailDS.count;i++){
            unconfirmOrderInfo * orderInfo = _unconfirmOrderDetailDS[i];
            if([orderInfo.selectedLackDish isEqualToString:@"1"]){
                NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:orderInfo.dishId,@"dish_id",orderInfo.dishName,@"dish_name",nil];
                [self.lackDishArray addObject:dic];
            }
        }
        [_submitDelegate RefuseTheOrderAndDish:self.lackDishArray];
    }
}
//点击选中事件
-(void)selectLackDish:(id)sender{
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    self.unconfirmOrderDetailDS[tap.view.tag].selectedLackDish = @"1";
    [_orderDetailTable reloadData];
}
//取消选中事件
-(void)cancelSelectLackDish:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    self.unconfirmOrderDetailDS[tap.view.tag].selectedLackDish = @"0";
    [_orderDetailTable reloadData];
//    NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:tap.view.tag];
//    [_orderDetailTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
//通过所有订单函数
-(void)passOrder{
    [_submitDelegate PassTheOrder];
}
//拒绝所有订单
-(void)refuseOrder{
    [_submitDelegate RefuseTheOrder];
}
@end
