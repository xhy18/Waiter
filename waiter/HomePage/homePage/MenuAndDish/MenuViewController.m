//
//  MenuViewController.m
//  waiter
//
//  Created by renxin on 2019/4/30.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuManageModel.h"
#import "Header.h"
#import "MenuTableViewCell.h"
#import "menuInfo.h"

@interface MenuViewController()<UITableViewDelegate,UITableViewDataSource>
    @property (nonatomic, strong)UITableView *menuTable;
    @property (nonatomic, strong)MenuManageModel * menuModel;
    @property (nonatomic, strong)NSMutableArray<menuInfo *> *dataSource;

@end

@implementation MenuViewController
//-(UITableView *)menuTable{
//    if(_menuTable == nil){
//        self.menuTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
//        _menuTable.delegate = self;
//        _menuTable.dataSource = self;
//        _menuTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.001)];
//
//        _menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    NSLog(@"degffdgfdhg");
//    return _menuTable;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"AAAAAAAAA");
    self.menuModel = [[MenuManageModel alloc]init];
    self.dataSource  = [[NSMutableArray alloc]init];
    [_menuModel GetAllMenuList];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetMenu_fromServer) name:@"Get_MenuFromServer" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"QQQQQQQQQ");
    [super viewDidLoad];
    
    
}
-(void)GetMenu_fromServer{
    NSLog(@"ASFDESF");
    _dataSource = _menuModel.theMenuArray;
    self.menuTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    _menuTable.delegate = self;
    _menuTable.dataSource = self;
    _menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_menuTable];
}

#pragma mark -- UITableViewDelegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark 第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)_dataSource.count);
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer = @"cell";
    MenuTableViewCell *cell = [_menuTable dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }

    cell.menuName.text = _dataSource[indexPath.row].menuName;
    
    cell.menuName.font = [UIFont boldSystemFontOfSize:14];
    cell.menuName.backgroundColor = [UIColor yellowColor];
//    cell.menuName.text = _dataSource[indexPath.row].menuName;
//    cell.
  
    
    return cell;
}
#pragma mark--行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)changeMenuState{
    
}
-(void)dealloc{
    
}
@end
