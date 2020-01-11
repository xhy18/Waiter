//
//  BookingView.m
//  waiter
//
//  Created by ltl on 2019/10/24.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "BookingView.h"
#import "BookingTableViewCell.h"
#import "UITableView+EmptyData.h"
#import "MJRefresh.h"
#import "Header.h"
#import "MyUtils.h"

@implementation BookingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.notCompleteArray = [[NSMutableArray<BookingOrderObj *> alloc] init];
        self.hasCompleteArray = [[NSMutableArray<BookingOrderObj *> alloc] init];
        
        //1.创建未完成按钮
        UIButton *notCompleteBtn = [[UIButton alloc] init];
        notCompleteBtn.backgroundColor = [UIColor whiteColor];
        notCompleteBtn.layer.borderWidth = 0;
        [notCompleteBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"Booking_notComplete"] forState:UIControlStateNormal];
        [notCompleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [notCompleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [notCompleteBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [notCompleteBtn setSelected:YES];
        [notCompleteBtn setTag:101];
        [notCompleteBtn addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        _notCompleteBtn = notCompleteBtn;
        [self addSubview:notCompleteBtn];
        
        //2.创建已完成按钮
        UIButton *completeBtn = [[UIButton alloc] init];
        completeBtn.backgroundColor = [UIColor whiteColor];
        completeBtn.layer.borderWidth = 0;
        [completeBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"Booking_complete"] forState:UIControlStateNormal];
        [completeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [completeBtn setSelected:NO];
        [completeBtn setTag:102];
        [completeBtn addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        _completeBtn = completeBtn;
        [self addSubview:completeBtn];
        
        //3.创建管理按钮
        UIButton *manageBtn = [[UIButton alloc] init];
        manageBtn.backgroundColor = [UIColor whiteColor];
        manageBtn.layer.borderWidth = 0;
        [manageBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"Booking_manage"] forState:UIControlStateNormal];
        [manageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [manageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [manageBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [manageBtn setSelected:NO];
        [manageBtn setTag:103];
        [manageBtn addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        _manageBtn = manageBtn;
        [self addSubview:manageBtn];
        
        //4.滑动下划线
        UILabel * underLine = [[UILabel alloc] init];
        underLine.backgroundColor = [UIColor redColor];
        _underLine = underLine;
        [self addSubview:underLine];
        
        //5.创建scrolView
        UIScrollView * manageScroll = [[UIScrollView alloc] init];
        manageScroll.delegate = self;
        manageScroll.pagingEnabled = YES;
        manageScroll.bounces = NO;
        manageScroll.showsVerticalScrollIndicator = NO;
        manageScroll.showsHorizontalScrollIndicator = NO;
        _manageScroll = manageScroll;
        [self addSubview:manageScroll];
        
        //6.未完成tableview
        MJRefreshNormalHeader * header = [self createTableHeader:@"left"];
        MJRefreshBackNormalFooter * footer = [self createTableFooter:@"left"];
        UITableView * notCompleteTable = [[UITableView alloc] init];
        [notCompleteTable registerClass:[BookingTableViewCell class] forCellReuseIdentifier:@"notCompleteCell"];
        [notCompleteTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        notCompleteTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        notCompleteTable.separatorColor = [UIColor clearColor];
        notCompleteTable.delegate = self;
        notCompleteTable.dataSource = self;
        notCompleteTable.tag = 1001;
        notCompleteTable.mj_header = header;
        notCompleteTable.mj_footer = footer;
        _notCompleteTable = notCompleteTable;
        [manageScroll addSubview:notCompleteTable];
        
        //7.已完成tableview
        MJRefreshNormalHeader * header1 = [self createTableHeader:@"right"];
        MJRefreshBackNormalFooter * footer1 = [self createTableFooter:@"right"];
        UITableView * completeTable = [[UITableView alloc] init];
        [completeTable registerClass:[BookingTableViewCell class] forCellReuseIdentifier:@"completeCell"];
        [completeTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        completeTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        completeTable.separatorColor = [UIColor clearColor];
        completeTable.delegate = self;
        completeTable.dataSource = self;
        completeTable.tag = 1002;
        completeTable.mj_header = header1;
        completeTable.mj_footer = footer1;
        _completeTable = completeTable;
        [manageScroll addSubview:completeTable];
        
        //8.管理view
        UIView * manageView = [[UIView alloc] init];
//        manageView.backgroundColor = [UIColor orangeColor];
        _manageView = manageView;
        [manageScroll addSubview:manageView];
        
        //9.管理背景
        UIView * backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = GLOBALGRAYCOLOR;
        backgroundView.layer.cornerRadius = 5;
        _backgroundView = backgroundView;
        [manageView addSubview:backgroundView];
        
        //10.提示语
        UILabel * tiplabel = [[UILabel alloc] init];
        tiplabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_whetherToOpenBookingModel"]];
        tiplabel.numberOfLines = 0;
        tiplabel.font = [UIFont systemFontOfSize:15];
        _tiplabel = tiplabel;
        [backgroundView addSubview:tiplabel];
        
        //11.预约状态值
        UILabel * bookingStatuslabel = [[UILabel alloc] init];
//        bookingStatuslabel.backgroundColor = [UIColor redColor];
        bookingStatuslabel.font = [UIFont systemFontOfSize:15];
        bookingStatuslabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_close"]];
        bookingStatuslabel.textAlignment = NSTextAlignmentCenter;
        bookingStatuslabel.numberOfLines = 0;
        _bookingStatuslabel = bookingStatuslabel;
        [backgroundView addSubview:bookingStatuslabel];
        
        //12.预约开关
        UISwitch * isOpenBooking = [[UISwitch alloc] init];
        isOpenBooking.on = NO;
//        isOpenBooking.backgroundColor = [UIColor orangeColor];
        isOpenBooking.transform = CGAffineTransformMakeScale( 0.95, 0.95);//缩放
//        [isOpenBooking addTarget:self action:@selector(changeBookingStatus:) forControlEvents:UIControlEventValueChanged];
        _isOpenBooking = isOpenBooking;
        [backgroundView addSubview:isOpenBooking];
    }
    return  self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat buttonHeight = 50;
    _notCompleteBtn.frame = CGRectMake(0, 0, selfWidth/3, buttonHeight);
    _completeBtn.frame = CGRectMake(selfWidth/3, 0, selfWidth/3, buttonHeight);
    _manageBtn.frame = CGRectMake(selfWidth/3 * 2, 0, selfWidth/3, buttonHeight);
    
    _underLine.frame = CGRectMake(15, buttonHeight, selfWidth/3 - 15 * 2, 2);
    
    CGFloat yOffset = _underLine.frame.size.height + _underLine.frame.origin.y + 4;
    CGFloat scrollHeight = selfHeight - yOffset;
    
    _manageScroll.frame = CGRectMake(0, yOffset, selfWidth, scrollHeight);
    _manageScroll.contentSize = CGSizeMake(selfWidth * 3, scrollHeight);
    
    _notCompleteTable.frame = CGRectMake(0, 0, selfWidth, scrollHeight);
    _completeTable.frame = CGRectMake(selfWidth*1, 0, selfWidth, scrollHeight);
    _manageView.frame = CGRectMake(selfWidth*2, 0, selfWidth, scrollHeight);
    
    _backgroundView.frame = CGRectMake(20, 5, selfWidth - 20 * 2, 50);
    _tiplabel.frame = CGRectMake(10, 0, _backgroundView.frame.size.width*0.7-10, _backgroundView.frame.size.height);
    _isOpenBooking.frame = CGRectMake(_backgroundView.frame.size.width*0.7, 10, 60, _backgroundView.frame.size.height);
    _bookingStatuslabel.frame = CGRectMake( _isOpenBooking.frame.origin.x + _isOpenBooking.frame.size.width, 0, _backgroundView.frame.size.width - _isOpenBooking.frame.origin.x - _isOpenBooking.frame.size.width, _backgroundView.frame.size.height);
    
}

#pragma mark - 切换事件

- (void)changeVC:(UIButton *)button{
    [_manageScroll setContentOffset:CGPointMake(SCREENWIDTH * (button.tag - 101), 0) animated:YES];
    [button setSelected:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curBtn = (_manageScroll.contentOffset.x + SCREENWIDTH / 2) / SCREENWIDTH + 1;
    for(NSInteger i = 1; i <= 3; ++i){
        UIButton *btn = (UIButton *)[[scrollView superview]viewWithTag: i + 100];
        if(btn.tag - 100 == curBtn){
            [btn setSelected:YES];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
                [self.underLine setFrame:CGRectMake(btn.frame.origin.x + 15, 50, SCREENWIDTH/3 - 15 * 2, 2)];
            }];
        }else{
            [btn setSelected:NO];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }
    }
}

#pragma mark - 刷新初始化

- (MJRefreshNormalHeader *)createTableHeader:(NSString *)type{
    MJRefreshNormalHeader * header;
    if( [type isEqualToString:@"left"] ){
        header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(leftLoadNewData)];
    }
    if( [type isEqualToString:@"right"] ){
        header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(rightLoadNewData)];
    }
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    return header;
}

- (MJRefreshBackNormalFooter *)createTableFooter:(NSString *)type{
    MJRefreshBackNormalFooter * footer;
    if( [type isEqualToString:@"left"] ){
        footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(leftLoadMoreData)];
    }
    if( [type isEqualToString:@"right"] ){
        footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(rightLoadMoreData)];
    }
    [footer setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MQTT_loadingMore"] forState:MJRefreshStateIdle];
    [footer setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MQTT_loading"] forState:MJRefreshStateRefreshing];
    [footer setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MQTT_release"] forState:MJRefreshStatePulling];
    [footer setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MQTT_loadingSuccess"] forState:MJRefreshStateNoMoreData];
    return footer;
}

#pragma mark - 刷新事件

- (void)leftLoadNewData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(newData:)]) {
        [self.delegate newData:-1];
    }
}

- (void)leftLoadMoreData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreData:)]) {
        [self.delegate moreData:-1];
    }
}

