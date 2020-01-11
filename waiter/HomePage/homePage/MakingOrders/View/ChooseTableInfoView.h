//
//  ChooseTableInfoView.h
//  waiter
//
//  Created by ltl on 2019/7/21.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChooseTableInfoViewDelegte <NSObject>

/**
 * 给controller回传桌号/人数
 * @param tableNum 桌号
 * @param peopleNum 人数
 */
- (void)tableNum:(NSString *)tableNum numOfPeople:(NSString *)peopleNum;

@end

@interface ChooseTableInfoView : UIWindow<UIGestureRecognizerDelegate>

//可用桌号数组
@property(nonatomic, strong) NSMutableArray *tableNumArray;

//背景视图
@property(nonatomic, strong) UIView *tableNumView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//桌号标签
@property(nonatomic, strong) UILabel *tableLabel;
//桌号步进器底图
@property(nonatomic, strong) UIView *tableStepperView;
//桌号分割线
@property(nonatomic, strong) UILabel *tableLineLabel;
//桌号加按钮
@property(nonatomic, strong) UIButton *addTableBtn;
//桌号减按钮
@property(nonatomic, strong) UIButton *subTableBtn;
//桌号输入框
@property(nonatomic, strong) UITextField *tableTextField;

//人数标签
@property(nonatomic, strong) UILabel *numLabel;
//人数步进器底图
@property(nonatomic, strong) UIView *numStepperView;
//人数分割线
@property(nonatomic, strong) UILabel *numLineLabel;
//人数加按钮
@property(nonatomic, strong) UIButton *addPeopleBtn;
//人数减按钮
@property(nonatomic, strong) UIButton *subPeopleBtn;
//人数输入框
@property(nonatomic, strong) UITextField *peopleTextField;

//取消按钮
@property(nonatomic, strong) UIButton *cancelBtn;
//确定按钮
@property(nonatomic, strong) UIButton *sureBtn;

//初始化
- (instancetype)initWithFrame:(CGRect)frame tableNumData:(NSMutableArray *)data;

- (void)showWithAnimation:(BOOL)animation;
- (void)hideWithAnimation:(BOOL)animation;

@property(nonatomic, weak) id<ChooseTableInfoViewDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
