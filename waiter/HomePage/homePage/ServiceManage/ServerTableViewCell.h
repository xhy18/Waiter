//
//  ServerTableViewCell.h
//  waiter
//
//  Created by renxin on 2019/7/18.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waiterInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServerTableViewCell : UITableViewCell
@property(nonatomic,strong) waiterInfo * EmportModel;
@property(nonatomic,strong) UIButton * cancelBtn;
@property(nonatomic,strong) UIButton * modifyBtn;
@property(nonatomic,strong)UIImageView * waiterCode;
@end

NS_ASSUME_NONNULL_END
