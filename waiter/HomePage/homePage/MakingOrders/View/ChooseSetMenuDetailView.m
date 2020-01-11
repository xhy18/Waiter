//
//  ChooseSetMenuDetailView.m
//  waiter
//
//  Created by ltl on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//  选择套餐详情

#import "ChooseSetMenuDetailView.h"
#import "SetMenuDetailTableViewCell.h"
#import "MyUtils.h"
#import "Header.h"

@implementation ChooseSetMenuDetailView

static ChooseSetMenuDetailView *singleInstance;
- (instancetype)initWithFrame:(CGRect)frame setMenuName:(NSString *)name dataSource:(NSMutableArray<SetMenuDetailObj *> *)setMenuDetailArray{
    self = [super initWithFrame:frame];
    if(self){
        self.setMenuDetailArray = setMenuDetailArray.mutableCopy;
        self.btnList = [[NSMutableArray<MyButton *> alloc] init];
        self.buttonArray = [[NSMutableArray alloc] init];
        self.set_menu_dishes = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.windowLevel = UIWindowLevelAlert - 1;
        singleInstance = self;
        NSLog(@"ChooseSetMenuDetailView:%@",self.setMenuDetailArray);
        
        //1.背景视图
        UIView * detailView = [[UIView alloc] init];
        detailView.backgroundColor = [UIColor whiteColor];
        detailView.layer.cornerRadius = 6;
        _detailView = detailView;
        [self addSubview:_detailView];
        
        //2.标题
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = name;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
        [_detailView addSubview:_titleLabel];
        
        //3.创建取消按钮
        UIButton * cancelBtn = [[UIButton alloc] init];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.layer.borderColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
        cancelBtn.layer.borderWidth = 1.0;
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancel"] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelBtn addTarget:self action:@selector(hideWithAnimation:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = cancelBtn;
        [_detailView addSubview:_cancelBtn];
        
        //4.创建确定按钮
        UIButton * sureBtn = [[UIButton alloc] init];
        sureBtn.backgroundColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
        sureBtn.layer.borderColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
        sureBtn.layer.borderWidth = 1.0;
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [sureBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn = sureBtn;
        [_detailView addSubview:_sureBtn];
    }
    return  self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat blank = 15;
    _detailView.frame = CGRectMake(20, selfHeight*0.075, selfWidth-2*20, selfHeight*0.85);
    _titleLabel.frame = CGRectMake(0, 0, _detailView.frame.size.width, 50);
    
    CGFloat btnWidth = (_detailView.frame.size.width-2*blank-14)/2;
    _cancelBtn.frame = CGRectMake(blank, _detailView.frame.size.height-40-blank, btnWidth, 40);
    _cancelBtn.layer.cornerRadius = 40/2;
    _sureBtn.frame = CGRectMake(btnWidth+blank+14, _detailView.frame.size.height-40-blank, btnWidth, 40);
    _sureBtn.layer.cornerRadius = 40/2;
    
    [self initSetMenuDetailTable];
}

- (void)initSetMenuDetailTable{
    CGFloat blank = 15;
    UITableView * detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.size.height, _detailView.frame.size.width, _detailView.frame.size.height - _titleLabel.frame.size.height - _sureBtn.frame.size.height - blank - 10) style:UITableViewStyleGrouped];
    detailTable.backgroundColor = [UIColor yellowColor];
    [detailTable registerClass:[SetMenuDetailTableViewCell class] forCellReuseIdentifier:@"setMenuCell"];
    detailTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    detailTable.separatorColor = [UIColor clearColor];
    [detailTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    detailTable.delegate = self;
    detailTable.dataSource = self;
    _detailTable = detailTable;
    [_detailView addSubview:detailTable];
}

