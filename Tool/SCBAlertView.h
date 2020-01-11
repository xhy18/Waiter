//
//  SCBAlertView.h
//  Scan bee
//
//  Created by 秦焕 on 2018/12/6.
//  Copyright © 2018年 秦焕. All rights reserved.
//

#import "SCBBlurryWindow.h"
#import "MyUtils.h"

@interface SCBAlertView : SCBBlurryWindow
@property(nonatomic,strong)UIButton * closeButton;
@property(nonatomic,strong)UIButton * cancellButton;
@property(nonatomic,strong)UIButton * deleteButton;
@property(nonatomic,strong)NSString * labelTitle;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)message;
@end
