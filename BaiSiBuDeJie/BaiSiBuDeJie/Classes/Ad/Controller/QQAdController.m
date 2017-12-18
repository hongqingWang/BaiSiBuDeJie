//
//  QQAdController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 14/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQAdController.h"
#import "QQAdView.h"

@interface QQAdController ()

/// AdView
@property (nonatomic, strong) QQAdView *adView;

@end

@implementation QQAdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
