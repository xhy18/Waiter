//
//  JumpType_2_View.h
//  waiter
//
//  Created by Haze_z on 2019/8/9.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol confirmPayDelegate <NSObject>
-(void)checkOrderDetail;
-(void)confirmPayment;
-(void)SecondConfirmPayment;

@end

@interface JumpType_2_View : UIView
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
//-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame PayStatus:(NSString *)payStatus;
-(void)changeManageOrderDetailData:(NSDictionary *)dataDic;
@end


