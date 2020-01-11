//
//  BWTTableNumDetailViewController.h
//  waiter
//
//  Created by Haze_z on 2019/8/5.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWTTableNumDetailViewController : UIViewController

@property(strong , nonatomic)UIView *TableNumView;//显示桌号区域
@property(strong , nonatomic)UILabel *tableNumLabel;//桌号
@property(strong , nonatomic)UIImageView *QRCodeImage;//桌号QRCode
@property(strong , nonatomic)NSString *tableString;//传递桌号值

@end

NS_ASSUME_NONNULL_END
