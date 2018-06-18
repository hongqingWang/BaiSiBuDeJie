//
//  QQSettingController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 06/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQSettingController.h"
#import "QQFileTool.h"
#import <SVProgressHUD.h>

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface QQSettingController ()

@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation QQSettingController

static NSString *const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存..."];
    [QQFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        self.totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
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
    
    [QQFileTool removeDirectoryAtPath:CachePath];
    self.totalSize = 0;
    [self.tableView reloadData];
}

- (NSString *)sizeString {
    
    NSString *sizeString = @"清除缓存";
    NSInteger totalSize = self.totalSize;
    
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
