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
#import "QQSubTagCell.h"
#import <SVProgressHUD.h>

@interface QQSubTagViewController ()

@property (nonatomic, strong) NSArray *subTags;
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end

@implementation QQSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - LoadData
- (void)loadData {
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _manager = manager;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"tag_recommend";
    para[@"action"] = @"sub";
    para[@"c"] = @"topic";
    
    [manager GET:QQCommonURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.subTags = [QQSubTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lineColor];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQSubTagCell *cell = [QQSubTagCell subTagCellWithTableView:tableView];
    QQSubTag *subTag = _subTags[indexPath.row];
    cell.subTag = subTag;
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
