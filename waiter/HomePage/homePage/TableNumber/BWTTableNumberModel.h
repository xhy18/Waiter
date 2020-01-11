//
//  BWTTableNumberModel.h
//  waiter
//
//  Created by Haze_z on 2019/8/5.
//  Copyright © 2019 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableNumber.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWTTableNumberModel : NSObject
@property(strong,nonatomic)NSMutableArray<TableNumber *> * tableInfo;

-(void)GetTableNumber;
-(void)GetTable_QRCode:(NSString *)table;
@end

NS_ASSUME_NONNULL_END
