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
 @return 文件夹尺寸
 */
+ (NSInteger)getFileSize:(NSString *)directoryPath;


/**
 删除文件夹下所有文件

 @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryAtPath:(NSString *)directoryPath;

@end
