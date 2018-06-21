//
//  UIView+QQ.m
//  QQLive
//
//  Created by Mac on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+QQ.h"

@implementation UIView (QQ)

- (void)setQq_x:(CGFloat)qq_x {
    
    CGRect frame = self.frame;
    frame.origin.x = qq_x;
    self.frame = frame;
}

- (CGFloat)qq_x {
    
    return self.frame.origin.x;
}

- (void)setQq_y:(CGFloat)qq_y {
    
    CGRect frame = self.frame;
    frame.origin.y = qq_y;
    self.frame = frame;
}

- (CGFloat)qq_y {
    
    return self.frame.origin.x;
}

- (void)setQq_w:(CGFloat)qq_w {
    
    CGRect frame = self.frame;
    frame.size.width = qq_w;
    self.frame = frame;
}

- (CGFloat)qq_w {
    
    return self.frame.size.width;
}

- (void)setQq_h:(CGFloat)qq_h {
    
    CGRect frame = self.frame;
    frame.size.height = qq_h;
    self.frame = frame;
}

- (CGFloat)qq_h {
    
    return self.frame.size.height;
}

- (void)setQq_centerX:(CGFloat)qq_centerX {
    
    CGPoint center = self.center;
    center.x = qq_centerX;
    self.center = center;
}

- (CGFloat)qq_centerX {
    
    return self.center.x;
}

- (void)setQq_centerY:(CGFloat)qq_centerY {
    
    CGPoint center = self.center;
    center.y = qq_centerY;
    self.center = center;
}

- (CGFloat)qq_centerY {
    
    return self.center.y;
}

- (void)setQq_size:(CGSize)qq_size {
    
    CGRect frame = self.frame;
    frame.size = qq_size;
    self.frame = frame;
}

- (CGSize)qq_size {
    
    return self.frame.size;
}

+ (instancetype)qq_viewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
