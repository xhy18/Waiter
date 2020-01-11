//
//  WaiterSystemModel.h
//  waiter
//
//  Created by renxin on 2019/4/11.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SetLanguage;
typedef void(^LanguageArray) (NSMutableArray<SetLanguage *> *array);//回调的block
NS_ASSUME_NONNULL_BEGIN

@interface WaiterSystemModel : NSObject
//存放语言类型的数组（泛型）
@property(nonatomic,strong)NSMutableArray<SetLanguage *> *languageArray;//SetLanguage为自定义的占位类型名称
@property(nonatomic,strong)NSMutableArray<NSString *> *typeArray;
@property(nonatomic,strong)NSMutableArray<NSString *> *NameArray;
@property(nonatomic,strong)NSMutableArray<NSString *> *SmallNameArray;

//初始化数组
-(void)initLanguageArray;
//根据选择设置数组
-(void)SelectIndex:(NSUInteger)index HaveChangeLanguageArray:(LanguageArray)array;
@end
//语言的数据模型
@interface SetLanguage : NSObject

@property(nonatomic,copy)NSString *languageName;//语言名称
@property(nonatomic,assign)BOOL wetherChoosed;//语言内容
@property(nonatomic,copy)NSString *languageType;//语言类型
@property(nonatomic,copy)NSString *languageSmallName;//语言名称
@end

NS_ASSUME_NONNULL_END
