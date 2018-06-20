//
//  QQTopic.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQTopic : NSObject

/// 头像的图片url地址
@property (nonatomic, copy) NSString *profile_image;
/// 发帖人的昵称
@property (nonatomic, copy) NSString *name;
/// 帖子通过的时间和created_at的参数时间一致
@property (nonatomic, copy) NSString *passtime;
/// 帖子的内容
@property (nonatomic, copy) NSString *text;

/// 顶的数量
@property (nonatomic, copy) NSString *ding;
/// 踩的人数
@property (nonatomic, copy) NSString *cai;
/// 转发的数量
@property (nonatomic, copy) NSString *repost;
/// 帖子的被评论数量
@property (nonatomic, copy) NSString *comment;

@end