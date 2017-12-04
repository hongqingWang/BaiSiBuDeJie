//
//  QQTabBar.m
//  BaiSiBuDeJie
//
//  Created by Mac on 04/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQTabBar.h"

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
}

@end
