//
//  QQFastButton.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQFastButton.h"

@implementation QQFastButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.qq_centerX = self.qq_w * 0.5;
    self.imageView.qq_y = 0;
    
    [self.titleLabel sizeToFit];
    
    self.titleLabel.qq_centerX = self.qq_w * 0.5;
    self.titleLabel.qq_y = self.qq_h - self.titleLabel.qq_h;
    
    NSLog(@"%f", self.titleLabel.qq_centerX);
}

@end
