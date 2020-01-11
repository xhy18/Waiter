//
//  UITableView+EmptyData.h
//  qinwutong
//
//  Created by ltl on 2019/3/11.
//  Copyright © 2019 none. All rights reserved.
//  tableView没有数据的时候，需要显示的view，拓展UIViewTable，之后直接调用

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (EmptyData)
//无订单显示
-(void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSInteger) rowCount;

@end

NS_ASSUME_NONNULL_END
