//
//  QQTopic.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QQUser;
@class QQVideo;
@class QQImage;
@class QQGif;

typedef NS_ENUM(NSUInteger, QQTopicType) {
    QQTopicTypeAll = 1,         // 全部
    QQTopicTypePicture = 10,    // 图片
    QQTopicTypeWord = 29,       // 段子
    QQTopicTypeVoice = 31,      // 音频
    QQTopicTypeVideo = 41       // 视频
};

@interface QQTopic : NSObject

/// 个人信息
@property (nonatomic, strong) QQUser *u;
/// 视频信息
@property (nonatomic, strong) QQVideo *video;
/// 图片信息
@property (nonatomic, strong) QQImage *image;
/// gif信息
@property (nonatomic, strong) QQGif *gif;

/// 帖子通过的时间和created_at的参数时间一致
@property (nonatomic, copy) NSString *passtime;
/// 帖子的内容
@property (nonatomic, copy) NSString *text;
/// 顶的数量
@property (nonatomic, assign) NSUInteger up;
/// 踩的人数
@property (nonatomic, assign) NSUInteger down;
/// 转发的数量
@property (nonatomic, assign) NSUInteger forward;
/// 帖子的被评论数量
@property (nonatomic, assign) NSUInteger comment;

/// image gif video text
@property (nonatomic, copy) NSString *type;

/// 最热评论数组
@property (nonatomic, strong) NSArray *top_comments;

/// CellHeight
@property (nonatomic, assign) CGFloat cellHeight;
/// MiddleViewFrame
@property (nonatomic, assign) CGRect middleViewframe;

@end
