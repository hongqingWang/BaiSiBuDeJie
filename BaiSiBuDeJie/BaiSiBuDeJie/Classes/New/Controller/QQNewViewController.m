//
//  QQNewViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQNewViewController.h"

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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_sub" target:self action:@selector(subscribe)];
}

#pragma mark - Event Response
- (void)subscribe {
    
    NSLog(@"%s", __FUNCTION__);
}

@end