#pragma mark - setMenu tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.setMenuDetailArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.setMenuDetailArray objectAtIndex:section].dish_list count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SetMenuDetailObj * eachGroup = [self.setMenuDetailArray objectAtIndex:section];
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _detailTable.frame.size.width, 35)];
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, header.frame.size.width - 10, header.frame.size.height)];
    name.text = eachGroup.class_name;
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont systemFontOfSize:15];;
    [header addSubview:name];
    header.backgroundColor = [UIColor greenColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetMenuDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setMenuCell" forIndexPath:indexPath];
    NSMutableArray<SetMenuDishListObj *> * infoList = [self.setMenuDetailArray objectAtIndex:indexPath.section].dish_list;
    SetMenuDishListObj * info = [infoList objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (info) {
        cell.dishLabel.text = info.dish_name;
        MyButton * choose = [[MyButton alloc] init];
        choose.frame = CGRectMake(cell.contentView.frame.size.width - 16 -20, (cell.contentView.frame.size.height - 16)/2, 16, 16);
        choose.layer.borderColor = [UIColor blackColor].CGColor;
        choose.layer.borderWidth = 1;
        choose.layer.cornerRadius = 8;
        choose.backgroundColor = [UIColor whiteColor];
        [choose addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
        choose.section = indexPath.section;
        choose.row = indexPath.row;
        choose.haveTaste = info.is_contain_options;
        
        ShopCarAddDishObj * addDishDetail = [[ShopCarAddDishObj alloc] init];
        choose.addDishDetail = addDishDetail;
        NSMutableArray * list = [[NSMutableArray alloc] init];
        choose.addDishDetail.add_price = info.add_price;
        choose.addDishDetail.dish_id = info.dish_id;
        choose.addDishDetail.dish_name = info.dish_name;
        choose.addDishDetail.dish_option_id_list = list;
        choose.addDishDetail.dish_option_string = @"";
        choose.addDishDetail.dish_price = 0;
        choose.addDishDetail.dish_type = @"0";
        choose.addDishDetail.dish_waiter_remark = @"";
        choose.addDishDetail.isPay = @"false";
        choose.addDishDetail.is_selected = @"false";
        choose.addDishDetail.is_have_options = @"false";
        
        choose.selected = NO;
        [cell.contentView addSubview:choose];
        [self.btnList addObject:choose];
    }
    if( indexPath.row == infoList.count - 1 ){
        [self.buttonArray addObject:self.btnList];
        self.btnList = @[].mutableCopy;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - 事件

- (void)tasteIdList:(NSMutableArray *)dish_option_id_list dishOptionString:(NSString *)dish_option_string tnSection:(NSInteger)section btnRow:(NSInteger)row{
    NSLog(@"苦苦苦苦苦苦苦苦苦苦苦苦-%@/%@/%ld/%ld", dish_option_id_list,dish_option_string,(long)section,(long)row);
    NSMutableArray<MyButton *> * list = self.buttonArray[section];
    MyButton * btn = list[row];
    btn.addDishDetail.dish_option_id_list = dish_option_id_list;
    btn.addDishDetail.dish_option_string = dish_option_string;
}

- (void)submitBtnClick:(id)sender{
    NSLog(@"提交点餐嘤嘤嘤");
    for (int i = 0; i < self.buttonArray.count; i++ ) {
        NSMutableArray<MyButton *> * list = self.buttonArray[i];
        for (int j = 0; j < list.count; j++ ) {
            MyButton * btn = list[j];
            if( btn.selected ){
                [self.set_menu_dishes addObject:btn.addDishDetail];
            }
        }
    }
    NSLog(@"提交点餐%@", self.set_menu_dishes);
    if (self.delegate && [self.delegate respondsToSelector:@selector(dishOptionIdList:)]) {
        [self.delegate dishOptionIdList:self.set_menu_dishes];
    }
    [self hideWithAnimation:YES];
}

- (void)changeState:(MyButton * )btn{
    NSLog(@"array:%@",self.buttonArray);
    NSLog(@"section:%ld",btn.section);
    NSLog(@"row:%ld",btn.row);
    BOOL state = btn.selected?true:false;
    if(state){
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
    }else{
        //单选
        SetMenuDetailObj * sec = [self.setMenuDetailArray objectAtIndex:btn.section];
        if( sec.max_select_number == 1){
            for(int i = 0 ; i < [self.buttonArray[btn.section] count]; i++){
                NSLog(@"num:遍历");
                if( btn.row == i){
                    btn.selected = YES;
                    btn.backgroundColor = [UIColor blackColor];
                }else{
                    MyButton * b = self.buttonArray[btn.section][i];
                    b.selected = NO;
                    b.backgroundColor = [UIColor whiteColor];
                }
            }
            if(btn.haveTaste){
                NSLog(@"有口味-%@/%ld/%ld",btn.addDishDetail.dish_id,(long)btn.section,(long)btn.row);
                if (self.delegate && [self.delegate respondsToSelector:@selector(getDishTaste: btnSection: btnRow:)]) {
                    [self.delegate getDishTaste:btn.addDishDetail.dish_id btnSection:btn.section btnRow:btn.row];
                }
            }
        }else{
            //多选
            NSInteger con = 0;
            for(int i = 0 ; i < [self.buttonArray[btn.section] count]; i++){
                MyButton * b = self.buttonArray[btn.section][i];
                if(b.selected){
                    con++;
                }
            }
            if( con < sec.max_select_number ){
                btn.selected = YES;
                btn.backgroundColor = [UIColor blackColor];
            }else{
                NSLog(@"达到最大数量%d",sec.max_select_number);
            }
            if(btn.haveTaste){
                NSLog(@"有口味-%@/%ld/%ld",btn.addDishDetail.dish_id,(long)btn.section,(long)btn.row);
                if (self.delegate && [self.delegate respondsToSelector:@selector(getDishTaste: btnSection: btnRow:)]) {
                    [self.delegate getDishTaste:btn.addDishDetail.dish_id btnSection:btn.section btnRow:btn.row];
                }
            }
        }
    }
}

- (void)showWithAnimation:(BOOL)animation{
    [self makeKeyAndVisible];
    
    [UIView animateWithDuration:animation ? 0.3 : 0.0
                     animations:^{
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)hideWithAnimation:(BOOL)animation{
    [UIView animateWithDuration:animation ? 0.3 : 0.0
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         singleInstance = nil;
                     }];
}

- (void)dealloc{
    [self resignKeyWindow];
}

@end
