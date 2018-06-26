//
//  QQRecommendViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQRecommendViewController.h"
#import <AFNetworking.h>
#import "QQTopic.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "QQTopicCell.h"

@interface QQRecommendViewController ()

@property (nonatomic, weak) UIView *header;
@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

@property (nonatomic, weak) UIView *footerView;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;

@property (nonatomic, strong) NSMutableArray<QQTopic *> *topics;
/// 第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxid”中的内容。
@property (nonatomic, assign) NSInteger maxid;

@end

@implementation QQRecommendViewController

static NSString * const QQTopicCellId = @"QQTopicCellId";

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(QQTitlesViewHeight, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([QQTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:QQTopicCellId];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:QQTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:QQTitlerButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:QQTabBarButtonDidRepeatClickNotification object:nil];
}

#pragma mark - LoadData
- (void)loadNewTopics {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /*
     http://api.budejie.com/api/api_open.php
     http://api.budejie.com/api/api_open.php?a=list&c=data&type=1
     
     --- 新版百思不得姐API ---
     
     0.每次从后台回到app中调用的方法
     
     http://api.budejie.com/api/api_open.php?a=user_login_report&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&c=user&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529457024&udid=&ver=4.5.9
     
     http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.9/0-20.json <1529558941><4833>
     http://d.api.budejie.com/topic/recommend/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568150&udid=&ver=4.5.9 <1523539801><30>
     http://d.api.budejie.com/topic/recommend/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568209&udid=&ver=4.5.9 <1526637001><30>
     http://d.api.budejie.com/topic/recommend/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568239&udid=&ver=4.5.9 <1524235802><30>
     http://d.api.budejie.com/topic/recommend/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568264&udid=&ver=4.5.9 <1523799055><30>
     
     隔了大约5分钟
     
     http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.9/0-20.json <1529559901><4836>
     
     再快速刷新
     
     http://d.api.budejie.com/topic/recommend/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568868&udid=&ver=4.5.9 <1526190242><30>
     
     4.笑话
     http://s.budejie.com/topic/tag-topic/63674/hot/bs0315-iphone-4.5.9/0-20.json           <1529555904><1000>
     http://s.budejie.com/topic/tag-topic/63674/hot/bs0315-iphone-4.5.9/1529555904-20.json  <1529547671><1000>
     http://s.budejie.com/topic/tag-topic/63674/hot/bs0315-iphone-4.5.9/1529547671-20.json  <1529544651><1000>
     
     5.排行
     http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.5.9/0-20.json                  <1526270581><182>
     http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.5.9/1526270581-20.json         <1524982321><182>
     http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.5.9/1524982321-20.json         <1524266822><182>
     
     */
    
    self.maxid = 0;
//    QQImageURL
    [manager GET:QQRecommandURL(self.maxid) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
        QQAFNWriteToPlist(aaa.plist)
        self.topics = [QQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxid = [responseObject[@"info"][@"np"] integerValue];
        [self.tableView reloadData];
        [self headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试!"];
        [self headerEndRefreshing];
    }];
}

- (void)loadMoreTopics {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:QQRecommandURL(self.maxid) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        NSMutableArray *moreTopics = [QQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        self.maxid = [responseObject[@"info"][@"np"] integerValue];
        
        [self.tableView reloadData];
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试!"];
        [self footerEndRefreshing];
    }];
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
    
    [self headerBeginRefreshing];
    
    UILabel *adLabel = [[UILabel alloc] init];
    adLabel.backgroundColor = [UIColor blackColor];
    adLabel.text = @"广告";
    adLabel.textColor = [UIColor whiteColor];
    adLabel.textAlignment = NSTextAlignmentCenter;
    adLabel.frame = CGRectMake(0, 0, self.tableView.qq_w, 30);
    self.tableView.tableHeaderView = adLabel;
    
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

#pragma mark - Event Response
- (void)tabBarButtonRepeatClick {
    
    if (self.view.window == nil) {
        return;
    }
    
    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    
    [self headerBeginRefreshing];
}

- (void)titleButtonRepeatClick {
    
    [self tabBarButtonRepeatClick];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.footerView.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQTopic *topic = self.topics[indexPath.row];
    QQTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:QQTopicCellId];
    cell.topic = topic;
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.topics[indexPath.row].cellHeight;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 200;
//}

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
    
    [self loadNewTopics];
}

- (void)headerEndRefreshing {
    
    self.headerRefreshing = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.qq_h;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark - footer
- (void)footerBeginRefreshing {
    
    if (self.isFooterRefreshing) return;
    if (self.isHeaderRefreshing) return;
    
    self.footerRefreshing = YES;
    self.footerView.backgroundColor = [UIColor blueColor];
    self.footerLabel.text = @"正在加载更多数据...";
    
    [self loadMoreTopics];
}

- (void)footerEndRefreshing {
    
    self.footerRefreshing = NO;
    self.footerView.backgroundColor = [UIColor redColor];
    self.footerLabel.text = @"上拉加载更多";
}

#pragma mark - Getters And Setters

@end
