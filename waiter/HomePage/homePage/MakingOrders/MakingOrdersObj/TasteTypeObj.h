//
//  TasteTypeObj.h
//  waiter
//
//  Created by ltl on 2019/7/19.
//  Copyright © 2019 renxin. All rights reserved.
//  可选口味类型项

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface optionItemObj : NSObject

//选项id
@property (nonatomic, strong) NSString *item_id;
//选项值
@property (nonatomic, strong) NSString *item_name;

@end

@interface TasteTypeObj : NSObject

//口味id
@property (nonatomic, strong) NSString *type_id;
//口味名
@property (nonatomic, strong) NSString *type_name;
//是否多选
@property (nonatomic, assign) BOOL whether_to_multiple;
//口味子选项
@property (nonatomic, strong) NSMutableArray<optionItemObj *> *option_item;

@end

NS_ASSUME_NONNULL_END
