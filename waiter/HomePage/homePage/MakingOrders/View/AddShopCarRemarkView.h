//
//  AddShopCarRemarkView.h
//  waiter
//
//  Created by ltl on 2019/7/27.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddShopCarRemarkViewDelegte <NSObject>

/**
 * 给controller回传备注信息
 */
- (void)newRemark:(NSString *)remark;

@end

@interface AddShopCarRemarkView : UIWindow

//背景视图
@property(nonatomic, strong) UIView *remarkView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//分割
@property(nonatomic, strong) UILabel *lineLabel;
//备注输入框
@property(nonatomic, strong) UITextField *remarkField;
//关闭按钮
@property(nonatomic, strong) UIButton *closeBtn;

- (void)showWithAnimation:(BOOL)animation;
- (void)hideWithAnimation:(BOOL)animation;

//输入框文字
- (void)remarkField:(NSString *)str;

@property(nonatomic, weak) id<AddShopCarRemarkViewDelegte> delegate;

@end

NS_ASSUME_NONNULL_END
