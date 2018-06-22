//
//  QQGif.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQGif : NSObject

/// gif宽度
@property (nonatomic, assign) NSInteger width;
/// gif高度
@property (nonatomic, assign) NSInteger height;
/// gif图数组
@property (nonatomic, strong) NSArray *images;
/// gif缩略图数组
@property (nonatomic, strong) NSArray *gif_thumbnail;
/// gif下载链接数组
@property (nonatomic, strong) NSArray *download_url;

@end
