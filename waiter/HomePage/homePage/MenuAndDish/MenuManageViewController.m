//
//  MenuManageViewController.m
//  waiter
//
//  Created by renxin on 2019/4/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "MenuManageViewController.h"
#import "MyUtils.h"
#import "Header.h"
#import "MyAFNetWorking.h"
#import "MenuManageModel.h"
#import "MenuManageModel.h"
#import "MenuTableViewCell.h"
#import "menuInfo.h"

@interface MenuManageViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIView * menuView;//菜单管理
    UITableView * menuTableView;//菜单表格
    UIView * dishView;//菜品管理
    UITableView * dishTableView;
    UIScrollView * mainScrollView;//滚动视图
    UIView * navView;//导航视图
    UILabel * sliderLabel;//手势滑动焦点
    UIButton * menuBtn;
    UIButton * dishBtn;
    MenuManageModel * menuModel;
    MenuManageModel * dishModel;
    NSMutableArray <menuInfo *> * dataSource;
    NSMutableArray <menuInfo *> * dishSource;
    UILabel * totalNum;//菜品总数
    UILabel * closedNum;//已关闭数量
    int indexNum;
    UIAlertController * alertVC;
    
}


@end

@implementation MenuManageViewController


-(void)initUI{
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH,50)];
    navView.backgroundColor = [UIColor whiteColor];
    menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2, 50);
    menuBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [menuBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"menu_MenuManageBtn"] forState:UIControlStateNormal];
    [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    menuBtn.tag = 101;
    menuBtn.selected = YES;
    [navView addSubview:menuBtn];
    dishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dishBtn.frame = CGRectMake(menuBtn.frame.origin.x+menuBtn.frame.size.width, 0, SCREENWIDTH/2, 50);
    dishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    dishBtn.tag = 102;
    [dishBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [dishBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"menu_FoodManageBtn"] forState:UIControlStateNormal];
    [dishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [navView addSubview:dishBtn];
    sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH/2-50)/2, 50, 50, 3)];
    sliderLabel.backgroundColor = [UIColor redColor];
    sliderLabel.layer.cornerRadius = 3;
    sliderLabel.layer.masksToBounds = YES;
    [navView addSubview:sliderLabel];
    
    [self.view addSubview:navView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"menu_title"];
    [self initUI];
    [self setMainScrollView];
    
    //菜品列表的底部状态栏
    CGFloat scrollOff = TOPOFFSET + navView.frame.size.height + 3;
    UILabel * TotalNum = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-scrollOff-60, SCREENWIDTH/2-40, 60)];
    TotalNum.text = [MyUtils GETCurrentLangeStrWithKey:@"menu_DishNum"];
    TotalNum.textAlignment = NSTextAlignmentRight;
    TotalNum.font = [UIFont boldSystemFontOfSize:14];
    
    
    totalNum =[[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-40, SCREENHEIGHT-scrollOff-60, 40, 60)];
    totalNum.text = @"0";
    totalNum.font = [UIFont boldSystemFontOfSize:14];
    
    
    UILabel * ClosedNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2+20, SCREENHEIGHT-scrollOff-60, 90, 60)];
    ClosedNum.text = [MyUtils GETCurrentLangeStrWithKey:@"menu_DishCloseNum"];
    ClosedNum.textAlignment = NSTextAlignmentCenter;
    ClosedNum.font = [UIFont boldSystemFontOfSize:14];
    
    
    closedNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2+110, SCREENHEIGHT-scrollOff-60, 40, 60)];
    
    closedNum.text = @"0";
    closedNum.textColor = [UIColor redColor];
    closedNum.font = [UIFont boldSystemFontOfSize:14];
    [dishView addSubview:TotalNum];
    [dishView addSubview:ClosedNum];
    [dishView addSubview:totalNum];
    [dishView addSubview:closedNum];
    //菜单列表的数据结构
    
    menuModel = [[MenuManageModel alloc]init];
    dataSource  = [[NSMutableArray alloc]init];
    [menuModel GetAllMenuList];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetMenu_fromServer) name:@"Get_MenuFromServer" object:nil];
    
    //菜品列表的数据结构
    dishModel = [[MenuManageModel alloc]init];
    dishSource = [[NSMutableArray alloc]init];
    [dishModel GetAllDishList];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetDish_fromServer) name:@"Get_DishFromServer" object:nil];
    
}

