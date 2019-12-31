//
//  QYZJRuZhuXieYiVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRuZhuXieYiVC.h"

@interface QYZJRuZhuXieYiVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation QYZJRuZhuXieYiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [SVProgressHUD show];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"xieyi" ofType:@".html"];
    
    [self.web loadHTMLString:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    
    self.web.delegate = self;
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

@end
