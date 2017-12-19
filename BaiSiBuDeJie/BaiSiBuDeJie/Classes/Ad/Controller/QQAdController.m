//
//  QQAdController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 14/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQAdController.h"
#import "QQAdView.h"

static NSString *const adURLString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";

@interface QQAdController ()

/// AdView
@property (nonatomic, strong) QQAdView *adView;

@end

@implementation QQAdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

#pragma mark - loadData
- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:adURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%s %@", __FUNCTION__, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%s %@", __FUNCTION__, error);
    }];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.adView];
}

#pragma mark - Getters And Setters
- (QQAdView *)adView {
    if (_adView == nil) {
        _adView = [[QQAdView alloc] init];
    }
    return _adView;
}

@end
