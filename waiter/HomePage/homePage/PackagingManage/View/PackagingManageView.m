//
//  PackagingManageView.m
//  waiter
//
//  Created by ltl on 2019/7/12.
//  Copyright © 2019 renxin. All rights reserved.
//  打包管理主视图

#import "PackagingManageView.h"
#import "NotCompletePackageTableViewCell.h"
#import "CompletePackageTableViewCell.h"
#import "UITableView+EmptyData.h"
#import "MJRefresh.h"
#import "Header.h"
#import "MyUtils.h"

@implementation PackagingManageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
     
        self.packageArray = [[NSMutableArray<packageManage *> alloc] init];
        self.hasPackageArray = [[NSMutableArray<packageManage *> alloc] init];
        
        //1.创建未完成按钮
        UIButton *notCompleteBtn = [[UIButton alloc]init];
        notCompleteBtn.backgroundColor = [UIColor whiteColor];
        notCompleteBtn.layer.borderWidth = 0;
        [notCompleteBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_notComplete"] forState:UIControlStateNormal];
        [notCompleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [notCompleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [notCompleteBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [notCompleteBtn setSelected:YES];
        [notCompleteBtn setTag:101];
        [notCompleteBtn addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        _notCompleteBtn = notCompleteBtn;
        [self addSubview:notCompleteBtn];
        
        //2.创建已完成按钮
        UIButton *completeBtn = [[UIButton alloc]init];
        completeBtn.backgroundColor = [UIColor whiteColor];
        completeBtn.layer.borderWidth = 0;
        [completeBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_complete"] forState:UIControlStateNormal];
        [completeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [completeBtn setSelected:NO];
        [completeBtn setTag:102];
        [completeBtn addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        _completeBtn = completeBtn;
        [self addSubview:completeBtn];
        
        //3.滑动下划线
        UILabel * underLine = [[UILabel alloc]init];
        underLine.backgroundColor = [UIColor redColor];
        _underLine = underLine;
        [self addSubview:underLine];
        
        //4.创建scrolView
        UIScrollView * manageScroll = [[UIScrollView alloc]init];
        manageScroll.delegate = self;
        manageScroll.pagingEnabled = YES;
        manageScroll.bounces = NO;
        manageScroll.showsVerticalScrollIndicator = NO;
        manageScroll.showsHorizontalScrollIndicator = NO;
        _manageScroll = manageScroll;
        [self addSubview:manageScroll];
        
        //5.未完成tableview
        MJRefreshNormalHeader * header = [self createTableHeader:@"left"];
        MJRefreshAutoNormalFooter * footer = [self createTableFooter:@"left"];
        UITableView * notCompleteTable = [[UITableView alloc]init];
        [notCompleteTable registerClass:[NotCompletePackageTableViewCell class] forCellReuseIdentifier:@"notCompleteCell"];
        notCompleteTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        notCompleteTable.separatorColor = [UIColor clearColor];
        [notCompleteTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        notCompleteTable.delegate = self;
        notCompleteTable.dataSource = self;
        notCompleteTable.tag = 1001;
        notCompleteTable.mj_header = header;
//        notCompleteTable.mj_footer = footer;
        _notCompleteTable = notCompleteTable;
        [manageScroll addSubview:notCompleteTable];
        
        //6.已完成tableview
        MJRefreshNormalHeader * header1 = [self createTableHeader:@"right"];
        MJRefreshAutoNormalFooter * footer1 = [self createTableFooter:@"right"];
        UITableView * completeTable = [[UITableView alloc]init];
        [completeTable registerClass:[CompletePackageTableViewCell class] forCellReuseIdentifier:@"completeCell"];
        completeTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        completeTable.separatorColor = [UIColor clearColor];
        [completeTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        completeTable.delegate = self;
        completeTable.dataSource = self;
        completeTable.tag = 1002;
        completeTable.mj_header = header1;
//        completeTable.mj_footer = footer1;
        _completeTable = completeTable;
        [manageScroll addSubview:completeTable];

    }
    return  self;
}

//重写layoutSubviews方法，父控件改变尺寸时调用该方法，父控件有了尺寸再设置子控件的尺寸
-(void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat buttonHeight = 50;
    _notCompleteBtn.frame = CGRectMake(0, 0, selfWidth/2, buttonHeight);
    _completeBtn.frame = CGRectMake(selfWidth/2, 0, selfWidth/2, buttonHeight);
    
    CGFloat xOffset = selfWidth/8;
    _underLine.frame = CGRectMake(xOffset, buttonHeight, selfWidth/4, 2);
    
    CGFloat yOffset = _underLine.frame.size.height + _underLine.frame.origin.y + 4;
    CGFloat scrollHeight = selfHeight - yOffset;
    
    _manageScroll.frame = CGRectMake(0, yOffset, selfWidth, scrollHeight);
    _manageScroll.contentSize = CGSizeMake(selfWidth * 2, scrollHeight);
    
    _notCompleteTable.frame = CGRectMake(0, 0, selfWidth, scrollHeight);
    _completeTable.frame = CGRectMake(selfWidth, 0, selfWidth, scrollHeight);
    
}

#pragma mark - 刷新初始化

- (MJRefreshNormalHeader *)createTableHeader:(NSString *)type{
    MJRefreshNormalHeader * header;
    //        NSString * filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"loadGifWithoutBackground" ofType:@"gif"];
    //        NSData * imageData = [NSData dataWithContentsOfFile:filePath];
    //        _gifImageView.image = [UIImage sd_animatedGIFWithData:imageData];

    if( [type isEqualToString:@"left"] ){
        header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(leftLoadNewData)];
    }
    if( [type isEqualToString:@"right"] ){
        header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(rightLoadNewData)];
    }
    //        [header setImages:[UIImage imageNamed:@"shopCarAdd.png"] forState:MJRefreshStateIdle];
    //        [header setImages:[UIImage imageNamed:@"shopCarAdd.png"] forState:MJRefreshStatePulling];
    //        [header setImages:[UIImage imageNamed:@"shopCarAdd.png"] forState:MJRefreshStateRefreshing];
    // 设置文字
    [header setTitle:@"" forState:MJRefreshStateIdle];//下拉刷新
    [header setTitle:@"" forState:MJRefreshStatePulling];//松手释放
    [header setTitle:@"" forState:MJRefreshStateRefreshing];//加载中 ...
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    return header;
}

- (MJRefreshAutoNormalFooter *)createTableFooter:(NSString *)type{
    MJRefreshAutoNormalFooter * footer;
    if( [type isEqualToString:@"left"] ){
        footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(leftLoadMoreData)];
    }
    if( [type isEqualToString:@"right"] ){
        footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(rightLoadMoreData)];
    }
    [footer setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"加载完成" forState:MJRefreshStateNoMoreData];
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

- (void)endFreshHeader:(UITableView *)table{
    [table.mj_header endRefreshing];
}

- (void)endFreshFooter:(UITableView *)table{
    [table.mj_footer endRefreshing];
}

#pragma mark - 切换事件

- (void)changeVC:(UIButton *)button{
    [_manageScroll setContentOffset:CGPointMake(SCREENWIDTH * (button.tag - 101), 0) animated:YES];
    [button setSelected:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curBtn = (_manageScroll.contentOffset.x + SCREENWIDTH / 2) / SCREENWIDTH + 1;
    for(NSInteger i = 1; i <= 2; ++i){
        UIButton *btn = (UIButton *)[[scrollView superview]viewWithTag: i + 100];
        if(btn.tag - 100 == curBtn){
            [btn setSelected:YES];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
                [self.underLine setFrame:CGRectMake(btn.frame.origin.x + SCREENWIDTH/8, 50, SCREENWIDTH/4, 2)];
            }];
        }else{
            [btn setSelected:NO];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }
    }
}

#pragma mark - not complete package tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.notCompleteTable tableViewDisplayWitMsg:[NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"NoData"]] ifNecessaryForRowCount:self.packageArray.count];
    [self.completeTable tableViewDisplayWitMsg:[NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"NoData"]] ifNecessaryForRowCount:self.hasPackageArray.count];
    if( tableView.tag == 1001){
        NSLog(@"未打包数组个数：%lu",(unsigned long)[self.packageArray count]);
        return [self.packageArray count];
    }
    NSLog(@"历史数组个数：%lu",(unsigned long)[self.hasPackageArray count]);
    return [self.hasPackageArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if( tableView.tag == 1001 ){
        NotCompletePackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notCompleteCell" forIndexPath:indexPath];
        if(cell == nil){
            cell = [[NotCompletePackageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"notCompleteCell"];
        }
        packageManage *info = [self.packageArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (info) {
            cell.orderId.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderId"], info.order_num];
            cell.orderTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderTime"], info.make_order_time];
            cell.pickUpTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_pickUpTime"], info.reserve_time];
            cell.guest.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_guest"], info.customer];
            if( [info.status isEqualToString:@"1"] ){
                //已打印
                cell.packageState.text = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_hasPrint"];
                cell.packageState.textColor = [UIColor colorWithRed:76/255.0 green:217.0/255.0 blue:100/255.0 alpha:1.0];
            }else{
                //已支付
                cell.packageState.text = [MyUtils GETCurrentLangeStrWithKey:@"PackageManage_hasPaid"];
                cell.packageState.textColor = [UIColor colorWithRed:255/255.0 green:69/255.0 blue:0.0/255.0 alpha:1.0];
            }
        }
        return cell;
    }else{
        CompletePackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"completeCell" forIndexPath:indexPath];
        if(cell == nil){
            cell = [[CompletePackageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"completeCell"];
        }
        packageManage *info = [self.hasPackageArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (info) {
            cell.orderId.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderId"], info.order_num];
            cell.orderTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_orderTime"], info.make_order_time];
            cell.pickUpTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_pickUpTime"], info.reserve_time];
            cell.actuallyPickUpTime.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_actuallPickUpTime"], info.real_time];
            cell.guest.text = [NSString stringWithFormat:@"%@：%@",[MyUtils GETCurrentLangeStrWithKey:@"PackageManage_guest"], info.customer];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取点击到的某行的打包单号，交给controller
    if( tableView.tag == 1001 ){
        NSString * packageId = [self.packageArray objectAtIndex:indexPath.row].package_id;
        NSLog(@"未打包id%@", packageId);
        [self orderType:@"0" packageId:packageId];
    }
    else{
        NSString * packageId = [self.hasPackageArray objectAtIndex:indexPath.row].package_id;
        NSLog(@"历史id%@", packageId);
        [self orderType:@"1" packageId:packageId];
    }
}

#pragma mark - 自定义代理

- (void)orderType:(NSString *)orderType packageId:(NSString *)packageNum{
    //如果代理存在，并且controller中实现代理方法，才进行代理传值
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderType: packageId:)]) {
        //协议方法
        [self.delegate orderType:orderType packageId:packageNum];
    }
}

@end