- (void)rightLoadNewData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(newData:)]) {
        [self.delegate newData:1];
    }
}

- (void)rightLoadMoreData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreData:)]) {
        [self.delegate moreData:1];
    }
}

#pragma mark - booking tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.notCompleteTable tableViewDisplayWitMsg:[NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"NoData"]] ifNecessaryForRowCount:self.notCompleteArray.count];
    [self.completeTable tableViewDisplayWitMsg:[NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"NoData"]] ifNecessaryForRowCount:self.hasCompleteArray.count];
    
    if( tableView.tag == 1001 ){
        return [self.notCompleteArray count];
    }if( tableView.tag == 1002 ){
        return [self.hasCompleteArray count];
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if( tableView.tag == 1001 ){
        static NSString * identifier = @"notCompleteCell";
        BookingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if(cell == nil){
            cell = [[BookingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        }
        BookingOrderObj *info = [self.notCompleteArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (info) {
            cell.orderId.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_orderId"], info.order_num];
            
            if( [info.customer_num integerValue] == -1 ){
                cell.numberOfPeople.text = [NSString stringWithFormat:@"%@：%@%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_numberOfPeopleEating"], @"7+",[MyUtils GETCurrentLangeStrWithKey:@"Booking_people"]];
            }else{
                cell.numberOfPeople.text = [NSString stringWithFormat:@"%@：%@%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_numberOfPeopleEating"], info.customer_num,[MyUtils GETCurrentLangeStrWithKey:@"Booking_people"]];
            }
            
            cell.bookingTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_mealTime"], info.reserve_get_time];
            
            if( info.status == 0 ){
                //已支付
                cell.bookingState.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_hasPay"]];
                cell.bookingState.textColor = [UIColor colorWithRed:255/255.0 green:153.0/255.0 blue:0/255.0 alpha:1.0];
            }else if( info.status == 1 ){
                //已打印
                cell.bookingState.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_hasPrint"]];
                cell.bookingState.textColor = [UIColor colorWithRed:102/255.0 green:204.0/255.0 blue:0/255.0 alpha:1.0];
            }
        }
        return cell;
    }else{
        BookingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"completeCell" forIndexPath:indexPath];
        if(cell == nil){
            cell = [[BookingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"completeCell"];
        }
        BookingOrderObj *info = [self.hasCompleteArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (info) {
            cell.orderId.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_orderId"], info.order_num];
            
            if( [info.customer_num integerValue] == -1 ){
                cell.numberOfPeople.text = [NSString stringWithFormat:@"%@：%@%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_numberOfPeopleEating"], @"7+",[MyUtils GETCurrentLangeStrWithKey:@"Booking_people"]];
            }else{
                cell.numberOfPeople.text = [NSString stringWithFormat:@"%@：%@%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_numberOfPeopleEating"], info.customer_num,[MyUtils GETCurrentLangeStrWithKey:@"Booking_people"]];
            }
            
            cell.bookingTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_reserverTime"], info.reserve_real_get_time];
            
            if( info.status == 7 ){
                //已就餐
                cell.bookingState.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_hasEaten"]];
            }else if( info.status == 8 ){
                //已取消
                cell.bookingState.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"Booking_hasCancel"]];
            }

            cell.bookingState.textColor = [UIColor colorWithRed:102.0/255.0 green:156.0/255.0 blue:240.0/255.0 alpha:1.0];
    
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if( tableView.tag == 1001 ){
        NSString * bookingId = [self.notCompleteArray objectAtIndex:indexPath.row].booking_id;
        NSLog(@"未完成id%@", bookingId);
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderType:bookingOrderId:)]) {
            [self.delegate orderType:@"0" bookingOrderId:bookingId];
        }
    }
    else{
        NSString * bookingId = [self.hasCompleteArray objectAtIndex:indexPath.row].booking_id;
        NSLog(@"已完成id%@", bookingId);
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderType:bookingOrderId:)]) {
            [self.delegate orderType:@"1" bookingOrderId:bookingId];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

@end
