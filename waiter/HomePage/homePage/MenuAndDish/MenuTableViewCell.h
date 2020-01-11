//
//  MenuTableViewCell.h
//  waiter
//
//  Created by renxin on 2019/5/7.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * menuName;

@property(nonatomic,strong)UISwitch * isChoosed;


//@property(strong,nonatomic)IBOutlet UILabel * tipTitle;

@end

NS_ASSUME_NONNULL_END
