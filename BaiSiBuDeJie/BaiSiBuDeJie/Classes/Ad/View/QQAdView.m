//
//  QQAdView.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 18/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQAdView.h"
#import "QQAd.h"

@interface QQAdView ()

/// BackgroundImageView
@property (nonatomic, strong) UIImageView *backgroundImageView;
/// AdImageView
@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation QQAdView

- (void)setAd:(QQAd *)ad {
    _ad = ad;
    
    NSURL *url = [NSURL URLWithString:ad.imgsrc];
    [self.adImageView sd_setImageWithURL:url];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI {
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.adImageView];
    
//    self.adImageView 
}

#pragma mark - Getters And Setters
- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _backgroundImageView.image = [UIImage imageNamed:@"LaunchImage-375x667"];
    }
    return _backgroundImageView;
}

- (UIImageView *)adImageView {
    if (_adImageView == nil) {
        _adImageView = [[UIImageView alloc] init];
    }
    return _adImageView;
}

@end
