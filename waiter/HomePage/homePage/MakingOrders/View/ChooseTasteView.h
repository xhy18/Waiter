//
//  ChooseTasteView.h
//  waiter
//
//  Created by ltl on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasteTypeObj.h"
#import "MyButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChooseTasteViewDelegte <NSObject>

/**
 * 给controller回传口味id数组/口味字符
 * @param dish_option_id_list id数组
 * @param dish_option_string 口味字符
 */
- (void)dishOptionIdList:(NSMutableArray *)dish_option_id_list dishOptionString:(NSString *)dish_option_string;

@end

@interface ChooseTasteView : UIWindow

//单独获取菜品口味列表
@property(nonatomic, strong) NSMutableArray<TasteTypeObj *> *dishTasteArray;

//口味视图
@property(nonatomic, strong) UIView *tasteView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//滚动视图
@property(nonatomic, strong) UIScrollView *tasteScroll;
//取消按钮
@property(nonatomic, strong) UIButton *cancelBtn;
//确定按钮
@property(nonatomic, strong) UIButton *sureBtn;
//保存所有口味按钮
@property(nonatomic, strong) NSMutableArray *btnList;

//初始化
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray<TasteTypeObj *> *)dishTasteArray;

- (void)showWithAnimation:(BOOL)animation;
- (void)hideWithAnimation:(BOOL)animation;

@property(nonatomic, weak) id<ChooseTasteViewDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
