//
//  CustomManageModel.h
//  waiter
//
//  Created by renxin on 2019/7/20.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "callInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomManageModel : NSObject
@property(strong,nonatomic)NSMutableArray<callInfo *> * customCallInfo;
-(void)GetCustomCallList;
@end

NS_ASSUME_NONNULL_END
