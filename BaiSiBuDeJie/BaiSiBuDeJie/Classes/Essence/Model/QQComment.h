//
//  QQComment.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QQUser;

@interface QQComment : NSObject

/// 评论内容
@property (nonatomic, copy) NSString *content;
/// 个人信息
@property (nonatomic, strong) QQUser *u;

@end
