//
//  SCBLoadingShareView.h
//  Scan bee
//
//  Created by zhao on 2019/1/16.
//  Copyright © 2019年 秦焕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImage+GIF.h>
#import "Header.h"
#import "MyAFNetworking.h"

@interface SCBLoadingShareView : UIWindow
@property(nonatomic , strong)UIView *backView;//弹框的背景
@property(nonatomic , strong)UILabel *alertContent;//弹框的内容
@property(nonatomic , strong)UIImageView *gifImageView;

+ (instancetype)managerLoadView;
-(void)dissmiss;
-(void)showTheLoadView;
@end
