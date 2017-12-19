//
//  QQAdView.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 18/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQAdView.h"

@interface QQAdView ()

/// BackgroundImageView
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation QQAdView

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
}

#pragma mark - Getters And Setters
- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _backgroundImageView.image = [UIImage imageNamed:@"qq_nav_sub_highlighted"];
    }
    return _backgroundImageView;
}

@end
