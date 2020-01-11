//
//  BookingDetailView.m
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BookingDetailView.h"
#import "BookingDishTableViewCell.h"
#import "Header.h"
#import "MyUtils.h"
#define FONTSIZE 15

@implementation BookingDetailView

- (instancetype)initWithFrame:(CGRect)frame orderType:(NSString *)type{
    self = [super initWithFrame:frame];
    if(self){
        
        self.backgroundColor = [UIColor whiteColor];
        self.dishDS = [[NSMutableArray<DishInfoObj *> alloc] init];
        
        //1.订单详情灰色背景图
        UIView * grayBackground = [[UIView alloc]init];
        grayBackground.backgroundColor = GLOBALGRAYCOLOR;
        grayBackground.layer.cornerRadius = 3;
        _grayBackground = grayBackground;
        [self addSubview:grayBackground];
        
        //2.订单号
        UILabel * orderNum = [[UILabel alloc]init];
        orderNum.text = [NSString stringWithFormat:@"%@：---",[MyUtils GETCurrentLangeStrWithKey:@"Booking_orderId"]];
        orderNum.font = [UIFont systemFontOfSize:FONTSIZE];
        _orderNum = orderNum;
        [grayBackground addSubview:orderNum];
        
        //3.姓名
        UILabel * name = [[UILabel alloc]init];
        name.text = [NSString stringWithFormat:@"%@：---",[MyUtils GETCurrentLangeStrWithKey:@"Booking_name"]];
        name.font = [UIFont systemFontOfSize:FONTSIZE];
        _name = name;
        [grayBackground addSubview:name];
        
        //4.电话
        UILabel * telephone = [[UILabel alloc]init];
        telephone.text = [NSString stringWithFormat:@"%@：---",[MyUtils GETCurrentLangeStrWithKey:@"Booking_phone"]];
        telephone.font = [UIFont systemFontOfSize:FONTSIZE];
        _telephone = telephone;
        [grayBackground addSubview:telephone];
        
        //5.下单时间
        UILabel * orderTime = [[UILabel alloc]init];
        orderTime.text = [NSString stringWithFormat:@"%@：--- ---",[MyUtils GETCurrentLangeStrWithKey:@"Booking_orderTime"]];
        orderTime.font = [UIFont systemFontOfSize:FONTSIZE];
        _orderTime = orderTime;
        [grayBackground addSubview:orderTime];
        
        //6.就餐时间
        UILabel * bookingTime = [[UILabel alloc]init];
        if( [type isEqualToString:@"0"] ){
            bookingTime.text = [NSString stringWithFormat:@"%@：--- ---",[MyUtils GETCurrentLangeStrWithKey:@"Booking_mealTime"]];
        }else{
            bookingTime.text = [NSString stringWithFormat:@"%@：--- ---",[MyUtils GETCurrentLangeStrWithKey:@"Booking_reserverTime"]];
        }
        bookingTime.font = [UIFont systemFontOfSize:FONTSIZE];
        _bookingTime = bookingTime;
        [grayBackground addSubview:bookingTime];
        
        //7.菜品数量
        UILabel * dishesNum = [[UILabel alloc]init];
        dishesNum.text = [NSString stringWithFormat:@"%@：0",[MyUtils GETCurrentLangeStrWithKey:@"Booking_Produits"]];
        dishesNum.font = [UIFont systemFontOfSize:FONTSIZE];
        dishesNum.textColor = [UIColor redColor];
        _dishesNum = dishesNum;
        [self addSubview:dishesNum];
        
        //8.菜品table
        UITableView * dishesTable = [[UITableView alloc]init];
        dishesTable.backgroundColor = GLOBALGRAYCOLOR;
        dishesTable.backgroundColor = [UIColor whiteColor];
        [dishesTable registerClass:[BookingDishTableViewCell class] forCellReuseIdentifier:@"bookingDishCell"];
        dishesTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        dishesTable.separatorColor = [UIColor clearColor];
        [dishesTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        dishesTable.bounces = NO;
        dishesTable.delegate = self;
        dishesTable.dataSource = self;
        _dishesTable = dishesTable;
        [self addSubview:dishesTable];
        
        //9.底端按钮
        UIButton * bottomBtn = [[UIButton alloc]init];
        bottomBtn.backgroundColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
        bottomBtn.layer.borderWidth = 0;        
        [bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [bottomBtn setTag:101];
        bottomBtn.hidden = YES;
        _bottomBtn = bottomBtn;
        [self addSubview:bottomBtn];
        
    }
    return  self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat leftBlank = 15;
    CGFloat infoRowHeight = 30;
    
    _grayBackground.frame = CGRectMake(leftBlank, 0, selfWidth-2*leftBlank, infoRowHeight*5);
    
    _orderNum.frame = CGRectMake(leftBlank, infoRowHeight*0, selfWidth-leftBlank, infoRowHeight);
    _name.frame = CGRectMake(leftBlank, infoRowHeight*1, selfWidth-leftBlank, infoRowHeight);
    _telephone.frame = CGRectMake(leftBlank, infoRowHeight*2, selfWidth-leftBlank, infoRowHeight);
    _orderTime.frame = CGRectMake(leftBlank, infoRowHeight*3, selfWidth-leftBlank, infoRowHeight);
    _bookingTime.frame = CGRectMake(leftBlank, infoRowHeight*4, selfWidth-leftBlank, infoRowHeight);
    
    CGFloat dishOffset = _grayBackground.frame.size.height + _grayBackground.frame.origin.y;
    _dishesNum.frame = CGRectMake(leftBlank*2, dishOffset, selfWidth-3*leftBlank, 50);
    
    //先计算button的位置，再画table
    CGFloat btnHeight = 40;
    _bottomBtn.frame = CGRectMake(100, selfHeight-leftBlank*2-btnHeight, selfWidth-2*100, btnHeight);
    _bottomBtn.layer.cornerRadius = btnHeight/2;

    CGFloat tableOffset = _dishesNum.frame.size.height + _dishesNum.frame.origin.y;
    CGFloat tableHeight = selfHeight - tableOffset - leftBlank*2 - btnHeight - 10;
    _dishesTable.frame = CGRectMake(leftBlank, tableOffset, selfWidth-2*leftBlank, tableHeight);
    NSLog(@"hei:%f",tableHeight);
}

#pragma mark - 布局

- (void)commonUI:(BookingOrderDetailObj *)detail{
    _orderNum.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_orderId"], detail.order_num];
    _name.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_name"],detail.customer];
    _telephone.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_phone"],detail.phone];
    _orderTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_orderTime"],detail.make_order_time];
    _dishesNum.text = [NSString stringWithFormat:@"%@：%lu",[MyUtils GETCurrentLangeStrWithKey:@"Booking_Produits"],(unsigned long)detail.dish_list.count];
}

- (void)setNotCompletedOrderUI:(BookingOrderDetailObj *)detail{
    [self commonUI:detail];
    _bookingTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_mealTime"],detail.reserve_get_time];
    
    if([detail.status isEqualToString:@"0"]){
        _bottomBtn.hidden = NO;
    }else{
        _bottomBtn.hidden = YES;
        CGFloat leftBlank = 15;
        CGFloat tableOffset = _dishesNum.frame.size.height + _dishesNum.frame.origin.y;
        CGFloat tableHeight = self.frame.size.height - tableOffset - leftBlank;
        _dishesTable.frame = CGRectMake(leftBlank, tableOffset, self.frame.size.width-2*leftBlank, tableHeight);
    }
}

- (void)setHasCompletedOrderUI:(BookingOrderDetailObj *)detail{
    [self commonUI:detail];
    _bookingTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_reserverTime"],detail.reserve_real_get_time];
    
    //已完成，隐藏按钮，重画table位置
    _bottomBtn.hidden = YES;
    CGFloat leftBlank = 15;
    CGFloat tableOffset = _dishesNum.frame.size.height + _dishesNum.frame.origin.y;
    CGFloat tableHeight = self.frame.size.height - tableOffset - leftBlank;
    _dishesTable.frame = CGRectMake(leftBlank, tableOffset, self.frame.size.width-2*leftBlank, tableHeight);
    NSLog(@"***hei:%f",tableHeight);
}

- (void)setScanBookingOrderUI:(BookingOrderDetailObj *)detail{
    [self commonUI:detail];
    _bookingTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_mealTime"],detail.reserve_get_time];
    _bottomBtn.hidden = NO;
}

#pragma mark -  tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dishDS count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DishInfoObj * dish = self.dishDS[indexPath.row];
    //菜品名高
    CGFloat nameHeight = [(NSString *)dish.dish_name boundingRectWithSize:CGSizeMake(SCREENWIDTH-15-30-60-15*2, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    if(nameHeight<30){
        nameHeight = 30;
    }else if(nameHeight>30 && nameHeight<=50){
        nameHeight = 50;
    }
    //备注高
    CGFloat remarkHeight = [(NSString *)dish.dish_options boundingRectWithSize:CGSizeMake(SCREENWIDTH-60-15, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    if(remarkHeight<30){
        remarkHeight = 30;
    }else if(remarkHeight>30 && remarkHeight<=60){
        remarkHeight = 60;
    }
    
    if (dish.dish_fold) {
        //展开
        NSLog(@"00000:%f+%f",nameHeight , remarkHeight);
        return nameHeight + remarkHeight;
    }else{
        //折叠
        NSLog(@"111111:%f",  remarkHeight);
        return 30 + remarkHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"bookingDishCell";
    BookingDishTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if(cell == nil){
        cell = [[BookingDishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = GLOBALGRAYCOLOR;
    
    DishInfoObj *info = [self.dishDS objectAtIndex:indexPath.row];
    if (info) {
        cell.dish = info;
        cell.dishName.text = [NSString stringWithFormat:@"%ld. %@",(indexPath.row+1), info.dish_name];
        cell.dishNum.text = [NSString stringWithFormat:@"%@%@",@"×",info.dish_number];
//        cell.remarkLabel.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_remarks"],info.dish_options];
        cell.foldBtn.tag = indexPath.section * 1000 + indexPath.row;
        [cell.foldBtn addTarget:self action:@selector(btnClickReloadRow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)btnClickReloadRow:(UIButton *)btn{
    NSInteger section = btn.tag / 1000;
    NSInteger row = btn.tag % 1000;
    NSLog(@"区：%ld，行：%ld",(long)section,(long)row);
    DishInfoObj *info = [self.dishDS objectAtIndex:row];
    BOOL state = info.dish_fold;
    if(state){
        info.dish_fold = NO;
    }else{
        info.dish_fold = YES;
    }
    //一个section刷新
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//    [tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    //一个cell刷新
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.dishesTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

@end
