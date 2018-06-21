//
//  QQUser.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQUser : NSObject

/// 昵称
@property (nonatomic, copy) NSString *name;
/// 头像数组
@property (nonatomic, strong) NSArray *header;

@end
