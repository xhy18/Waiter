//
//  PackageSetUpViewController.h
//  waiter
//
//  Created by ltl on 2019/7/13.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageSetUpViewController : UIViewController

/**
 * 大堂经理改变打包状态
 * @param state 状态
 */
- (void)changePackageState:(BOOL)state;

/**
 * 大堂经理获取现有打包状态
 */
- (void)getPackageState;

@end

NS_ASSUME_NONNULL_END
