//
//  QQTabBar.m
//  BaiSiBuDeJie
//
//  Created by Mac on 04/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQTabBar.h"

@interface QQTabBar ()

/// 加号按钮
@property (nonatomic, strong) UIButton *plusButton;

@end

@implementation QQTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.items.count + 1;
    
    CGFloat buttonW = self.bounds.size.width / count;
    CGFloat buttonH = self.bounds.size.height;
    CGFloat buttonX = 0;
    
    NSInteger i = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            buttonX = i * buttonW;
            tabBarButton.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
            i++;
        }
    }
    [self addSubview:self.plusButton];
    self.plusButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

#pragma mark - Getters and Setters
- (UIButton *)plusButton {
    if (_plusButton == nil) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish"] forState:UIControlStateNormal];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_selected"] forState:UIControlStateHighlighted];
        [_plusButton sizeToFit];
    }
    return _plusButton;
}

@end