//
//  QQTopic.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, QQTopicType) {
    QQTopicTypeAll = 1,         // 全部
    QQTopicTypePicture = 10,    // 图片
    QQTopicTypeWord = 29,       // 段子
    QQTopicTypeVoice = 31,      // 音频
    QQTopicTypeVideo = 41       // 视频
};

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
@property (nonatomic, assign) NSUInteger ding;
/// 踩的人数
@property (nonatomic, assign) NSUInteger cai;
/// 转发的数量
@property (nonatomic, assign) NSUInteger repost;
/// 帖子的被评论数量
@property (nonatomic, assign) NSUInteger comment;

/// 帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频
@property (nonatomic, assign) NSInteger type;

@end
