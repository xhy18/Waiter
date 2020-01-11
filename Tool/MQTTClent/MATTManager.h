//
//  BasicMessage.h
//  waiter
//
//  Created by renxin on 2019/8/2.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTSessionManager.h>
NS_ASSUME_NONNULL_BEGIN

@interface MATTManager : NSObject
+(MQTTManager *)sharedManager;

@property(nonatomic,strong) MQTTSessionManager * sessionManager;
@end

NS_ASSUME_NONNULL_END
