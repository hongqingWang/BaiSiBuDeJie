//
//  QQFileTool.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/18.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQFileTool.h"

@implementation QQFileTool

+ (NSInteger)getFileSize:(NSString *)directoryPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"请传入有效的文件夹路径!!!" userInfo:nil];
        [exception raise];
    }
    
    NSArray *subPathArray = [fileManager subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    
    for (NSString *path in subPathArray) {
        
        NSString *filePath = [directoryPath stringByAppendingPathComponent:path];
        
        if ([filePath containsString:@".DS"]) {
            continue;
        }
        
        BOOL isDirectory;
        BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) {
            continue;
        }
        
        NSDictionary *attrs = [fileManager attributesOfItemAtPath:filePath error:nil];
        NSInteger fileSize = [attrs fileSize];
        
        totalSize += fileSize;
    }
    return totalSize;
}

+ (void)removeDirectoryAtPath:(NSString *)directoryPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"请传入有效的文件夹路径!!!" userInfo:nil];
        [exception raise];
    }
    
    NSArray *pathArray = [fileManager contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *path in pathArray) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:path];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

@end
