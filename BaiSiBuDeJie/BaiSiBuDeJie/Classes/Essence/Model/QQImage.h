//
//  QQImage.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQImage : NSObject

/// 图片宽度
@property (nonatomic, assign) NSInteger width;
/// 图片高度
@property (nonatomic, assign) NSInteger height;
/// 大图数组
@property (nonatomic, strong) NSArray *big;
/// 下载链接数组
@property (nonatomic, strong) NSArray *download_url;
/// 缩略图数组
@property (nonatomic, strong) NSArray *thumbnail_small;

@end
