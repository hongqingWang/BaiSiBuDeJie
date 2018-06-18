//
//  QQFileTool.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/18.
//  Copyright © 2018年 Mac. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>

@interface QQFileTool : NSObject

/**
 获取文件夹尺寸

 @param directoryPath 文件夹路径
 @param completion 回调文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void (^)(NSInteger totalSize))completion;

/**
 删除文件夹下所有文件

 @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryAtPath:(NSString *)directoryPath;

@end
