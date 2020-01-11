//
//  SingleListCollectionViewCell.m
//  waiter
//
//  Created by ltl on 2019/7/18.
//  Copyright © 2019 renxin. All rights reserved.
//

#import "SingleListCollectionViewCell.h"

@implementation SingleListCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        //1.菜品列表名
        UILabel * listName = [[UILabel alloc] init];
        listName.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-2);
        listName.textAlignment = NSTextAlignmentCenter;
        listName.textColor = [UIColor grayColor];
        listName.font = [UIFont systemFontOfSize:15];
        listName.numberOfLines = 0;
        _listName = listName;
        [self.contentView addSubview:listName];
        
        //2.下划线
        UILabel * underline = [[UILabel alloc] init];
        underline.frame = CGRectMake(5, _listName.frame.size.height-2, self.frame.size.width-10, 2);
        underline.backgroundColor = [UIColor redColor];
        underline.textAlignment = NSTextAlignmentCenter;
        underline.textColor = [UIColor blackColor];
        underline.font = [UIFont systemFontOfSize:15];
        underline.hidden = YES;
        _underline = underline;
        [self.contentView addSubview:underline];
    
    }
    
    return self;
}

@end
