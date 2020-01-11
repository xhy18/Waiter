//
//  SCBLoadingView.m
//  Scan bee
//
//  Created by zhao on 2019/1/16.
//  Copyright © 2019年 秦焕. All rights reserved.
//

#import "SCBLoadingView.h"

@implementation SCBLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if(self == [super init]){
        [self showLoadingWindow];
    }
    return self;
}

-(void)showLoadingWindow{
    self.backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backWindow.windowLevel = UIWindowLevelAlert - 1;
    self.backWindow.hidden = NO;
    self.backWindow.backgroundColor = [UIColor redColor];
    [self.backWindow makeKeyAndVisible];
}

@end
