//
//  UITextField+QQ.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UITextField+QQ.h"
#import <objc/message.h>

@implementation UITextField (QQ)

+ (void)load{
    
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method qq_setPlaceholderMethod = class_getInstanceMethod(self, @selector(qq_setPlaceholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, qq_setPlaceholderMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)qq_setPlaceholder:(NSString *)placeholder {
//    self.placeholder = placeholder;
    [self qq_setPlaceholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

@end
