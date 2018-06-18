//
//  UITextField+QQ.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (QQ)

@property (nonatomic, strong) UIColor *placeholderColor;

- (void)qq_setPlaceholder:(NSString *)placeholder;

@end
