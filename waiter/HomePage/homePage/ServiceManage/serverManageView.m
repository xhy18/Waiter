//
//  serverManageView.m
//  waiter
//
//  Created by renxin on 2019/7/16.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "serverManageView.h"
#import "MyUtils.h"
#import "Header.h"
#import "ServerTableViewCell.h"
@implementation serverManageView

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
        self.waiterDS = @[].mutableCopy;
        self.waiterDS = dataArray.mutableCopy;
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)initUI{
//    NSLog(@"WAITER VIEW");
    self.addButton = [[UIButton alloc]init];
    _addButton.backgroundColor = GRAYCOLOR;
    _addButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _addButton.layer.cornerRadius = 5.0f;
    _addButton.layer.borderWidth = 1.0f;
    _addButton.layer.borderColor =[[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];
    [_addButton setTitle:[MyUtils GETCurrentLangeStrWithKey:@"serverManage_add"] forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addWaiter) forControlEvents:UIControlEventTouchUpInside];
    _addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_addButton];
    
    
    self.table_refreshView = [[UIView alloc]init];
    [self addSubview:_table_refreshView];
    self.waiterTableView = [[UITableView alloc]init];
    _waiterTableView.delegate = self;
    _waiterTableView.dataSource = self;
    _waiterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_table_refreshView addSubview:_waiterTableView];
}
-(void)layoutSubviews{

    self.addButton.frame = CGRectMake(20, 10, SCREENWIDTH-40, 80);
    CGFloat offsetY = self.addButton.frame.origin.y + self.addButton.frame.size.height;
   
    self.table_refreshView.frame = CGRectMake(0,offsetY, SCREENWIDTH, SCREENHEIGHT-offsetY+10);
    _waiterTableView.frame = CGRectMake(0,0, SCREENWIDTH,SCREENHEIGHT-offsetY+10);
}

#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.waiterDS.count;
}

#pragma mark 每一行cell的m内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    NSLog(@"CELL");
    static NSString * identifier = @"serverCell";
    ServerTableViewCell *cell = [_waiterTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[ServerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.EmportModel = self.waiterDS[indexPath.row];
    cell.cancelBtn.tag = indexPath.row;
    cell.modifyBtn.tag = indexPath.row;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkLarge:)];
    [cell.waiterCode addGestureRecognizer:tapGesture];
    cell.waiterCode.tag = indexPath.row;
    [tapGesture setNumberOfTapsRequired:1];
    [cell.cancelBtn addTarget:self action:@selector(cancelWiter:) forControlEvents:UIControlEventTouchUpInside];
    [cell.modifyBtn addTarget:self action:@selector(modifyWaiter:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark--行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
-(void)cancelWiter:(UIButton *)sender{
    [_changeServerDelegate deleteServerById:[NSString stringWithFormat:@"%@",self.waiterDS[sender.tag].waiterId] Name:[NSString stringWithFormat:@"%@",self.waiterDS[sender.tag].waiterName]];
}
-(void)modifyWaiter:(UIButton *)sender{
    [_changeServerDelegate modifyServerById:[NSString stringWithFormat:@"%@",self.waiterDS[sender.tag].waiterId] Name:[NSString stringWithFormat:@"%@",self.waiterDS[sender.tag].waiterName]];
}
-(void)checkLarge:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    NSString * newImg = [NSString stringWithFormat:@"%@%@%@%@",imgAddress,_waiterDS[tap.view.tag].waiterCode,middleAddress,OSS_LIST_STYLE];
    [_changeServerDelegate checkOriginal:newImg];
}
-(void)addWaiter{
    [_changeServerDelegate addServer];

}
-(void)reloadTable{
    [self.waiterTableView reloadData];
}
@end
