//
//  QQTopicViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopicViewController.h"
#import "QQHTTPSessionManger.h"
#import "QQTopic.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "QQTopicCell.h"
#import "QQRefreshHeader.h"
//#import "QQDIYHeader.h"

@interface QQTopicViewController ()

@property (nonatomic, strong) NSMutableArray<QQTopic *> *topics;
/// 第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxid”中的内容。
@property (nonatomic, assign) NSInteger maxid;

@end

@implementation QQTopicViewController

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

- (NSString *)urlString {
    return nil;
}

#pragma mark - LoadData
- (void)loadNewTopics {
    
    QQHTTPSessionManger *manager = [QQHTTPSessionManger manager];
    
    /*
     http://api.budejie.com/api/api_open.php
     http://api.budejie.com/api/api_open.php?a=list&c=data&type=1
     
     --- 新版百思不得姐API ---
     
     0.每次从后台回到app中调用的方法
     
     http://api.budejie.com/api/api_open.php?a=user_login_report&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&c=user&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529457024&udid=&ver=4.5.9
     
     http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.9/0-20.json <1529558941><4833>
     http://d.api.budejie.com/topic/Topic/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568150&udid=&ver=4.5.9 <1523539801><30>
     http://d.api.budejie.com/topic/Topic/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568209&udid=&ver=4.5.9 <1526637001><30>
     http://d.api.budejie.com/topic/Topic/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568239&udid=&ver=4.5.9 <1524235802><30>
     http://d.api.budejie.com/topic/Topic/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568264&udid=&ver=4.5.9 <1523799055><30>
     
     隔了大约5分钟
     
     http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.9/0-20.json <1529559901><4836>
     
     再快速刷新
     
     http://d.api.budejie.com/topic/Topic/bs0315-iphone-4.5.9/0-30.json?openudid=5704d313c8474093176a4a702aace6c88fdd5287&appname=bs0315&asid=1A454B88-A199-44C7-A464-0AA026DAE934&client=iphone&device=iPhone%205s%20%28GSM%2BCDMA%29&from=ios&jbk=1&market=&openudid=5704d313c8474093176a4a702aace6c88fdd5287&t=1529568868&udid=&ver=4.5.9 <1526190242><30>
     */
    
    self.maxid = 0;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%ld-20.json", [self urlString], self.maxid];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        //        NSLog(@"%@", responseObject);
//        QQAFNWriteToPlist(aaa.plist)
        self.topics = [QQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxid = [responseObject[@"info"][@"np"] integerValue];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试!"];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%ld-20.json", [self urlString], self.maxid];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        NSMutableArray *moreTopics = [QQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        self.maxid = [responseObject[@"info"][@"np"] integerValue];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试!"];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Refresh
- (void)setupRefresh {
    
    self.tableView.mj_header = [QQRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
//    self.tableView.mj_header = [QQDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    UILabel *adLabel = [[UILabel alloc] init];
    adLabel.backgroundColor = [UIColor blackColor];
    adLabel.text = @"广告";
    adLabel.textColor = [UIColor whiteColor];
    adLabel.textAlignment = NSTextAlignmentCenter;
    adLabel.frame = CGRectMake(0, 0, self.tableView.qq_w, 30);
    self.tableView.tableHeaderView = adLabel;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - Event Response
- (void)tabBarButtonRepeatClick {
    
    if (self.view.window == nil) {
        return;
    }
    
    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)titleButtonRepeatClick {
    
    [self tabBarButtonRepeatClick];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
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
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
