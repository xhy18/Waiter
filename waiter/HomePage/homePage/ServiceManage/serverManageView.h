//
//  serverManageView.h
//  waiter
//
//  Created by renxin on 2019/7/16.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waiterInfo.h"
NS_ASSUME_NONNULL_BEGIN
//添加，修改，删除服务人员的代理方法
@protocol changeServerDelegate<NSObject>
-(void)deleteServerById:(NSString *)serverId Name:(NSString *)serverName;
-(void)modifyServerById:(NSString *)serverId Name:(NSString *)serverName ;
-(void)addServer;
-(void)checkOriginal:(NSString *)img;
@end
@interface serverManageView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * waiterTableView;
@property(nonatomic,strong)UIView * table_refreshView;
@property(nonatomic,weak)id<changeServerDelegate> changeServerDelegate;
@property(nonatomic,strong)UIButton * addButton;
@property(strong,nonatomic) NSMutableArray<waiterInfo *> * waiterDS;

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray *) dataArray;
-(void)reloadTable;
@end

NS_ASSUME_NONNULL_END
