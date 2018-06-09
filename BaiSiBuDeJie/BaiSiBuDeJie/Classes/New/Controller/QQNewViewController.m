//
//  QQNewViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQNewViewController.h"
#import "QQSubTagViewController.h"

@interface QQNewViewController ()

@end

@implementation QQNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setupNav];
}

#pragma mark - setupNav
- (void)setupNav {
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qq_nav_title"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qq_itemWithImageName:@"MainTagSubIcon" target:self action:@selector(subscribe)];
}

#pragma mark - Event Response
- (void)subscribe {
    
    QQSubTagViewController *vc = [[QQSubTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
