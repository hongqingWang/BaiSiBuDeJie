//
//  QQEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQEssenceViewController.h"

@interface QQEssenceViewController ()

@end

@implementation QQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    [self setupNav];
}

#pragma mark - setupNav
- (void)setupNav {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"qq_nav_item_game"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"qq_nav_item_game_highlighted"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - Event Response
- (void)game {
    
    NSLog(@"%s", __FUNCTION__);
}

@end
