//
//  ModifyServiceView.h
//  waiter
//
//  Created by renxin on 2019/7/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waiterTable.h"
NS_ASSUME_NONNULL_BEGIN
@protocol modifyWaiterDelegate <NSObject>

-(void)addServerData:(NSMutableArray<NSDictionary *>*)dataArray waiterName:(NSString *)waiterName type:(NSString *)type;
-(void)changeServer;

@end
@interface ModifyServiceView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray<waiterTable *> * tableInfoDS;
@property(nonatomic,weak)id<modifyWaiterDelegate> modifyWaiterDelegate;
@property(nonatomic,strong)UILabel * WaiterName;
@property(nonatomic,strong)NSString * oldName;
@property(nonatomic,strong)UITextField * waiterNameText;
@property(nonatomic,strong)UILabel * chooseTable;
@property(nonatomic,strong)UICollectionView * tableView;
@property(nonatomic,strong)UIButton * submitBtn;
@property(nonatomic,strong)NSDictionary * submitData;
@property(nonatomic,strong)NSMutableArray<NSDictionary *> * submitArray;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<waiterTable*>*) dataArray;
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSMutableArray<waiterTable*>*) waiterArray waiterName:(NSString *)WaiterName;
@end

NS_ASSUME_NONNULL_END
