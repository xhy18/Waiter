//
//  ChooseTasteView.m
//  waiter
//
//  Created by ltl on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//  选择口味视图

#import "ChooseTasteView.h"

#import "MyUtils.h"
#import "Header.h"

@implementation ChooseTasteView

static ChooseTasteView *singleInstance;
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray<TasteTypeObj *> *)dishTasteArray{
    self = [super initWithFrame:frame];
    if(self){
        self.dishTasteArray = dishTasteArray.mutableCopy;
        self.btnList = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.windowLevel = UIWindowLevelAlert - 1;
        singleInstance = self;
        NSLog(@"ChooseTasteView:%@",self.dishTasteArray);
        
        //1.背景视图
        UIView * tasteView = [[UIView alloc] init];
        tasteView.backgroundColor = [UIColor whiteColor];
        tasteView.layer.cornerRadius = 6;
//        tasteView.layer.shadowOffset = CGSizeMake(2, 2);
//        tasteView.layer.shadowOpacity = 0.8;
//        tasteView.layer.shadowColor = [UIColor blackColor].CGColor;
        _tasteView = tasteView;
        [self addSubview:_tasteView];
        
        //2.标题
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = [NSString stringWithFormat:@"%@",[MyUtils GETCurrentLangeStrWithKey:@"MakingOrders_remarks"]];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
        [_tasteView addSubview:_titleLabel];
        
        //3.创建scrolView
        UIScrollView * tasteScroll = [[UIScrollView alloc] init];
        _tasteScroll = tasteScroll;
        [_tasteView addSubview:tasteScroll];
        
        //4.创建取消按钮
        UIButton * cancelBtn = [[UIButton alloc] init];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.layer.borderColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
        cancelBtn.layer.borderWidth = 1.0;
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"cancel"] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelBtn addTarget:self action:@selector(hideWithAnimation:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = cancelBtn;
        [_tasteView addSubview:_cancelBtn];
        
        //5.创建确定按钮
        UIButton * sureBtn = [[UIButton alloc] init];
        sureBtn.backgroundColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
        sureBtn.layer.borderColor = [UIColor colorWithRed:183/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
        sureBtn.layer.borderWidth = 1.0;
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"ok"] forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [sureBtn addTarget:self action:@selector(submitTaste:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn = sureBtn;
        [_tasteView addSubview:_sureBtn];
    }
    return  self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;

    CGFloat blank = 15;
    _tasteView.frame = CGRectMake(20, selfHeight*0.15, selfWidth-2*20, selfHeight*0.7);
    _titleLabel.frame = CGRectMake(0, 0, _tasteView.frame.size.width, 50);
    
    CGFloat btnWidth = (_tasteView.frame.size.width-2*blank-14)/2;
    _cancelBtn.frame = CGRectMake(blank, _tasteView.frame.size.height-40-blank, btnWidth, 40);
    _cancelBtn.layer.cornerRadius = 40/2;
    _sureBtn.frame = CGRectMake(btnWidth+blank+14, _tasteView.frame.size.height-40-blank, btnWidth, 40);
    _sureBtn.layer.cornerRadius = 40/2;
    
    _tasteScroll.frame = CGRectMake(0, _titleLabel.frame.size.height, _tasteView.frame.size.width, _tasteView.frame.size.height - _titleLabel.frame.size.height - _sureBtn.frame.size.height - blank - 5);
    
    [self setTasteBtnView];
}

- (void)setTasteBtnView{
    CGFloat width = _tasteScroll.frame.size.width;
    CGFloat totalHight = 0;//初始化总高度
    NSMutableArray<MyButton *> * tmp = [[NSMutableArray<MyButton *> alloc] init];
    //根据数组创建口味选项的按钮
    int tasteViewTagIndex = 1;
    
    for(TasteTypeObj * taste in self.dishTasteArray){

        //1.创建每一类口味的View（oneTasteViewHight按钮总高度和title高度）
        UIView * oneTasteView = [[UIView alloc] init];
        CGFloat oneTasteViewHight = ((int)(taste.option_item.count + 1)/2 + 1) * 40;
        oneTasteView.frame = CGRectMake(0, totalHight, width, oneTasteViewHight);
        oneTasteView.tag = tasteViewTagIndex * 1000;
        [self.tasteScroll addSubview:oneTasteView];
        
        //2.title
        UILabel * tasteTitleLabel = [[UILabel alloc] init];
        tasteTitleLabel.frame = CGRectMake(10, 0, oneTasteView.frame.size.width-10, 40);
        tasteTitleLabel.font = [UIFont systemFontOfSize:15];
        tasteTitleLabel.text = taste.type_name;
        [oneTasteView addSubview:tasteTitleLabel];
        
        //3.创建单个的口味按钮
        int tasteBtnIndex = 0;//每个按键的索引值
        for(optionItemObj * eachTaste in taste.option_item){
            MyButton * tasteBtn = [[MyButton alloc]init];
            tasteBtn.frame = CGRectMake(10 + (tasteBtnIndex % 2) * (oneTasteView.frame.size.width / 2), (int)(tasteBtnIndex / 2 + 1) * 40 + 5, oneTasteView.frame.size.width/2 - 20, 30);
            tasteBtn.backgroundColor = GLOBALGRAYCOLOR;
            tasteBtn.tag = oneTasteView.tag + tasteBtnIndex + 1;
            [tasteBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [tasteBtn setTitle:eachTaste.item_name forState:UIControlStateNormal];
            tasteBtn.item_id = eachTaste.item_id;
            tasteBtn.item_name = eachTaste.item_name;
            tasteBtn.section = tasteViewTagIndex - 1;
            tasteBtn.layer.cornerRadius = 3;
            tasteBtn.selected = NO;
            [tasteBtn addTarget:self action:@selector(tasteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [tasteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [tasteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [oneTasteView addSubview:tasteBtn];
            tasteBtnIndex ++ ;
            [tmp addObject:tasteBtn];
        }
        [self.btnList addObject:tmp];
        tmp = @[].mutableCopy;

        totalHight += oneTasteViewHight;
        tasteViewTagIndex ++ ;
         
    }
    self.tasteScroll.contentSize = CGSizeMake(0, totalHight);
    NSLog(@"btnList--%@",self.btnList);
}

#pragma mark - 事件

//选择口味
- (void)tasteBtnClick:(MyButton * )btn{
    NSLog(@"%d",btn.selected?true:false);
    BOOL state = btn.selected?true:false;
    if(state){
        btn.selected = NO;
//        btn.layer.shadowOffset = CGSizeMake(2, 2);
//        btn.layer.opacity = 0.8;
//        btn.layer.shadowColor = [UIColor blackColor].CGColor;
    }else{
        //进行选中
        NSMutableArray<MyButton *> * array = self.btnList[btn.section];
        NSLog(@"array----%@",array);
        for( int i = 0 ; i < array.count ; i++ ){
            MyButton * tmpBtn = array[i];
            if( tmpBtn.tag == btn.tag){
                tmpBtn.selected = YES;
            }else{
                tmpBtn.selected = NO;
            }
        }
    }
}

//提交口味
- (void)submitTaste:(id)sender{
    NSMutableArray * dish_option_id_list = [[NSMutableArray alloc] init];
    NSString * dish_option_string = @"";
    for( int i = 0 ; i < self.btnList.count ; i++ ){
        NSMutableArray<MyButton *> * array = self.btnList[i];
        for( int j = 0 ; j < array.count ; j++ ){
            NSLog(@"j--%d",j);
            MyButton * btn = array[j];
            if(btn.selected){
                NSLog(@"btn.item_name--%@",btn.item_name);
                [dish_option_id_list addObject:btn.item_id];
                dish_option_string = [NSString stringWithFormat:@"%@,%@", dish_option_string, btn.item_name];
                NSLog(@"dish_option_string-2222-%@",btn.item_name);
            }else{
                continue;
            }
        }
    }
    if( dish_option_string.length > 0){
      dish_option_string = [dish_option_string substringFromIndex:1];
    }
    NSLog(@"dish_option_id_list--%@",dish_option_id_list);
    NSLog(@"dish_option_string--%@",dish_option_string);
    if (self.delegate && [self.delegate respondsToSelector:@selector(dishOptionIdList: dishOptionString:)]) {
        [self.delegate dishOptionIdList:dish_option_id_list dishOptionString:dish_option_string];
    }
    [self hideWithAnimation:NO];
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

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
