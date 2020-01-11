//
//  AlertView.h
//  waiter
//
//  Created by ltl on 2019/8/6.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIWindow

//背景视图
@property(nonatomic, strong) UIView *backgroundView;
//提示语
@property(nonatomic, strong) UILabel *contextLabel;
//取消按钮
@property(nonatomic, strong) UIButton *cancelBtn;
//确定按钮
@property(nonatomic, strong) UIButton *sureBtn;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)context;
- (void)showWithAnimation:(BOOL)animation;
- (void)hideWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
