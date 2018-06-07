//
//  QQAdController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 14/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQAdController.h"
#import "QQAdView.h"
#import "QQAd.h"
#import "QQTabBarController.h"

static NSString *const adURLString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";

@interface QQAdController ()<QQAdViewDelegete>

/// AdView
@property (nonatomic, strong) QQAdView *adView;
/// Timer
@property (nonatomic, weak) NSTimer *timer;
/// Ad
@property (nonatomic, strong) QQAd *ad;
/// JumpButton
@property (nonatomic, strong) UIButton *jumpButton;

@end

@implementation QQAdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

#pragma mark - Event Response
- (void)timeChange {
    
    static int i = 3;
    
    if (i == 0) {
        
        [self adView:nil jumpAd:nil];
    }
    
    i--;
    
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过(%d)", i] forState:UIControlStateNormal];
}

#pragma mark - loadData
- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:adURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *adArray = [responseObject[@"T1348647853363"] firstObject][@"ads"];
        NSDictionary *adDict = [adArray firstObject];
        
        self.ad = [QQAd mj_objectWithKeyValues:adDict];
        self.ad.imgsrc = @"https://upload-images.jianshu.io/upload_images/2069062-c7a2a34a7e2139a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
        self.adView.ad = self.ad;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%s %@", __FUNCTION__, error);
    }];
}

#pragma mark - QQAdViewDelegete
- (void)adView:(QQAdView *)adView tapAdImageView:(UITapGestureRecognizer *)tap {
    
    int i = arc4random_uniform(4);
    
    if (i == 0) {
        self.ad.url = @"https://www.jianshu.com/u/1ab0fcff23e7";
    } else if (i == 1) {
        self.ad.url = @"https://github.com/hongqingWang";
    } else if (i == 2) {
        self.ad.url = @"https://juejin.im/user/5954542d6fb9a06ba6462edc/posts";
    } else {
        self.ad.url = @"https://cloud.tencent.com/developer/user/1890628";
    }
    
    NSURL *url = [NSURL URLWithString:self.ad.url];
    UIApplication *application = [UIApplication sharedApplication];

    if ([application canOpenURL:url]) {
        [application openURL:url];
    }
}

- (void)adView:(QQAdView *)adView jumpAd:(UIButton *)button {
    
    QQTabBarController *tabBarController = [[QQTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
    [self.timer invalidate];
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
        _adView.delegate = self;
        self.jumpButton = _adView.jumpButton;
    }
    return _adView;
}

@end
