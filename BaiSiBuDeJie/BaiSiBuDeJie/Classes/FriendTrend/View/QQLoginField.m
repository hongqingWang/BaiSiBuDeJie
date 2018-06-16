//
//  QQLoginField.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQLoginField.h"

@implementation QQLoginField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    [self addTarget:self action:@selector(textEditBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEditEnd) forControlEvents:UIControlEventEditingDidEnd];
}

#pragma mark - Event Response
- (void)textEditBegin {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

- (void)textEditEnd {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

@end
