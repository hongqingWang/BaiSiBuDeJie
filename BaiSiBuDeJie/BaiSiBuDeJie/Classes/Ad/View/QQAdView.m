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
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI {
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.adImageView];
    [self addSubview:self.jumpButton];
}

#pragma mark - Event Response
- (void)tapAdImageView:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(adView:tapAdImageView:)]) {
        [self.delegate adView:self tapAdImageView:tap];
    }
}

- (void)jumpAd:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(adView:jumpAd:)]) {
        [self.delegate adView:self jumpAd:button];
    }
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
        _adImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 960 / 640);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdImageView:)];
        [_adImageView addGestureRecognizer:tap];
        _adImageView.userInteractionEnabled = YES;
    }
    return _adImageView;
}

- (UIButton *)jumpButton {
    if (_jumpButton == nil) {
        _jumpButton = [[UIButton alloc] init];
        CGFloat w = 80;
        CGFloat h = 40;
        _jumpButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - w, 20, w, h);
        [_jumpButton setTitle:@"跳过(3)" forState:UIControlStateNormal];
        _jumpButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_jumpButton setBackgroundColor:[UIColor lightGrayColor]];
        _jumpButton.layer.cornerRadius = 5;
        _jumpButton.layer.masksToBounds = YES;
        [_jumpButton addTarget:self action:@selector(jumpAd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpButton;
}

@end
