//
//  SCBLoadingShareView.m
//  Scan bee
//
//  Created by zhao on 2019/1/16.
//  Copyright © 2019年 秦焕. All rights reserved.
//
//#import "ToolHeader.h"
#import "SCBLoadingShareView.h"
#define Color5 [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1.0]
#define LOADWIDTH 120 //Load动画边框的大小
//+(instancetype)sharedManager
//{
//    dispatch_once(&onceToken, ^{
//
//        sInstance= [[self alloc] init];;
//
//        NSLog(@"dispatch once");
//
//    });
//
//    return sInstance;
//
//}


static SCBLoadingShareView *loadViewCenter = nil;
static dispatch_once_t predicateloading;
@implementation SCBLoadingShareView
//static SCBLoadingShareView *loadViewCenter = nil;&predicate
+ (instancetype)managerLoadView {
    //static dispatch_once_t predicate;
    dispatch_once(&predicateloading, ^{
        NSLog(@"cvwcvwcxvwxcv");
//        loadViewCenter = (SCBLoadingShareView *)@"SCBLoadingShareView";
        loadViewCenter = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    //防止子类使用
    if (![NSStringFromClass([self class]) isEqualToString:@"SCBLoadingShareView"]) {
        //#define NSParameterAssert(condition) NSAssert((condition), @"Invalid parameter not satisfying: %@", @#condition)
        //ios 是这么定义NSParameterAssert的
        //传入nil会导致app崩溃
        NSParameterAssert(nil);
    }
    return loadViewCenter;
}

+(void)destroyLoadView{
    loadViewCenter=nil;
    
    predicateloading=0l;
}

-(void)showTheLoadView{
    NSLog(@"djfkdsjfkdjsfkdksfj");
    loadViewCenter.hidden = NO;
    [self makeKeyAndVisible];
}

-(void)dissmiss{
    if([self LoadingViewIsPlay]){
        loadViewCenter=nil;
        predicateloading=0l;
    }
//    for(UIView *subView in loadViewCenter.subviews){
//        [subView removeFromSuperview];
//    }
//    loadViewCenter=nil;
//    predicateloading=0l;
}

-(BOOL)LoadingViewIsPlay{
    BOOL flag = YES;
    if(loadViewCenter == nil)
        flag = NO;
    return flag;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        //self.backgroundColor = Color6;
        
        self.backView = [[UIView alloc]init];
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        
        
        
        //创建弹框内的内容
        UILabel *content = [[UILabel alloc]init];
        //content.backgroundColor = [UIColor purpleColor];
        content.font = [UIFont systemFontOfSize:16.0];
        content.numberOfLines = 0;
        content.textAlignment = NSTextAlignmentCenter;
        _alertContent = content;
        
        _gifImageView = [[UIImageView alloc]init];
        NSString * filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"loadGifWithoutBackground" ofType:@"gif"];
        _gifImageView.backgroundColor = Color5;
        NSData * imageData = [NSData dataWithContentsOfFile:filePath];
        _gifImageView.image = [UIImage sd_animatedGIFWithData:imageData];
        _gifImageView.layer.cornerRadius = 20.0;
        _gifImageView.layer.masksToBounds = YES;
        
        
        [self addSubview:self.backView];
        //[self.backView.contentView addSubview:alert];
        [self.backView addSubview:_gifImageView];
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
    //self.alertFrame.frame = CGRectMake(0.1 * width, 0.2 * height, width * 0.8, 0.3 * height);
    
    self.alertContent.frame = CGRectMake(5, 10, alertWidth - 10, alertHeight / 3 + 30);
    _gifImageView.frame = CGRectMake(width / 2 - LOADWIDTH / 2, height / 2 - LOADWIDTH / 2, LOADWIDTH, LOADWIDTH);
    
}


@end
