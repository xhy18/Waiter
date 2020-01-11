//
//  SCBBlurryWindow.m
//  Scan bee
//
//  Created by 秦焕 on 2018/11/26.
//  Copyright © 2018年 秦焕. All rights reserved.
//

#import "SCBBlurryWindow.h"

@implementation SCBBlurryWindow
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //在此处创建view
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
   
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //初始化 模糊效果的 UIVisualEffectView
    UIVisualEffectView * blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    //设置 blurEffectView 的 frame
    blurEffectView.frame =[UIScreen mainScreen].bounds;
    
    //添加 blurEffectView 到 self.View 上,如果只是做模糊效果，那么到这一步已经完了
    [self addSubview:blurEffectView];
    
    
    [self makeKeyAndVisible];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
