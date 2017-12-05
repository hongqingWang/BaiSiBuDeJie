//
//  UIView+QQ.m
//  QQLive
//
//  Created by Mac on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+QQ.h"

@implementation UIView (QQ)

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    
    return self.frame.origin.x;
}

- (void)setW:(CGFloat)w {
    
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (CGFloat)w {
    
    return self.frame.size.width;
}

- (void)setH:(CGFloat)h {
    
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

- (CGFloat)h {
    
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    
    return self.frame.size;
}

@end
