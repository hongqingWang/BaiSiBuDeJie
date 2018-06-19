//
//  QQVideoViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/18.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQVideoViewController.h"

@interface QQVideoViewController ()

@end

@implementation QQVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(QQTitlesViewHeight, 0, 0, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:QQTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:QQTitlerButtonDidRepeatClickNotification object:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:QQTabBarButtonDidRepeatClickNotification object:nil];
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
    return 30;
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

@end
