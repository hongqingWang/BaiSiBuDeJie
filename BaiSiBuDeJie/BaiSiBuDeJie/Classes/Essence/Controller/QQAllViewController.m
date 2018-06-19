//
//  QQAllViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/18.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQAllViewController.h"

@interface QQAllViewController ()

@property (nonatomic, weak) UIView *footerView;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@property (nonatomic, assign) NSInteger dataCount;

@end

@implementation QQAllViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 10;
    
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.tableView.contentSize.height == 0) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom + self.tabBarController.tabBar.qq_h - self.tableView.qq_h;
    
    if (self.isFooterRefreshing) return;
    
    if (self.tableView.contentOffset.y >= offsetY) {
        
        self.footerRefreshing = YES;
        self.footerView.backgroundColor = [UIColor blueColor];
        self.footerLabel.text = @"正在加载更多数据...";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            self.dataCount += 5;
            [self.tableView reloadData];

            self.footerRefreshing = NO;
            self.footerView.backgroundColor = [UIColor redColor];
            self.footerLabel.text = @"上拉加载更多";
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
