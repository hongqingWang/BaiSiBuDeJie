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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwordItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadItem;
@property (weak, nonatomic) IBOutlet UIProgressView *processView;

@end

@implementation QQWebViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] init];
    _webView = webView;
    [self.contentView addSubview:_webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _webView.frame = self.contentView.bounds;
}

- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    self.backItem.enabled = self.webView.canGoBack;
    self.forwordItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.processView.progress = self.webView.estimatedProgress;
    self.processView.hidden = self.webView.estimatedProgress >= 1;
}

#pragma mark - Event Response
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)forword:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (IBAction)reload:(UIBarButtonItem *)sender {
    [self.webView reload];
}

@end
