//
//  PackageDetailViewController.h
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageDetailViewController : UIViewController

//订单类型
@property(nonatomic, strong) NSString * orderType;
//订单id（“package_id”）
@property(nonatomic, strong) NSString * packageNum;

@end

NS_ASSUME_NONNULL_END
