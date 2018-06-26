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

@property (nonatomic, weak) UIView *header;
@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

@property (nonatomic, weak) UIView *footerView;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;

@end

@implementation QQSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    
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

#pragma mark - Refresh
- (void)setupRefresh {
    
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor redColor];
    header.frame = CGRectMake(0, -50, self.tableView.qq_w, 50);
    [self.tableView addSubview:header];
    self.header = header;
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.frame = header.bounds;
    [header addSubview:headerLabel];
    self.headerLabel = headerLabel;
    
//    [self headerBeginRefreshing];
    
//    UILabel *adLabel = [[UILabel alloc] init];
//    adLabel.backgroundColor = [UIColor blackColor];
//    adLabel.text = @"广告";
//    adLabel.textColor = [UIColor whiteColor];
//    adLabel.textAlignment = NSTextAlignmentCenter;
//    adLabel.frame = CGRectMake(0, 0, self.tableView.qq_w, 30);
//    self.tableView.tableHeaderView = adLabel;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor redColor];
    footerView.frame = CGRectMake(0, 0, self.tableView.qq_w, 35);
    self.footerView = footerView;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.text = @"上拉加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.frame = footerView.bounds;
    [footerView addSubview:footerLabel];
    self.footerLabel = footerLabel;
    
    self.tableView.tableFooterView = footerView;
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

#pragma mark - header
- (void)headerBeginRefreshing {
    
    if (self.isHeaderRefreshing) return;
    if (self.isFooterRefreshing) return;
    
    self.headerLabel.text = @"正在刷新数据...";
    self.header.backgroundColor = [UIColor blueColor];
    self.headerRefreshing = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.qq_h;
        self.tableView.contentInset = inset;
        
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -(inset.top + QQNavigationMaxY));
    }];
    
//    [self loadNewTopics];
    NSLog(@"加载新数据");
}

- (void)headerEndRefreshing {
    
    self.headerRefreshing = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.qq_h;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self dealHeader];
    [self dealFooter];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat offsetY = - (self.tableView.contentInset.top + QQNavigationMaxY + self.header.qq_h);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        
        [self headerBeginRefreshing];
    }
}

- (void)dealHeader {
    
    if (self.isHeaderRefreshing) return;
    
    CGFloat offsetY = - (self.tableView.contentInset.top + QQNavigationMaxY + self.header.qq_h);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        self.header.backgroundColor = [UIColor lightGrayColor];
        self.headerLabel.text = @"松开立即刷新";
    } else {
        self.header.backgroundColor = [UIColor redColor];
        self.headerLabel.text = @"下拉可以刷新";
    }
}

- (void)dealFooter {
    
    if (self.tableView.contentSize.height == 0) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom + self.tabBarController.tabBar.qq_h - self.tableView.qq_h;
    
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top + QQNavigationMaxY)) {
        
        [self footerBeginRefreshing];
    }
}

#pragma mark - footer
- (void)footerBeginRefreshing {
    
    if (self.isFooterRefreshing) return;
    if (self.isHeaderRefreshing) return;
    
    self.footerRefreshing = YES;
    self.footerView.backgroundColor = [UIColor blueColor];
    self.footerLabel.text = @"正在加载更多数据...";
    
//    [self loadMoreTopics];
    NSLog(@"加载更多数据");
}

- (void)footerEndRefreshing {
    
    self.footerRefreshing = NO;
    self.footerView.backgroundColor = [UIColor redColor];
    self.footerLabel.text = @"上拉加载更多";
}

@end
