//
//  QYZJRuZhuXieYiVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRuZhuXieYiVC.h"

@interface QYZJRuZhuXieYiVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation QYZJRuZhuXieYiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [SVProgressHUD show];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"xieyi" ofType:@".html"];
    
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    
    self.webView.delegate = self;
    self.webView.userInteractionEnabled = YES;
    self.view.backgroundColor = WhiteColor;
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    
    // 禁止用户复制粘贴
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect=’none’;"];
    // 禁止用户拨打电话
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout=’none’;"];
    
}

@end
