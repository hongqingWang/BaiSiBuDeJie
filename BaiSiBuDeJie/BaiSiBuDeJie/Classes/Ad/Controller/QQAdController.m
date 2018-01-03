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

@interface QQAdController ()

/// AdView
@property (nonatomic, strong) QQAdView *adView;
/// Timer
@property (nonatomic, weak) NSTimer *timer;
/// Ad
//@property (nonatomic, strong) QQAd *ad;

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
    NSLog(@"Aaaa");
    static int i = 3;
    
    if (i == 0) {
        
        QQTabBarController *tabBarVc = [[QQTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
        [self.timer invalidate];
    }
    
    i--;
}

#pragma mark - loadData
- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:adURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *adArray = [responseObject[@"T1348647853363"] firstObject][@"ads"];
        NSDictionary *adDict = [adArray firstObject];
        
        QQAd *ad = [QQAd mj_objectWithKeyValues:adDict];
//        ad.imgsrc = @"http://d.paper.i4.cn/max/2017/04/17/15/1492414647016_163870.jpg";
        ad.imgsrc = @"http://upload-images.jianshu.io/upload_images/2069062-41ec389fa17b3ee6.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
        
        self.adView.ad = ad;
        
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
