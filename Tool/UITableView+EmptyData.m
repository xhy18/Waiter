//
//  UITableView+EmptyData.m
//  qinwutong
//
//  Created by ltl on 2019/3/11.
//  Copyright © 2019 none. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)
-(void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSInteger) rowCount{
    if (rowCount == 0) {
        // 没有数据的时候，UILabel的显示样式
        UIView *background = [[UIView alloc] init];
        UIImage *image = [UIImage imageNamed:@"icon_logo.jpg"];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(120, 120, image.size.width, image.size.height);
        imageView.image = image;
        [background addSubview:imageView];
//(self.superview.bounds.size.width - image.size.width) / 2
        
        //-----------------------------------------
        UILabel *messageLabel = [UILabel new];
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
//        messageLabel.textColor = [UIColor colorWithRed:25/255 green:25/255 blue:112/255 alpha:0.3];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        [messageLabel sizeToFit];
//        [background addSubview: messageLabel];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}
@end
