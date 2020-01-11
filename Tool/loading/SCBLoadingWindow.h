//
//  SCBLoadingWindow.h
//  Scan bee
//
//  Created by zhao on 2019/1/16.
//  Copyright © 2019年 秦焕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImage+GIF.h>
#import "Header.h"
#import "DIYAFNetworking.h"

@interface SCBLoadingWindow : UIWindow
@property(nonatomic , strong)UIView *alertFrame;//弹框的外边框
@property(nonatomic , strong)UIVisualEffectView *backView;//弹框的背景
@property(nonatomic , strong)UILabel *alertContent;//弹框的内容
@property(nonatomic , strong)UIImageView *gifImageView;

+(void)showLoadingView;
@end
