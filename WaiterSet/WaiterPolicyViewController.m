//
//  WaiterPolicyViewController.m
//  waiter
//
//  Created by renxin on 2019/4/11.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "WaiterPolicyViewController.h"
#import "MyUtils.h"
#import <WebKit/WebKit.h>
#import "MyUtils.h"
#import "header.h"

@interface WaiterPolicyViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) WKWebView * webView;
@property(nonatomic, strong) UIProgressView * progressView;

@end

@implementation WaiterPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [MyUtils GETCurrentLangeStrWithKey:@"Setting_Policy"];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    //设置参数
    NSLog(@"appear");
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)initUI{
    float sch = SCREENHEIGHT;
    float top = TOPOFFSET;
    float mainHeight = sch - top;
    WKWebView * webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, TOPOFFSET, SCREENWIDTH, mainHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://reg.scan-bee.com/privacy_agreement.html"]]];
    webView.allowsBackForwardNavigationGestures = NO;//左滑确认
    webView.UIDelegate = self;
    //在这个代理相应的协议方法可以监听加载网页的周期和结果
    webView.navigationDelegate = self;
    [webView addObserver:self
              forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                 options:0
                 context:nil];
    self.webView = webView;
    [self.view addSubview:webView];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,1, self.view.frame.size.width, 2)];
    self.progressView.tintColor = [UIColor blueColor];
    self.progressView.trackTintColor = [UIColor clearColor];
    [self.view addSubview:self.progressView];
}



- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.webView) {
        
        NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
        
        self.progressView.progress = _webView.estimatedProgress;
        
        if (self.webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
        
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString * url = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    NSLog(@"hahahahhhhhh//url:%@",url);
    
    if ([navigationAction.request.URL.absoluteString containsString:@"type=1&result=0"]) {
        NSLog(@"我要跳转了");
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
@end
