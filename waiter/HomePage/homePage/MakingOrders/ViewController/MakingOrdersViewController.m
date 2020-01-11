//
//  MakingOrdersViewController.m
//  waiter
//
//  Created by ltl on 2019/7/15.
//  Copyright © 2019 renxin. All rights reserved.
//  点餐控制

#import "MakingOrdersViewController.h"
#import "MakingOrdersModel.h"
#import "ShopCarModel.h"
#import "MakingOrdersView.h"
#import "ChooseTasteView.h"
#import "ChooseSetMenuDetailView.h"
#import "ChooseTableInfoView.h"
#import "AddShopCarRemarkView.h"

#import "Header.h"
#import "MyUtils.h"

@interface MakingOrdersViewController ()<MakingOrdersViewDelegte,ChooseTasteViewDelegte,ChooseTableInfoViewDelegte,ChooseSetMenuDetailViewDelegte,AddShopCarRemarkViewDelegte>

@property(nonatomic, strong) ShopCarModel * shopCarModel;
@property(nonatomic, strong) MakingOrdersModel * makeOrderModel;
@property(nonatomic, strong) MakingOrdersView * makeOrderView;
@property(nonatomic, strong) ChooseTasteView * chooseTasteView;
@property(nonatomic, strong) ChooseTableInfoView * chooseTableInfoView;
@property(nonatomic, strong) ChooseSetMenuDetailView * chooseSetMenuDetailView;
@property(nonatomic, strong) AddShopCarRemarkView * addShopCarRemarkView;


//商家点餐模式，键值（ "support_set_menu"，"support_single_ordering"）
@property(nonatomic, strong) NSMutableDictionary *dishModeDic;
//可用桌号数组
@property(nonatomic, strong) NSMutableArray *tableNumArray;
//购物车单点临时变量
@property(nonatomic, strong) ShopCarSingleObj * tmpSingleDish;
//购物车套餐临时变量
@property(nonatomic, strong) ShopCarSetMenuObj * tmpSetMenuDish;
//最后提交给服务器的数组
@property(nonatomic, strong) NSMutableArray * finalArray;

//弹窗套餐名
@property(nonatomic, strong) NSString *setMenuName;
//打包按钮
@property(nonatomic, strong) UIButton *packageBtn;
//点餐按钮
@property(nonatomic, strong) UIButton *makeOrderBtn;
//确认提交按钮
@property(nonatomic, strong) UIButton *submitBtn;
//从弹窗拿到的桌号
@property(nonatomic, strong) NSString *tableNumString;
//从弹窗拿到的人数
@property(nonatomic, strong) NSString *peopleNumString;
//订单类型，0点餐，2打包
@property(nonatomic, strong) NSString *orderType;

//加减购物车用到的按钮标志
@property(nonatomic, assign) NSInteger btnSection;
@property(nonatomic, assign) NSInteger btnRow;

//添加备注用到的tap标志
@property(nonatomic, assign) NSInteger section;
@property(nonatomic, assign) NSInteger row;

//口味请求来源，1：直接从单点查询；-1，从套餐的某详情中再次查询
@property(nonatomic, assign) NSInteger tasteDataSource;

@end

