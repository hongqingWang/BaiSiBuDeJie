//
//  QQVideo.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQVideo : NSObject

/// 视频宽度
@property (nonatomic, assign) NSInteger width;
/// 视频高度
@property (nonatomic, assign) NSInteger height;
/// 播放次数
@property (nonatomic, assign) NSInteger playcount;
/// 视频时长
@property (nonatomic, assign) NSInteger duration;
/// 缩略图数组(大图)
@property (nonatomic, strong) NSArray *thumbnail;
/// 缩略图数组(小图150x150)
@property (nonatomic, strong) NSArray *thumbnail_small;
/// 播放视频地址URL数组
@property (nonatomic, strong) NSArray *video;
/// 视频下载数组
@property (nonatomic, strong) NSArray *download;

@end
