//
//  QQSubTagViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/7.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQSubTagViewController.h"
#import <AFNetworking.h>
#import "QQSubTag.h"

@interface QQSubTagViewController ()

@property (nonatomic, strong) NSArray *subTags;

@end

@implementation QQSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

#pragma mark - LoadData
- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"tag_recommend";
    para[@"action"] = @"sub";
    para[@"c"] = @"topic";
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        _subTags = [QQSubTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    QQSubTag *tag = _subTags[indexPath.row];
    cell.textLabel.text = tag.theme_name;
    
    return cell;
}

@end
