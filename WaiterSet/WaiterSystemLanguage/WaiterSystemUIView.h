//
//  WaiterSystemUIView.h
//  waiter
//
//  Created by renxin on 2019/4/11.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiterSystemModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SelectLanguageDelegate <NSObject>

-(void)SelectLanguageIndex:(NSUInteger)index;

@end
@interface WaiterSystemUIView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray<SetLanguage *> *languageArray;
@property(nonatomic,strong)UITableView *languageTable;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,weak)id<SelectLanguageDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
