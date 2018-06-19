//
//  QQAllViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/18.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQAllViewController.h"

@interface QQAllViewController ()

@property (nonatomic, weak) UIView *header;
@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

@property (nonatomic, weak) UIView *footerView;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@property (nonatomic, assign) NSInteger dataCount;

@end

@implementation QQAllViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 3;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        self.dataCount = 4;
//        [self.tableView reloadData];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            self.dataCount = 0;
//            [self.tableView reloadData];
//        });
//    });
    
    self.tableView.contentInset = UIEdgeInsetsMake(QQTitlesViewHeight, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:QQTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:QQTitlerButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:QQTabBarButtonDidRepeatClickNotification object:nil];
}

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
    
    NSLog(@"%@ - 刷新", self);
}

- (void)titleButtonRepeatClick {
    
    [self tabBarButtonRepeatClick];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.footerView.hidden = (self.dataCount == 0);
    return self.dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld", self.class, indexPath.row];
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self dealHeader];
    [self dealFooter];
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
    
    self.headerLabel.text = @"正在刷新数据...";
    self.header.backgroundColor = [UIColor blueColor];
    self.headerRefreshing = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.qq_h;
        self.tableView.contentInset = inset;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.dataCount = 20;
        [self.tableView reloadData];
        
        [self headerEndRefreshing];
    });
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
    
    self.footerRefreshing = YES;
    self.footerView.backgroundColor = [UIColor blueColor];
    self.footerLabel.text = @"正在加载更多数据...";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.dataCount += 5;
        [self.tableView reloadData];
        
        [self footerEndRefreshing];
    });
}

- (void)footerEndRefreshing {
    
    self.footerRefreshing = NO;
    self.footerView.backgroundColor = [UIColor redColor];
    self.footerLabel.text = @"上拉加载更多";
}

@end
