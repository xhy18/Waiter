//
//  BWTTableNumberViewController.h
//  waiter
//
//  Created by Haze_z on 2019/8/1.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableNumber.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWTTableNumberViewController : UIViewController
@property(strong , nonatomic)UIButton *tableBtn;
@property(strong , nonatomic)NSMutableArray<TableNumber *> *tableDS;
@end

NS_ASSUME_NONNULL_END
