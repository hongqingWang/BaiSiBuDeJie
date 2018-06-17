//
//  QQSettingController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 06/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQSettingController.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface QQSettingController ()

@end

@implementation QQSettingController

static NSString *const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - getFileSize
- (NSInteger)getFileSize:(NSString *)directoryPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
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

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = [self sizeString];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    NSArray *pathArray = [fileManeger contentsOfDirectoryAtPath:CachePath error:nil];
    
    for (NSString *path in pathArray) {
        NSString *filePath = [CachePath stringByAppendingPathComponent:path];
        [fileManeger removeItemAtPath:filePath error:nil];
    }
    [self.tableView reloadData];
}

- (NSString *)sizeString {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *sizeString = @"清除缓存";
    
    NSInteger totalSize = [self getFileSize:cachePath];
    
    if (totalSize > 1000 * 1000) {
        CGFloat sizeFloat = totalSize / 1000.0 / 1000.0;
        sizeString = [NSString stringWithFormat:@"%@(%.1fMB)", sizeString, sizeFloat];
    } else if (totalSize > 1000) {
        CGFloat sizeFloat = totalSize / 1000.0;
        sizeString = [NSString stringWithFormat:@"%@(%.1fKB)", sizeString, sizeFloat];
    } else if (totalSize > 0) {
        sizeString = [NSString stringWithFormat:@"%@(%ldB)", sizeString, totalSize];
    }
    
    return sizeString;
}

@end
