//
//  QQWebViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQWebViewController.h"
#import <WebKit/WebKit.h>

@interface QQWebViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
/// WebView
@property (nonatomic, weak) WKWebView *webView;

@end

@implementation QQWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] init];
    _webView = webView;
    [self.contentView addSubview:_webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%@", NSStringFromCGRect(self.contentView.bounds));
    _webView.frame = self.contentView.bounds;
}

@end
