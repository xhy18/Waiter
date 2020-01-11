//
//  SingleListCollectionViewCell.h
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
//  左侧单点分类cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleListCollectionViewCell : UICollectionViewCell

//分类id
@property (strong, nonatomic) NSString * classId;
//分类名
@property (strong, nonatomic) UILabel * listName;
//下划线
@property (strong, nonatomic) UILabel * underline;

@end

NS_ASSUME_NONNULL_END
