//
//  serverManageModel.h
//  waiter
//
//  Created by renxin on 2019/7/16.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "waiterInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface serverManageModel : NSObject
@property(strong,nonatomic)NSString * waiterId;
@property(strong,nonatomic)NSString * waiterName;
@property(strong,nonatomic)NSString * waiterCode;
@property(strong,nonatomic)NSString * waiterTable;
@property(strong,nonatomic)NSMutableArray<waiterInfo *> * waiterInfoList;
-(void)getAllWaiterList;
-(void)deleteWaiterById:(NSString *) waiterId;
@end

NS_ASSUME_NONNULL_END
