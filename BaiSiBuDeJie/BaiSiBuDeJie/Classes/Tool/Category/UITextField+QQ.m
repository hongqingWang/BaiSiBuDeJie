//
//  UITextField+QQ.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UITextField+QQ.h"

@implementation UITextField (QQ)

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return nil;
}

@end
