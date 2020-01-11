//
//  WaiterSystemUIView.m
//  waiter
//
//  Created by renxin on 2019/4/11.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "WaiterSystemUIView.h"
#import "SetLanguageTableViewCell.h"
#import "Header.h"
@implementation WaiterSystemUIView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        self.languageArray = @[].copy; //???????????
        UIView * thelineView = [[UIView alloc]init];
        _lineView = thelineView;
        
        UITableView *languageTableView = [[UITableView alloc]init];
        languageTableView.delegate = self;
        languageTableView.dataSource = self;
        languageTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//设置CGRectZero时会触发layoutSubviews
        languageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _languageTable = languageTableView;
        
        [self addSubview:thelineView];
        [self addSubview:languageTableView];
    }
    return self;
}
//重写View的子控件
-(void)layoutSubviews{
    self.lineView.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    self.languageTable.frame = CGRectMake(0, 1, self.frame.size.width, self.frame.size.height - 20);
}
//设置Section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.languageArray count];
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetLanguageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemLanguageCell"];
    if(!cell){
        cell = [[SetLanguageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SystemLanguageCell"];
    }
    cell.bigNameLabel.text = self.languageArray[indexPath.row].languageName;
    cell.smallNameLabel.text = self.self.languageArray[indexPath.row].languageSmallName;
    cell.smallNameLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [cell.smallNameLabel setTextColor:DEEPGRAYCOLOR];
    if(self.languageArray[indexPath.row].wetherChoosed){
        cell.selectedImage.hidden = NO;
    }else{
        cell.selectedImage.hidden = YES;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击某一行进入详情
    NSLog(@"%ld",indexPath.row);
    [_delegate SelectLanguageIndex:indexPath.row];
}
@end
