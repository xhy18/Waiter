//
//  ManageOrderDetailView.h
//  waiter
//
//  Created by renxin on 2019/7/24.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol confirmPayDelegate <NSObject>
-(void)checkOrderDetail;
-(void)confirmPayment;

@end
@interface ManageOrderDetailView : UIView
@property(nonatomic,strong)UIView * orderView;
@property(nonatomic,strong)UILabel * orderNumLabel;
@property(nonatomic,strong)UILabel * orderTelLabel;
@property(nonatomic,strong)UILabel * orderTableLabel;
@property(nonatomic,strong)UILabel * totalPriceLabel;
@property(nonatomic,strong)UIView * orderPayView;
@property(nonatomic,strong)UILabel * payTextLabel;
@property(nonatomic,strong)UILabel * payNumLabel;
@property(nonatomic,strong)UIView * remainPayView;
@property(nonatomic,strong)UILabel * remainPayTextLabel;
@property(nonatomic,strong)UILabel * remainPayNumLabel;
@property(nonatomic,strong)UIButton * checkOrderBtn;
@property(nonatomic,strong)UIButton * confirmPayBtn;
@property(nonatomic,strong)NSDictionary * unpayOrderDS;
@property(nonatomic,weak)id<confirmPayDelegate> confirmPayDelegate;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSDictionary *)dataDic;
@end

NS_ASSUME_NONNULL_END