//在通知方法中获取model
-(void)GetMenu_fromServer{

    dataSource = menuModel.theMenuArray;
    menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    menuTableView.tag = 1000;
    menuTableView.delegate = self;
    menuTableView.dataSource = self;
//    menuTableView.allowsSelection = NO;
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [menuView addSubview:menuTableView];
}

//在通知方法中获得dish的model
-(void)GetDish_fromServer{
    indexNum = 0;
    dishSource = dishModel.theDishArray;
    //计算菜品总数
    totalNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)dishSource.count];
    //计算已关闭的菜品总数
    for(NSInteger i = 0; i<dishSource.count ; i++){
        if([dishSource[i].status isEqualToString:@"0"]){
            indexNum++;
        }
    }
    closedNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)indexNum];
    CGFloat scrollOff = TOPOFFSET + navView.frame.size.height + 3;
    dishTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-scrollOff-60) style:UITableViewStylePlain];
    dishTableView.tag = 1001;
    dishTableView.delegate = self;
    dishTableView.dataSource = self;
    //    menuTableView.allowsSelection = NO;
    dishTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [dishView addSubview:dishTableView];

}

//初始化scrollView
-(void)setMainScrollView{
    CGFloat scrollOff = TOPOFFSET + navView.frame.size.height + 3;
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollOff, SCREENWIDTH, SCREENHEIGHT-scrollOff)];
    mainScrollView.contentSize = CGSizeMake(SCREENWIDTH*2, SCREENHEIGHT-scrollOff);
    menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-scrollOff)];
    dishView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT-scrollOff-60)];
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    NSArray * views = @[menuView,dishView];
    for (NSInteger i = 0; i<views.count; i++) {
        [mainScrollView addSubview:views[i]];
    }
    
}
-(void)sliderAction:(UIButton *)button{
    //ScrollView滚动到特定的位置
    [mainScrollView setContentOffset:CGPointMake(SCREENWIDTH * (button.tag - 101), 0) animated:YES];
    [button setSelected:YES];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curBtn = (mainScrollView.contentOffset.x + SCREENWIDTH / 2) / SCREENWIDTH + 1;
//    NSLog(@"按钮：%ld",(long)curBtn);
    for(NSInteger i = 1; i <= 2; ++i){
        UIButton *btn = (UIButton *)[[scrollView superview]viewWithTag: i + 100];
        if(btn.tag - 100 == curBtn){
            [btn setSelected:YES];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
                [self->sliderLabel setFrame:CGRectMake(btn.frame.origin.x + (SCREENWIDTH/2-50)/2, 50, 50, 3)];
            }];
        }else{
            [btn setSelected:NO];
            [UIView animateWithDuration:0.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }
    }
}



