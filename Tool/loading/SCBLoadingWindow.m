//
//  SCBLoadingWindow.m
//  Scan bee
//
//  Created by zhao on 2019/1/16.
//  Copyright © 2019年 秦焕. All rights reserved.
//

#import "SCBLoadingWindow.h"

@implementation SCBLoadingWindow
-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        //self.backgroundColor = Color6;
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.backView = [[UIVisualEffectView alloc] initWithEffect:blur];
        
        //创建弹框的外边框
        UIView *alert = [[UIView alloc]init];
        alert.backgroundColor = [UIColor whiteColor];
        alert.layer.cornerRadius = 5.0;
        alert.layer.shadowOffset = CGSizeMake(2, 2);
        alert.layer.shadowOpacity = 0.8;
        alert.layer.shadowColor = [UIColor blackColor].CGColor;
        _alertFrame = alert;
        
        
        //创建弹框内的内容
        UILabel *content = [[UILabel alloc]init];
        //content.backgroundColor = [UIColor purpleColor];
        content.font = [UIFont systemFontOfSize:16.0];
        content.numberOfLines = 0;
        content.textAlignment = NSTextAlignmentCenter;
        _alertContent = content;
        
        _gifImageView = [[UIImageView alloc]init];
        NSString * filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"loadingGIF1" ofType:@"gif"];
        NSData * imageData = [NSData dataWithContentsOfFile:filePath];
        _gifImageView.image = [UIImage sd_animatedGIFWithData:imageData];
        
        
        [self addSubview:self.backView];
        [self.backView.contentView addSubview:_gifImageView];
    }
    return  self;
}

//重写layoutSubviews方法，父控件改变尺寸时调用该方法，父控件有了尺寸再设置子控件的尺寸
-(void)layoutSubviews{
    //一定调用父类方法
    [super layoutSubviews];
    //设置子控件的尺寸
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat alertWidth = width * 0.8;
    CGFloat alertHeight = 0.3 * height;
    
    self.backView.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
    //设置子控件的位置
    self.alertFrame.frame = CGRectMake(0.1 * width, 0.2 * height, width * 0.8, 0.3 * height);
    
    self.alertContent.frame = CGRectMake(5, 10, alertWidth - 10, alertHeight / 3 + 30);
    _gifImageView.frame = CGRectMake(0, 0, 100, 100);
    
}

+(void)showLoadingView{
    SCBLoadingWindow *loadingView = [[SCBLoadingWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    loadingView.windowLevel = UIWindowLevelAlert - 1;
//    loadingView.hidden = NO;
//    loadingView.backgroundColor = [UIColor redColor];
    //UIViewController *currentVC = [DIYAFNetworking findCurrentViewController];
    [loadingView makeKeyAndVisible];
    UIWindow *topWindow = [[[UIApplication sharedApplication] delegate] window];
    NSLog(@"clqss:%@",topWindow.class);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
