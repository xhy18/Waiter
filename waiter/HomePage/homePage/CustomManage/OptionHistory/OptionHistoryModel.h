//
//  OptionHistoryModel.h
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "waiterHistory.h"
NS_ASSUME_NONNULL_BEGIN

@interface OptionHistoryModel : NSObject
@property(strong,nonatomic)NSMutableArray<waiterHistory *>*waiterHistoryData;
-(void)getWaiterHistoryList:(NSString *)tableName;
-(void)dealCustomCall:(NSString *)table;
@end

NS_ASSUME_NONNULL_END