#pragma mark -- UITableViewDelegat
//菜单列表的table代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark 第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag == 1000){

        return dataSource.count;
    }
    else if(tableView.tag == 1001){

        return dishSource.count;
       
    }
    else{
        return 0;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
   
    if(tableView.tag == 1000){
    
        MenuTableViewCell *cell = [menuTableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil) {
            cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
//        NSLog(@"CELL1");
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.menuName.text = dataSource[indexPath.row].menuName;
        cell.menuName.font = [UIFont boldSystemFontOfSize:14];
        UISwitch * choose = [[UISwitch alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.8, 15, 60, 40)];
        choose.transform = CGAffineTransformMakeScale(1.3, 1.2);
        choose.on = NO;
        [cell addSubview:choose];
        choose.tag = indexPath.row;
        [choose addTarget:self action:@selector(switchChangeMenu:) forControlEvents:UIControlEventValueChanged];
            if([dataSource[indexPath.row].status isEqualToString:@"1"]){
                choose.on = YES;
                
            }
            if([dataSource[indexPath.row].menuType isEqualToString:@"0"]){
                cell.menuName.backgroundColor  = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
            }
            else if ([dataSource[indexPath.row].menuType isEqualToString:@"1"]){
                cell.menuName.backgroundColor  = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
            }else if ([dataSource[indexPath.row].menuType isEqualToString:@"2"]){
                cell.menuName.backgroundColor  = [UIColor colorWithRed:255.0/255.0 green:211.0/255.0 blue:43.0/255.0 alpha:1];
            }else{
        
            }
        
        self.flagId = [NSString stringWithFormat:@"%@",dataSource[indexPath.row].menuId];
        return cell;
    }
    else if(tableView.tag == 1001){
        MenuTableViewCell *cell = [menuTableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil) {
            cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.menuName.text = dishSource[indexPath.row].menuName;
        cell.menuName.font = [UIFont boldSystemFontOfSize:14];
        cell.menuName.backgroundColor  = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        UISwitch * choose = [[UISwitch alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.8, 15, 60, 40)];
        choose.transform = CGAffineTransformMakeScale(1.3, 1.2);
        choose.on = NO;
        [cell addSubview:choose];
        choose.tag = indexPath.row;
        [choose addTarget:self action:@selector(switchChangeDish:) forControlEvents:UIControlEventValueChanged];
        if([dishSource[indexPath.row].status isEqualToString:@"1"]){
            choose.on = YES;
            
        }
        self.dishId = [NSString stringWithFormat:@"%@",dishSource[indexPath.row].menuId];
                        
        return cell;
    }
    else{
         MenuTableViewCell *cell = [menuTableView dequeueReusableCellWithIdentifier:identifer];
        return cell;
    }
    
}
#pragma mark--行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)switchChangeMenu:(UISwitch *)sender{
    NSLog(@"status:%@",self->dataSource[sender.tag].status);
    
    if([self->dataSource[sender.tag].status isEqualToString:@"1"]){
        alertVC = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"是否要关闭标签 %@?",dataSource[sender.tag].menuName] preferredStyle:UIAlertControllerStyleAlert];
    }
    else{
        alertVC = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"是否要打开标签 %@?",dataSource[sender.tag].menuName] preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction * cancelBtn = [UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancell"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
        if([self->dataSource[sender.tag].status isEqualToString:@"0"]){
            sender.on = NO;
            NSLog(@"%@",self->dataSource[sender.tag].status);
        }
        else{
            NSLog(@"%@",self->dataSource[sender.tag].status);
            sender.on = YES;
        }
    }];
    UIAlertAction * sureBtn = [UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSString * newStatus = @"0";
        if([self->dataSource[sender.tag].status isEqualToString:@"0"]){
            newStatus = @"1";
        }
        NSLog(@"NEW%@",newStatus);
        [self->menuModel changeMenuStatus:newStatus ById:self->dataSource[sender.tag].menuId];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ChangeMenu_fromServer) name:@"ChangeMenuStatus_Success" object:nil];
        
    }];
    [alertVC addAction:cancelBtn];
    [alertVC addAction:sureBtn];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
-(void)switchChangeDish:(UISwitch *)sender{
//    NSLog(@"%@",self->dishSource[sender.tag].status);
    NSString * status = self->dishSource[sender.tag].status;
    NSLog(@"%@",status);
    //当前状态是0的提示信息
    if([self->dishSource[sender.tag].status isEqualToString:@"0"]){
         alertVC = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"是否要打开标签 %@?",dishSource[sender.tag].menuName] preferredStyle:UIAlertControllerStyleAlert];
    }
    else{
        alertVC = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"是否要关闭标签 %@?",dishSource[sender.tag].menuName] preferredStyle:UIAlertControllerStyleAlert];
    }
   
    UIAlertAction * cancelBtn = [UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancell"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
        if([self->dishSource[sender.tag].status isEqualToString:@"0"]){
            sender.on = NO;
            NSLog(@"dishSource%@",self->dishSource[sender.tag].status);
        }
        else{
            NSLog(@"dishSource%@",self->dishSource[sender.tag].status);
            sender.on = YES;
        }
    }];
    UIAlertAction * sureBtn = [UIAlertAction actionWithTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSString * newStatus = @"0";
        if([self->dishSource[sender.tag].status isEqualToString:@"0"]){
            newStatus = @"1";
        }
//        NSLog(@"之前NEW%@",newStatus);
//        NSLog(@"之前indedxnNum:%d",self->indexNum);
        if([newStatus isEqualToString:@"0"]){
            self->indexNum ++ ;
            self->closedNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)self->indexNum];
        }
        else{
            self->indexNum -- ;
            self->closedNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)self->indexNum];
        }
//        NSLog(@"之后NEW%@",newStatus);
//        NSLog(@"之后indedxnNum:%d",self->indexNum);
        [self->menuModel changeDishStatus:newStatus ById:self->dishSource[sender.tag].menuId];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ChangeDish_fromServer) name:@"ChangeDishStatus_Success" object:nil];
        
    }];
    [alertVC addAction:cancelBtn];
    [alertVC addAction:sureBtn];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
-(void)ChangeDish_fromServer{
    NSLog(@"reloaddish");
    [self->dishTableView reloadData];
}
-(void)ChangeMenu_fromServer{
    [self->menuTableView reloadData];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
}
@end
