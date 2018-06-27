//
//  QQDIYHeader.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQDIYHeader.h"

@interface QQDIYHeader ()

@property (nonatomic, strong) UISwitch *mySwitch;
/// LogoImageView
@property (nonatomic, strong) UIImageView *logoImageView;

@end

@implementation QQDIYHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.mySwitch];
        [self addSubview:self.logoImageView];
    }
    return self;
}

- (void)setState:(MJRefreshState)state {
    [super setState:state];
    
    if (state == MJRefreshStateIdle) {
        [self.mySwitch setOn:NO animated:YES];
    } else if (state == MJRefreshStatePulling) {
        [self.mySwitch setOn:YES animated:YES];
    } else if (state == MJRefreshStateRefreshing) {
        [self.mySwitch setOn:YES animated:YES];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.logoImageView.qq_centerX = self.qq_w * 0.5;
    self.logoImageView.qq_y = -self.qq_h;
    
    self.mySwitch.qq_centerX = self.qq_w * 0.5;
    self.mySwitch.qq_centerY = self.qq_h * 0.5;
}

#pragma mark - Getters And Setters
- (UISwitch *)mySwitch {
    if (_mySwitch == nil) {
        _mySwitch = [[UISwitch alloc] init];
    }
    return _mySwitch;
}

- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qq_nav_title"]];
    }
    return _logoImageView;
}

@end
