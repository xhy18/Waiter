//
//  MakingOrdersView.m
//  waiter
//
//  Created by ltl on 2019/7/12.
//  Copyright © 2019 renxin. All rights reserved.
//  点餐视图

#import "MakingOrdersView.h"
#import "SingleListCollectionViewCell.h"
#import "DishInfoCollectionViewCell.h"
#import "ShopCarTableViewCell.h"
#import "SingleDishObj.h"
#import "Header.h"
#import "MyUtils.h"
#define FONTSIZE 15
#define shallowGray [UIColor colorWithRed:238/255 green:99/255 blue:99/255 alpha:1.0]

@implementation MakingOrdersView{
    CGFloat tableHeight;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.singleClassifyArray = [[NSMutableArray<SingleDishObj * > alloc] init];
        self.singleDishArray = [[NSMutableArray<SingleDishObj * > alloc] init];
        self.setMenuArray = [[NSMutableArray<SetMenuObj * > alloc] init];
        self.singleArray = [[NSMutableArray alloc] init];
        self.menuArray = [[NSMutableArray alloc] init];
        tableHeight = 0;
        
        //1.单点按钮
        UIButton * singleDishBtn = [[UIButton alloc]init];
        singleDishBtn.backgroundColor = GLOBALGRAYCOLOR;
        singleDishBtn.layer.borderWidth = 1;
        singleDishBtn.layer.cornerRadius = 3;
        singleDishBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [singleDishBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_singleDish"] forState:UIControlStateNormal];
        [singleDishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [singleDishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [singleDishBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [singleDishBtn setSelected:YES];
        [singleDishBtn setTag:1001];
        singleDishBtn.userInteractionEnabled = YES;
        [singleDishBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        _singleDishBtn = singleDishBtn;
        [self addSubview:singleDishBtn];
        
        //2.套餐按钮
        UIButton * comboMealBtn = [[UIButton alloc]init];
        comboMealBtn.backgroundColor = GLOBALGRAYCOLOR;
        comboMealBtn.layer.borderWidth = 0;
        comboMealBtn.layer.cornerRadius = 3;
        [comboMealBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_comboMeal"] forState:UIControlStateNormal];
        [comboMealBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [comboMealBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [comboMealBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [comboMealBtn setSelected:NO];
        [comboMealBtn setTag:1002];
        comboMealBtn.userInteractionEnabled = YES;
        [comboMealBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        _comboMealBtn = comboMealBtn;
        [self addSubview:comboMealBtn];
        
        //3.主菜单区
        UIView * mainView = [[UIView alloc]init];
        mainView.backgroundColor = GLOBALGRAYCOLOR;
        _mainView = mainView;
        [self addSubview:mainView];
        
        //4.单点菜单区
        UIView * singleDishView = [[UIView alloc]init];
        singleDishView.backgroundColor = GLOBALGRAYCOLOR;
        _singleDishView = singleDishView;
        [_mainView addSubview:singleDishView];
        
        //5.套餐菜单区
        UIView * comboMealView = [[UIView alloc]init];
        comboMealView.backgroundColor = GLOBALGRAYCOLOR;
        comboMealView.hidden = YES;
        _comboMealView = comboMealView;
        [_mainView addSubview:comboMealView];
        
        //6.底部白色背景视图
        UIView * backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.userInteractionEnabled = YES;
        _backgroundView = backgroundView;
        [self addSubview:backgroundView];
        
        //7.购物车
        UIImageView * shopCarView = [[UIImageView alloc] init];
        shopCarView.image = [UIImage imageNamed:@"shopCar.png"];
        _shopCarView = shopCarView;
        _shopCarView.userInteractionEnabled = YES;
        [backgroundView addSubview:shopCarView];
        
        //8.点餐数量视图
        UIView * shopNumView = [[UIView alloc]init];
        shopNumView.backgroundColor = MAINCOLOR;
        shopNumView.layer.cornerRadius = 9;
        shopNumView.userInteractionEnabled = YES;
        _shopNumView = shopNumView;
        _shopNumView.hidden = YES;
        [backgroundView addSubview:shopNumView];
        
        //9.点餐数量
        UILabel * numLabel = [[UILabel alloc]init];
        numLabel.text = @"";
        numLabel.font = [UIFont systemFontOfSize:9];
        numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel = numLabel;
        [_shopNumView addSubview:numLabel];
       
        //10.打包按钮
        UIButton * packageBtn = [[UIButton alloc]init];
        packageBtn.backgroundColor = GLOBALGRAYCOLOR;
        packageBtn.layer.borderWidth = 0;
        [packageBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_package"] forState:UIControlStateNormal];
        [packageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [packageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [packageBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [packageBtn setSelected:NO];
        [packageBtn setTag:101];
        packageBtn.userInteractionEnabled = YES;
        _packageBtn = packageBtn;
        [backgroundView addSubview:packageBtn];
        
        //11.点餐按钮
        UIButton * makeOrderBtn = [[UIButton alloc]init];
        makeOrderBtn.backgroundColor = GLOBALGRAYCOLOR;
        makeOrderBtn.layer.borderWidth = 0;
        [makeOrderBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_makeOrder"] forState:UIControlStateNormal];
        [makeOrderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [makeOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [makeOrderBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [makeOrderBtn setSelected:NO];
        [makeOrderBtn setTag:102];
        makeOrderBtn.userInteractionEnabled = YES;
        _makeOrderBtn = makeOrderBtn;
        [backgroundView addSubview:makeOrderBtn];
        
        //12.菜品
        UILabel * dishNumLabel = [[UILabel alloc]init];
        dishNumLabel.text = [NSString stringWithFormat:@"0%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_dishNum"]];
        dishNumLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        dishNumLabel.textAlignment = NSTextAlignmentRight;
        _dishNumLabel = dishNumLabel;
        [backgroundView addSubview:dishNumLabel];
        
        //13.总价
        UILabel * totalLabel = [[UILabel alloc]init];
        totalLabel.text = [NSString stringWithFormat:@"%@0.00€",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"]];
        totalLabel.font = [UIFont systemFontOfSize:FONTSIZE];
        _totalLabel = totalLabel;
        [backgroundView addSubview:totalLabel];
        
        //14.提交按钮
        UIButton * submitBtn = [[UIButton alloc]init];
        submitBtn.backgroundColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
        submitBtn.layer.borderWidth = 0;
        [submitBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_confirmSubmit"] forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [submitBtn setTag:103];
        submitBtn.userInteractionEnabled = YES;
        _submitBtn = submitBtn;
        [backgroundView addSubview:submitBtn];
        
        //15.购物车详情
        UIView * shopCarDetailView = [[UIView alloc]init];
        shopCarDetailView.backgroundColor = [UIColor colorWithRed:0/225 green:0/255 blue:0/255 alpha:0.2];
        shopCarDetailView.hidden = YES;
        _shopCarDetailView = shopCarDetailView;
        [self addSubview:shopCarDetailView];
        
        //16.创建手势识别器对象
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [tap addTarget:self action:@selector(showShopCarDetail:)];
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] init];
        tap1.numberOfTapsRequired = 1;
        tap1.numberOfTouchesRequired = 1;
        [tap1 addTarget:self action:@selector(showShopCarDetail:)];
        [self.shopCarView addGestureRecognizer:tap];
        [self.shopNumView addGestureRecognizer:tap1];

        //17.购物车列表
        UITableView * shopTable = [[UITableView alloc]init];
        shopTable.backgroundColor = [UIColor whiteColor];
        [shopTable registerClass:[ShopCarTableViewCell class] forCellReuseIdentifier:@"detailCell"];
        shopTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        shopTable.separatorColor = [UIColor clearColor];
        [shopTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        shopTable.tag = 1002;
        shopTable.bounces = NO;
        shopTable.delegate = self;
        shopTable.dataSource = self;
        [shopTable addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        _shopTable = shopTable;
        [_shopCarDetailView addSubview:shopTable];
        
        //18.背景手势
        UITapGestureRecognizer * hidden = [[UITapGestureRecognizer alloc] init];
        hidden.numberOfTapsRequired = 1;
        hidden.numberOfTouchesRequired = 1;
//        [hidden addTarget:self action:@selector(hiddenShopCarDetail:)];
        hidden.delegate = self;
//        [self.shopCarDetailView addGestureRecognizer:hidden];
    }
    return  self;
}
//-(void)hiddenShopCarDetail:(id)sender{
//    self.shopCarDetailView.hidden = YES;
//}
//#pragma mark - UIGestureRecognizerDelegate
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if( self.shopCarDetailView.hidden == NO ){
//        NSString * touchClass = NSStringFromClass([touch.view class]);
//        NSLog(@"手势类型%@",touchClass);
//        //判断点击视图的类型是不是UITableView的cell类型
//        if ([touchClass isEqualToString:@"UITableViewCellContentView"]) {
//            //如果是，返回false,不截获touch事件
//            NSLog(@"cell");
//            return false;
//        }else{
//            NSLog(@"not cell");
//            //允许接受手势控制
//            return true;
//        }
//    }else{
//        NSLog(@"hidden cell");
//        return true;
//    }
//}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    //上栏按钮
    _singleDishBtn.frame = CGRectMake(0, 0, selfWidth/2, 50);
    _comboMealBtn.frame = CGRectMake(selfWidth/2, 0, selfWidth/2, 50);
    
    //中区菜单
    CGFloat backgroundHeight = 160;
    _mainView.frame = CGRectMake(0, _singleDishBtn.frame.size.height, selfWidth, selfHeight-_singleDishBtn.frame.size.height-backgroundHeight);
    _mainView.backgroundColor = [UIColor grayColor];
    
    NSLog(@"mainView%f",_mainView.frame.size.height);
    NSLog(@"mainView%f",_mainView.frame.size.width);
    
    _singleDishView.frame = CGRectMake(0, 0, _mainView.frame.size.width, _mainView.frame.size.height);
    _comboMealView.frame = CGRectMake(0, 0, _mainView.frame.size.width, _mainView.frame.size.height);
    NSLog(@"_singleDishView%f",_singleDishView.frame.size.height);
    NSLog(@"_singleDishView%f",_singleDishView.frame.size.width);
    //底部视图
    _backgroundView.frame = CGRectMake(0, selfHeight-backgroundHeight, selfWidth, backgroundHeight);
    
    _shopCarView.frame = CGRectMake((selfWidth*0.25-30)/2, 10, 30, 30);
    _shopNumView.frame = CGRectMake(_shopCarView.frame.origin.x+18, 8, 18, 18);
    _numLabel.frame = CGRectMake(0, 0, _shopNumView.frame.size.width, _shopNumView.frame.size.height);
    
    CGFloat btnWidth = (selfWidth*0.75 -10 -3)/2;
    _packageBtn.frame = CGRectMake(selfWidth*0.25, 10, btnWidth, 40-10);
    _makeOrderBtn.frame = CGRectMake(_packageBtn.frame.origin.x+btnWidth+3, 10, btnWidth, 40-10);
    
    CGFloat labelOffset = _packageBtn.frame.origin.y + _packageBtn.frame.size.height;
    CGFloat labelWidth = (selfWidth-30)/2;
    _dishNumLabel.frame = CGRectMake(0, labelOffset, labelWidth, 50);
    _totalLabel.frame = CGRectMake(labelWidth+30, labelOffset, labelWidth, 50);

    CGFloat btnOffset = _dishNumLabel.frame.origin.y + _dishNumLabel.frame.size.height;
    _submitBtn.frame = CGRectMake(60, btnOffset+5, selfWidth-2*60, backgroundHeight - btnOffset-20);
    _submitBtn.layer.cornerRadius = _submitBtn.frame.size.height/2;
    
    _shopCarDetailView.frame = CGRectMake(0, 0, selfWidth, selfHeight-_backgroundView.frame.size.height);
    _shopTable.frame = CGRectMake(0, _shopCarDetailView.frame.size.height-tableHeight, selfWidth, tableHeight);
   
}

#pragma mark - CollectionView 初始化

- (void)initSingleListCollection:(NSMutableArray<SingleDishObj *> *)singleList{
    NSLog(@"initSingleListCollection");
    self.singleClassifyArray = singleList.mutableCopy;
    NSLog(@"view单点:%@", self.singleClassifyArray);
    
    UICollectionViewFlowLayout * singleDishListLayout = [[UICollectionViewFlowLayout alloc] init];
    [singleDishListLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *  singleDishCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 80, _singleDishView.frame.size.height) collectionViewLayout:singleDishListLayout];
    singleDishCollectionView.backgroundColor = GLOBALGRAYCOLOR;
    [singleDishCollectionView registerClass:[SingleListCollectionViewCell class] forCellWithReuseIdentifier:@"listCell"];
    singleDishCollectionView.tag = 1001;
    singleDishCollectionView.delegate = self;
    singleDishCollectionView.dataSource = self;
    _singleDishCollectionView = singleDishCollectionView;
    [_singleDishView addSubview:singleDishCollectionView];


//    [_leftCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
}

- (void)initSingleDishCollection:(NSMutableArray<SingleDishObj *> *)singleDish{
    NSLog(@"initSingleDishCollection");
    self.singleDishArray = singleDish;
    NSLog(@"view单点can:%@", self.singleDishArray.mutableCopy);
    
    UICollectionViewFlowLayout * singleDishlayout = [[UICollectionViewFlowLayout alloc] init];
    [singleDishlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *  dishCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_singleDishCollectionView.frame.size.width, 0, _singleDishView.frame.size.width-_singleDishCollectionView.frame.size.width, _singleDishView.frame.size.height-5) collectionViewLayout:singleDishlayout];
    dishCollectionView.backgroundColor = GLOBALGRAYCOLOR;
    [dishCollectionView registerClass:[DishInfoCollectionViewCell class] forCellWithReuseIdentifier:@"dishCell"];
    dishCollectionView.tag = 1002;
    dishCollectionView.delegate = self;
    dishCollectionView.dataSource = self;
    _dishCollectionView = dishCollectionView;
    [_singleDishView addSubview:dishCollectionView];
}

- (void)initSetMenuCollection:(NSMutableArray<SetMenuObj *> *)setMenuList{
    NSLog(@"initSingleDishCollection");
    self.setMenuArray = setMenuList.mutableCopy;
    NSLog(@"view套餐:%@", self.setMenuArray);
    
    UICollectionViewFlowLayout * setMenulayout = [[UICollectionViewFlowLayout alloc] init];
    [setMenulayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *  setMenuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _comboMealView.frame.size.width, _comboMealView.frame.size.height) collectionViewLayout:setMenulayout];
    setMenuCollectionView.backgroundColor = GLOBALGRAYCOLOR;
    [setMenuCollectionView registerClass:[DishInfoCollectionViewCell class] forCellWithReuseIdentifier:@"setMenuCell"];
    setMenuCollectionView.tag = 1003;
    setMenuCollectionView.delegate = self;
    setMenuCollectionView.dataSource = self;
    _setMenuCollectionView = setMenuCollectionView;
    [_comboMealView addSubview:setMenuCollectionView];
}

#pragma mark - 点击事件

- (void)showShopCarDetail:(id)sender{
    if(self.shopCarDetailView.hidden){
        if( !(self.singleArray.count == 0 && self.menuArray.count == 0) ){
            self.shopCarDetailView.hidden = NO;
        }
    }else{
        self.shopCarDetailView.hidden = YES;
//        [UIView performWithoutAnimation:^{
//            self.shopTable UITableViewRowAnimationBottom;
//        }];
//        [UIView animateWithDuration:0.3
//                         animations:^{
//                             self.alpha = 0.0;
//                         }
//                         completion:^(BOOL finished) {
//                             //                         singleInstance = nil;
//                             [self removeFromSuperview];
//                         }];
        
    }
}

//单点/套餐切换
- (void)changeView:(id)sender{
    UIButton * btn = sender;
    NSLog(@"切换:%ld",(long)btn.tag);
    if( btn.tag == 1001){
        _singleDishBtn.selected = YES;
        _singleDishView.hidden = NO;
        _singleDishBtn.layer.borderWidth = 1;
        _singleDishBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _comboMealBtn.selected = NO;
        _comboMealView.hidden = YES;
        _comboMealBtn.layer.borderWidth = 0;
        _comboMealBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }else{
        _comboMealBtn.selected = YES;
        _comboMealView.hidden = NO;
        _comboMealBtn.layer.borderWidth = 1;
        _comboMealBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _singleDishBtn.selected = NO;
        _singleDishView.hidden = YES;
        _singleDishBtn.layer.borderWidth = 0;
        _singleDishBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

//修改购物车数量
- (void)changeShopCarNum:(int)num shopCarPrice:(double)price{
    _numLabel.text = [NSString stringWithFormat:@"%d",num];
    _dishNumLabel.text = [NSString stringWithFormat:@"%d%@",num,[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_dishNum"]];
    _totalLabel.text = [NSString stringWithFormat:@"%@%.2f%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_totalPrice"],price,@"€"];
}

//生成一条单点购物车数据
- (ShopCarSingleObj  *)createDishId:(NSString *)dish_id name:(NSString *)dish_name price:(double)dish_price{
    NSLog(@"加购物车");
    ShopCarAddDishObj * addDish = [[ShopCarAddDishObj alloc] init];
    NSMutableArray * list = [[NSMutableArray alloc] init];
    addDish.add_price = 0;
    addDish.dish_id = dish_id;
    addDish.dish_name = dish_name;
    addDish.dish_option_id_list = list;
    addDish.dish_option_string = @"";
    addDish.dish_price = dish_price;
    addDish.dish_type = @"0";
    addDish.dish_waiter_remark = @"";
    addDish.isPay = @"false";
    addDish.is_have_options = @"false";
    addDish.is_selected = @"false";
    
    ShopCarSingleObj * single = [[ShopCarSingleObj alloc] init];
    single.model_category = @"0";
    single.model_number = 1;
    single.pay_type = @"0";
    single.set_menu_dish_prices = 0;
    single.set_menu_dishes_remarks = @"";
    single.set_menu_price = 0;
    single.set_menu_waiter_remark = @"";
    single.single_dish = addDish;
    double totalPrice = addDish.dish_price * single.model_number;
    single.single_dish_prices = totalPrice;
    return single;
}

//生成一条套餐购物车数据
- (ShopCarSetMenuObj *)createSetMenuId:(NSString *)menuId name:(NSString *)name price:(double)price{
    ShopCarSetMenuObj * addSetMenu = [[ShopCarSetMenuObj alloc] init];
    addSetMenu.model_category = @"1";
    addSetMenu.model_number = 1;
    addSetMenu.pay_type = @"0";
    double dish_prices = addSetMenu.model_number * price;//总价
    addSetMenu.set_menu_dish_prices = dish_prices;
    addSetMenu.set_menu_dishes_remarks = @"";
    addSetMenu.set_menu_id = menuId;
    addSetMenu.set_menu_name = name;
    addSetMenu.set_menu_price = price;
    addSetMenu.set_menu_waiter_remark = @"";
    addSetMenu.single_dish_prices = 0;
    
    NSMutableArray<ShopCarAddDishObj *> * dishes = [[NSMutableArray<ShopCarAddDishObj *> alloc] init];
    addSetMenu.set_menu_dishes = dishes;
    return addSetMenu;
}

#pragma mark - CollectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1001) {
        return [self.singleClassifyArray count];
    }if(collectionView.tag == 1002){
        return [self.singleDishArray count];
    }if(collectionView.tag == 1003){
        return [self.setMenuArray count];
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView.tag == 1001){
        SingleListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
//        if(cell == nil){
//            cell = [[ShopCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"detailCell"];
//        }
        SingleDishObj *info = [self.singleClassifyArray objectAtIndex:indexPath.row];
        if(info){
            cell.classId = info.class_id;
            cell.listName.text = info.class_name;
            cell.tag = indexPath.row;
        }
        if(indexPath.row == 0){
            //默认选中第一个分类
            cell.listName.textColor = [UIColor blackColor];
            cell.underline.hidden = NO;
        }
        return cell;
    }if(collectionView.tag == 1002){
        DishInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dishCell" forIndexPath:indexPath];
//        if(cell == nil){
//            cell = [[ShopCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"detailCell"];
//        }
        SingleDishObj *info = [self.singleDishArray objectAtIndex:indexPath.row];
        if(info){
            cell.backgroundColor = [UIColor whiteColor];
            cell.dishName.text = info.dish_name;
            cell.dishPrice.text = [NSString stringWithFormat:@"%.2f€",info.dish_price];
            cell.dish_id = info.dish_id;
            cell.dish_price = info.dish_price;
            cell.is_contain_options = info.is_contain_options;
            cell.tag = indexPath.row;
        }
        return cell;
    }
    else{
        DishInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"setMenuCell" forIndexPath:indexPath];
//        if(cell == nil){
//            cell = [[DishInfoCollectionViewCell alloc] initWithStyle:UICollectionViewCell  reuseIdentifier:@"setMenuCell"];
//        }
        SetMenuObj *info = [self.setMenuArray objectAtIndex:indexPath.row];
        if(info){
            cell.backgroundColor = [UIColor whiteColor];
            cell.dishName.text = info.set_menu_name;
            cell.dishPrice.text = [NSString stringWithFormat:@"%.2f€",info.set_menu_price];
            cell.set_menu_id = info.set_menu_id;
            cell.set_menu_price = info.set_menu_price;
            cell.tag = indexPath.row;
        }
        return cell;
    }
    /*
        for (UIView *view in [c.contentView subviews]){
            [view removeFromSuperview];
        }

    */
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if( collectionView.tag == 1001 ){
        for (SingleListCollectionViewCell *cell in _singleDishCollectionView.visibleCells) {
            if(cell.tag == indexPath.row){
                cell.listName.textColor = [UIColor blackColor];
                cell.underline.hidden = NO;
            }else{
                cell.listName.textColor = [UIColor grayColor];
                cell.underline.hidden = YES;
            }
        }
        //获取新单点列表
        SingleListCollectionViewCell * cell = (SingleListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (self.delegate && [self.delegate respondsToSelector:@selector(getNewClassId:)]) {
            [self.delegate getNewClassId:cell.classId];
        }
        //        NSArray *cells = _leftCollectView.visibleCells;
        //        for (UICollectionViewCell *cell in cells) {
        //            NSLog(@"%d",cell.tag);
        //        }
        //
    }if(collectionView.tag == 1002){
        DishInfoCollectionViewCell * cell = (DishInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NSString * dishId = cell.dish_id;
        NSLog(@"1002的id---%@",dishId);
        ShopCarSingleObj * single = [self createDishId:cell.dish_id name:cell.dishName.text price:cell.dish_price];
        if(cell.is_contain_options){
            NSLog(@"有口味");
            //有口味进临时购物车变量
            if (self.delegate && [self.delegate respondsToSelector:@selector(addSingleDishTasteToShopCar:)]) {
                [self.delegate addSingleDishTasteToShopCar:single];
            }
        }else{
            //无口味直接加购物车
            if (self.delegate && [self.delegate respondsToSelector:@selector(addSingleDishNoTasteToShopCar:)]) {
                [self.delegate addSingleDishNoTasteToShopCar:single];
            }
        }
    }if(collectionView.tag == 1003){
        DishInfoCollectionViewCell * cell = (DishInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NSString * setMenuName = cell.dishName.text;
        NSString * setMenuId = cell.set_menu_id;
        NSLog(@"1003的id---%@",setMenuId);
        ShopCarSetMenuObj * setMenu = [self createSetMenuId:setMenuId name:setMenuName price:cell.set_menu_price];
        if (self.delegate && [self.delegate respondsToSelector:@selector(getsetMenuDetail: menuName: addSetMenuToShopCar:)]) {
            [self.delegate getsetMenuDetail:setMenuId menuName:setMenuName addSetMenuToShopCar:setMenu];
        }
    }
}

//设置每个item的UIEdgeInsets内边距,「上左下右」
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if( collectionView.tag == 1001 ){
        return UIEdgeInsetsMake( 0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if( collectionView.tag == 1001 ){
        return 0;
    }else{
        return 0;
    }
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if( collectionView.tag == 1001 ){
        return 0;
    }else{
        return 10;
    }
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView.tag == 1001){
        return CGSizeMake(_singleDishCollectionView.frame.size.width, 50);
    }if(collectionView.tag == 1002){
        return CGSizeMake(_dishCollectionView.frame.size.width/2-10, 70);
    }else{
        return CGSizeMake(_comboMealView.frame.size.width/2-10, 70);
    }
}


/*

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    if(collectionView.tag == 1){
        return headerView;
    }
    for (UIView *view in [headerView subviews]){
        [view removeFromSuperview];
    }
    headerView.backgroundColor =[UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    label.text = [NSString stringWithFormat:@"%@ >>",[_secondTitle objectAtIndex:indexPath.section]];
    //    label.font = [UIFont systemFontOfSize:_secondFont];
    [label setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:_secondFont]];
    label.frame = CGRectMake(5, 0, _rightWid, 20);
    //    label.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:label];
    return headerView;
}
*/


/*
//当左collectionview滑到底部的时候，遍历collectionViewCell居然拿不到第一个（已经滑出屏幕），只好在滚动事件中去修改他的选中颜色
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (UICollectionViewCell *cell in _leftCollectView.visibleCells) {
        if(cell.tag == _firstIndex)
            cell.backgroundColor = grayBgColor;
        else
            cell.backgroundColor = [UIColor whiteColor];
    }
}
 */

#pragma mark -  tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return self.singleArray.count;
    }if(section == 1){
        return self.menuArray.count;
    }else{
       return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        ShopCarSingleObj * dish = self.singleArray[indexPath.row];
        CGFloat waiter = 0;
        if([dish.single_dish.dish_waiter_remark isEqualToString:@""]){
            waiter = 20;
        }else{
            CGFloat height=[(NSString *)dish.single_dish.dish_waiter_remark boundingRectWithSize:CGSizeMake(SCREENWIDTH-60-15, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
            if(height<20){
                height = 20;
            }else if(height>20 && height<=40){
                height = 40;
            }
            waiter = height;
        }
        NSLog(@"单点++++++++%f",30 + waiter);
        return 30 + waiter;
//        return 120;
    }if(indexPath.section == 1){
        ShopCarSetMenuObj * setMenu = self.menuArray[indexPath.row];
        CGFloat waiter = 0;
        if([setMenu.set_menu_waiter_remark isEqualToString:@""]){
            waiter = 0;
        }else{
            CGFloat height=[(NSString *)setMenu.set_menu_waiter_remark boundingRectWithSize:CGSizeMake(SCREENWIDTH-60-15, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
            if(height<20){
                height = 20;
            }else if(height>20 && height<=40){
                height = 40;
            }
            waiter = height;
        }
        if(setMenu.set_menu_dishes.count<=1){
            NSLog(@"套餐++++++++%f",30 + 20 + waiter);
            return 30 + 20 + waiter;
        }else{
            NSLog(@"套餐++++++++%f",30 + setMenu.set_menu_dishes.count*20 + waiter);
            return 30 + setMenu.set_menu_dishes.count*20 + waiter;
        }
//        return 120;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ShopCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"detailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    if(indexPath.section == 0){
        ShopCarSingleObj *info = [self.singleArray objectAtIndex:indexPath.row];
        if(info){
            cell.type = 0;
            cell.dish = info;
            cell.dishName.text = info.single_dish.dish_name;
            cell.price.text = [NSString stringWithFormat:@"%.2f%@",info.single_dish_prices,@"€"];
            cell.num.text = [NSString stringWithFormat:@"%d",info.model_number];
        }
    }else{
        ShopCarSetMenuObj *info = [self.menuArray objectAtIndex:indexPath.row];
        if(info){
            cell.type = 1;
            cell.setMenu = info;
            cell.dishName.text = info.set_menu_name;
            NSLog(@"-----%f",info.set_menu_dish_prices);
            cell.price.text = [NSString stringWithFormat:@"%.2f%@",info.set_menu_dish_prices,@"€"];
            cell.num.text = [NSString stringWithFormat:@"%d",info.model_number];
        }
    }
    UITapGestureRecognizer *showWaiterRemark = [[UITapGestureRecognizer alloc] init];
    cell.dishName.tag = indexPath.section * 1000 + indexPath.row;
    [showWaiterRemark addTarget:self action:@selector(showWaiterRemark:)];
    [cell.dishName addGestureRecognizer:showWaiterRemark];
    
    cell.sub.section = indexPath.section;
    cell.sub.row = indexPath.row;
    cell.sub.changeNum = -1;
    [cell.sub addTarget:self action:@selector(changeShopCar:) forControlEvents:UIControlEventTouchUpInside];
    cell.add.section = indexPath.section;
    cell.add.row = indexPath.row;
    cell.add.changeNum = 1;
    [cell.add addTarget:self action:@selector(changeShopCar:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - shopCar操作

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGRect frame = self.shopTable.frame;
    frame.size = self.shopTable.contentSize;
    tableHeight = frame.size.height+2;
    if(self.shopCarDetailView.frame.size.height <= tableHeight){
        tableHeight = self.shopCarDetailView.frame.size.height;
    }
    self.shopTable.frame = CGRectMake(0, _shopCarDetailView.frame.size.height-tableHeight, self.frame.size.width, tableHeight);
}

- (void)changeShopCar:(id)sender{
    ShopCarButton * btn = sender;
    NSInteger section = btn.section;
    NSInteger row = btn.row;
    int state = btn.changeNum;
    NSLog(@"%ld%ld%d",(long)section,(long)row,state);
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeShopCar: row: state:)]) {
        [self.delegate changeShopCar:section row:row state:state];
    }
}

- (void)showWaiterRemark:(id)sender{
    UITapGestureRecognizer * tap = (UITapGestureRecognizer*)sender;
    UIView * view = (UIView *)tap.view;
    NSUInteger tag = view.tag;
    NSLog(@"-----tag---%lu",(unsigned long)tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(addRemark:)]) {
        [self.delegate addRemark:tag];
    }
    
}

@end
