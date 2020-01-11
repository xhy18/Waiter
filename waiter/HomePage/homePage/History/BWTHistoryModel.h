//
//  BWTHistoryModel.h
//  waiter
//
//  Created by Haze_z on 2019/8/7.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaiterHistory.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWTHistoryModel : NSObject
@property(strong,nonatomic)NSMutableArray<WaiterHistory *> * historyInfo;
-(void)GetHistoryList;
@end

NS_ASSUME_NONNULL_END
