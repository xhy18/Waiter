//
//  ChooseSetMenuDetailView.h
//  waiter
//
//  Created by ltl on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetMenuDetailObj.h"
#import "MyButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChooseSetMenuDetailViewDelegte <NSObject>

/**
 * 给controller回传新附加餐
 * @param set_menu_dishes 附加餐数组
 */
- (void)dishOptionIdList:(NSMutableArray *)set_menu_dishes;
/**
 * 给controller提供一个单品id，查询单品口味
 * @param dishId 单品id
 */
- (void)getDishTaste:(NSString *)dishId btnSection:(NSInteger)section btnRow:(NSInteger)row;

@end

@interface ChooseSetMenuDetailView : UIWindow<UITableViewDelegate,UITableViewDataSource>

//套餐列表
@property(nonatomic, strong) NSMutableArray<SetMenuDetailObj *> *setMenuDetailArray;
//每组按钮
@property(nonatomic, strong) NSMutableArray<MyButton *> *btnList;
//按钮列表
@property(nonatomic, strong) NSMutableArray *buttonArray;
//需要提交的附加单点数组
@property(nonatomic, strong) NSMutableArray *set_menu_dishes;

//套餐视图
@property(nonatomic, strong) UIView *detailView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//table
@property(nonatomic, strong) UITableView *detailTable;
//取消按钮
@property(nonatomic, strong) UIButton *cancelBtn;
//确定按钮
@property(nonatomic, strong) UIButton *sureBtn;

//初始化
- (instancetype)initWithFrame:(CGRect)frame setMenuName:(NSString *)name dataSource:(NSMutableArray<SetMenuDetailObj *> *)setMenuDetailArray;
//新回传的口味数组，字符串，btn的位置section和row
- (void)tasteIdList:(NSMutableArray *)dish_option_id_list dishOptionString:(NSString *)dish_option_string tnSection:(NSInteger)section btnRow:(NSInteger)row;

- (void)showWithAnimation:(BOOL)animation;
- (void)hideWithAnimation:(BOOL)animation;

@property(nonatomic, weak) id<ChooseSetMenuDetailViewDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
