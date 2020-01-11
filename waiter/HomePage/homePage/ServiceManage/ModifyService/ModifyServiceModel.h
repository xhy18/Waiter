//
//  ModifyServiceModel.h
//  waiter
//
//  Created by renxin on 2019/7/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaiterTable.h"
NS_ASSUME_NONNULL_BEGIN

@interface ModifyServiceModel : NSObject
@property(strong,nonatomic)NSMutableArray<waiterTable *> * tableInfo;
@property(strong,nonatomic)NSMutableArray<waiterTable *> * tableWaiterInfo;
-(void)GetTableInformation;
-(void)GetTableInfoByWaiterId:(NSString *)waiterId;
-(void)updateWaiterInfo:(NSMutableArray<NSDictionary *>*)waiterTable nameInfo:(NSString *)waiterName idInfo:(NSString *)waiterId type:(NSString *)type;
-(void)addWaiterInfo:(NSMutableArray<NSDictionary *>*)waiterTable nameInfo:(NSString *)waiterName;
@end

NS_ASSUME_NONNULL_END