@implementation MakingOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_makeOrder"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.setMenuName = [[NSString alloc] init];
    
    self.finalArray = [[NSMutableArray alloc] init];
    self.orderType = [[NSString alloc] init];
    self.btnSection = 0;
    self.btnRow = 0;
    self.section = 0;
    self.row = 0;
    self.tasteDataSource = 0;
    
    float sch = SCREENHEIGHT;
    float top = TOPOFFSET;
    float mainHeight = sch - top;
    
    //model
    MakingOrdersModel * makeOrderModel = [[MakingOrdersModel alloc] init];
    self.makeOrderModel = makeOrderModel;
    [self.makeOrderModel getShopDishMode];
    ShopCarModel * shopCarModel = [[ShopCarModel alloc] init];
    self.shopCarModel = shopCarModel;
    [self.shopCarModel InitShopCar];
    
    //view
    MakingOrdersView * makeOrderView = [[MakingOrdersView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
    self.makeOrderView = makeOrderView;
    self.packageBtn = makeOrderView.packageBtn;
    [self.packageBtn addTarget:self action:@selector(chooseOrderType:) forControlEvents:UIControlEventTouchUpInside];
    self.makeOrderBtn = makeOrderView.makeOrderBtn;
    [self.makeOrderBtn addTarget:self action:@selector(chooseOrderType:) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn = makeOrderView.submitBtn;
    [self.submitBtn addTarget:self action:@selector(submitShopCar:) forControlEvents:UIControlEventTouchUpInside];
    self.makeOrderView.delegate = self;
    [self.view addSubview:makeOrderView];
    
    //备注view
    AddShopCarRemarkView * addShopCarRemarkView = [[AddShopCarRemarkView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.addShopCarRemarkView = addShopCarRemarkView;
    self.addShopCarRemarkView.delegate = self;
    
    //获取商家点餐模式通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_Shop_Dish_Mode) name:@"getShopDishMode" object:nil];
    //获取单点列表通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_Single_List) name:@"getSingleList" object:nil];
    //获取单点下某菜品
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_Single_Dish_List) name:@"getSingleDishList" object:nil];
    //获取套餐通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_Set_Menu_List) name:@"getSetMenuList" object:nil];
    //获取口味通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_Dish_Taste) name:@"getDishTaste" object:nil];
    //获取某套餐详情通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_Set_Menu_Detail_List) name:@"getSetMenuDetailList" object:nil];
    //获取桌号通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get_Table_Num) name:@"getTableNum" object:nil];
    //获取加购物车成功通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(add_Shop_Car) name:@"addShopCar" object:nil];
    //订单提交成功通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submit_Success) name:@"submitSuccess" object:nil];
    
    [self.makeOrderModel getComboMenu];
    [self.makeOrderModel getShopTableNumber];
}

#pragma mark - 通知方法

- (void)get_Shop_Dish_Mode{
    //保存点餐模式
    self.dishModeDic = self.makeOrderModel.dishModeDic;
    NSLog(@"controller商家模式%@",self.dishModeDic);

    //获取模式下内容
    [self.makeOrderModel getSingleDishClassification];
}

- (void)get_Single_List{
    //获取单点分类
    [self.makeOrderView initSingleListCollection:self.makeOrderModel.singleClassifyArray];
    //获取单点分类下第一个菜品列表
    [self.makeOrderModel getSingleDish:self.makeOrderModel.singleClassifyArray[0].class_id];
}

- (void)get_Single_Dish_List{
    //保存单点菜品列表
    [self.makeOrderView initSingleDishCollection:self.makeOrderModel.singleDishArray];
}

- (void)get_Set_Menu_List{
    [self.makeOrderView initSetMenuCollection:self.makeOrderModel.setMenuArray];
}

- (void)get_Dish_Taste{
    //初始化口味弹窗
    ChooseTasteView * chooseTasteView = [[ChooseTasteView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) dataSource:self.makeOrderModel.dishTasteArray];
    self.chooseTasteView = chooseTasteView;
    self.chooseTasteView.delegate = self;
    [self.chooseTasteView showWithAnimation:NO];
}

- (void)get_Set_Menu_Detail_List{
    //初始化套餐弹窗
    ChooseSetMenuDetailView * chooseSetMenuDetailView = [[ChooseSetMenuDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) setMenuName:self.setMenuName dataSource:self.makeOrderModel.setMenuDetailArray];
    self.chooseSetMenuDetailView = chooseSetMenuDetailView;
    self.chooseSetMenuDetailView.delegate = self;
    [chooseSetMenuDetailView showWithAnimation:NO];
}

- (void)get_Table_Num{
    self.tableNumArray = self.makeOrderModel.tableNumArray.mutableCopy;
    ChooseTableInfoView * chooseTableInfoView = [[ChooseTableInfoView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) tableNumData:self.tableNumArray];
    self.chooseTableInfoView = chooseTableInfoView;
    self.chooseTableInfoView.delegate = self;
}

- (void)add_Shop_Car{
    //拿到个数，总价，更改数据源，刷新页面
    [self.makeOrderView changeShopCarNum:self.shopCarModel.totalNum shopCarPrice:self.shopCarModel.totalPrice];
    self.makeOrderView.singleArray = self.shopCarModel.shopCarSingleArray.mutableCopy;
    self.makeOrderView.menuArray = self.shopCarModel.shopCarSetMenuArray.mutableCopy;
    [self.makeOrderView.shopTable reloadData];
    if(self.shopCarModel.totalNum == 0){
        self.makeOrderView.shopNumView.hidden = YES;
        self.makeOrderView.shopCarDetailView.hidden = YES;
    }else{
        self.makeOrderView.shopNumView.hidden = NO;
//        self.makeOrderView.shopCarDetailView.hidden = NO;
    }
}

- (void)submit_Success{
    //推到新视图
//    PackageDetailViewController * detailsVC = [[PackageDetailViewController alloc] init];
//    detailsVC.orderType = orderType;
//    detailsVC.packageNum = packageNum;
//    [self.navigationController pushViewController:detailsVC animated:TRUE];
}

#pragma mark - MakingOrdersView代理方法

//查询某分类下所有单品
- (void)getNewClassId:(NSString *)classId{
    NSLog(@"回传classId%@",classId);
    [self.makeOrderModel getSingleDish:classId];
}

//查询单品口味
- (void)getDishTaste:(NSString *)dishId{
    [self.makeOrderModel getDishTaste:dishId];
}

//请求套餐详细信息
- (void)getsetMenuDetail:(NSString *)setMenuId menuName:(NSString *)setMenuName addSetMenuToShopCar:(ShopCarSetMenuObj *)addSetMenu{
    self.setMenuName = setMenuName;
    self.tmpSetMenuDish = addSetMenu;
    [self.makeOrderModel getSetMenu:setMenuId];
}

//添加单点无口味至购物车
- (void)addSingleDishNoTasteToShopCar:(ShopCarSingleObj *)addSingleDish{
    [self.shopCarModel AddSingleDishToShopcar:addSingleDish];
}

//添加单点有口味至临时变量购物车,并请求口味，进入选择口味页
- (void)addSingleDishTasteToShopCar:(ShopCarSingleObj *)addSingleDish{
    self.tmpSingleDish = addSingleDish;
//    NSLog(@"临时单点条目%@",self.shopCarSingleArray);
    self.tasteDataSource = 1;
    [self.makeOrderModel getDishTaste:self.tmpSingleDish.single_dish.dish_id];
}

//加减餐品操作
- (void)changeShopCar:(NSInteger)sec row:(NSInteger)row state:(int)state{
    [self.shopCarModel addOrSubShopCar:sec row:row state:state];
}

//弹出备注弹窗
- (void)addRemark:(NSUInteger)tag{
    int section = (int)tag / 1000;
    int row = (int)tag % 1000;
    NSLog(@"*******%d%d",section,row);
    self.section = section;
    self.row = row;
    NSString * remark = [[NSString alloc] init];
    if (self.section == 0) {
        ShopCarSingleObj * obj = self.shopCarModel.shopCarSingleArray[row];
        remark = obj.single_dish.dish_waiter_remark;
    }else if(self.section == 1){
        ShopCarSetMenuObj * obj = self.shopCarModel.shopCarSetMenuArray[row];
        remark = obj.set_menu_waiter_remark;
    }
    [self.addShopCarRemarkView remarkField:remark];
}

#pragma mark - ChooseTasteView代理方法

- (void)dishOptionIdList:(NSMutableArray *)dish_option_id_list dishOptionString:(NSString *)dish_option_string{
    self.tmpSingleDish.single_dish.dish_option_id_list = dish_option_id_list;
    self.tmpSingleDish.single_dish.dish_option_string = dish_option_string;
    if(self.tasteDataSource == 1){
        //从单点来的口味，直接进临时单点，进购物车
        [self.shopCarModel AddSingleDishToShopcar:self.tmpSingleDish];
        self.tmpSingleDish = @[].mutableCopy;
    }else if(self.tasteDataSource == -1){
        //从套餐来的口味，回传给套餐
        [self.chooseSetMenuDetailView tasteIdList:dish_option_id_list dishOptionString:dish_option_string tnSection:self.btnSection btnRow:self.btnRow];
    }
}

#pragma mark - ChooseTableInfoViewDelegte代理方法

- (void)tableNum:(NSString *)tableNum numOfPeople:(NSString *)peopleNum{
    self.tableNumString = tableNum.mutableCopy;
    self.peopleNumString = peopleNum.mutableCopy;
    
    NSLog(@"zhuohao人数:%@-%@",self.tableNumString,self.peopleNumString);
    [_makeOrderBtn setTitle:[NSString stringWithFormat:@"%@/%@",self.tableNumString,self.peopleNumString] forState:UIControlStateNormal];
}

#pragma mark - ChooseSetMenuDetailViewDelegte代理方法

- (void)dishOptionIdList:(NSMutableArray *)set_menu_dishes{
    self.tmpSetMenuDish.set_menu_dishes = set_menu_dishes;
    for (ShopCarAddDishObj * dic in self.tmpSetMenuDish.set_menu_dishes) {
        self.tmpSetMenuDish.set_menu_price += dic.add_price;
    }
    self.tmpSetMenuDish.set_menu_dish_prices = self.tmpSetMenuDish.set_menu_price;
    //临时套餐进购物车
    NSLog(@"aaaaaaaaaa%f",self.tmpSetMenuDish.set_menu_dish_prices);
    [self.shopCarModel AddSetMenuToShopcar:self.tmpSetMenuDish];
    self.tmpSetMenuDish = @[].mutableCopy;
}

- (void)getDishTaste:(NSString *)dishId btnSection:(NSInteger)section btnRow:(NSInteger)row{
    self.btnSection = section;
    self.btnRow = row;
    self.tasteDataSource = -1;
    [self.makeOrderModel getDishTaste:dishId];
}

#pragma mark - AddShopCarRemarkViewDelegte代理方法

- (void)newRemark:(NSString *)remark{
    NSLog(@"66666666666%@",remark);
    [self.addShopCarRemarkView hideWithAnimation:NO];
    if(self.section == 0){
        ShopCarSingleObj * obj = self.shopCarModel.shopCarSingleArray[self.row];
        obj.single_dish.dish_waiter_remark = remark;
        NSLog(@"///%@",obj.single_dish.dish_waiter_remark);
        self.makeOrderView.singleArray = self.shopCarModel.shopCarSingleArray.mutableCopy;
    }
    if(self.section == 1){
        ShopCarSetMenuObj * obj = self.shopCarModel.shopCarSetMenuArray[self.row];
        obj.set_menu_waiter_remark = remark;
        NSLog(@"0000000000000-%@",obj.set_menu_waiter_remark);
        self.makeOrderView.menuArray = self.shopCarModel.shopCarSetMenuArray.mutableCopy;
    }
    [self.makeOrderView.shopTable reloadData];
    remark = @"";
}

#pragma mark - 事件

- (void)dealloc{
    NSLog(@"移除所有通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//选择订单类型
- (void)chooseOrderType:(UIButton *)btn{
    UIColor * blueColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
    if(btn.tag == 101){
        if( !btn.selected){
            _packageBtn.selected = YES;
            _packageBtn.backgroundColor = blueColor;
            self.orderType = @"2";//打包
            _makeOrderBtn.selected = NO;
            _makeOrderBtn.backgroundColor = GLOBALGRAYCOLOR;
        }
    }
    if(btn.tag == 102){
        if(!btn.selected){
            //点餐
            _makeOrderBtn.selected = YES;
            _makeOrderBtn.backgroundColor = blueColor;
            self.orderType = @"0";//点餐
            _packageBtn.selected = NO;
            _packageBtn.backgroundColor = GLOBALGRAYCOLOR;
            
            [self.chooseTableInfoView showWithAnimation:YES];
        }else{
            [self.chooseTableInfoView showWithAnimation:YES];
        }
    }
}

- (void)submitShopCar:(id)sender{
//    if( self.shopCarModel.shopCarSingleArray.count == 0 && self.shopCarModel.shopCarSetMenuArray.count == 0){
//        NSLog(@"请选择菜品");
//    }
    if( !_makeOrderBtn.selected && !_packageBtn.selected){
        [MyUtils ShowTipMessage:[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_chooseOrderType"]];
    }
    else{
        NSLog(@"订单类型%@",self.orderType);
        NSLog(@"桌号%@",self.tableNumString);
        NSLog(@"人数%@",self.peopleNumString);
        if( [self.orderType isEqualToString:@"2"] ){
            self.tableNumString = @"Take-away";
            self.peopleNumString = @"1";
        }
        NSLog(@"订单类型%@",self.orderType);
        NSLog(@"桌号%@",self.tableNumString);
        NSLog(@"人数%@",self.peopleNumString);
        [self.shopCarModel shopCarToDictionary:^(NSMutableArray * finalArray){
            self.finalArray = finalArray.mutableCopy;
            NSLog(@"最后的解析：%@",self.finalArray);
            [self.makeOrderModel postShopCarOrderdishList:self.finalArray type:self.orderType table:self.tableNumString people:self.peopleNumString];
        }];
    }
}

@end
