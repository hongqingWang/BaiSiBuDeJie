
//
//  QQFriendTrendViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQFriendTrendViewController.h"
#import "QQLoginViewController.h"
#import "UITextField+QQ.h"

@interface QQFriendTrendViewController ()

@end

@implementation QQFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}

#pragma mark - setupNav
- (void)setupNav {
    
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_recomment" target:self action:@selector(recomment)];
}

#pragma mark - Event Response
- (void)recomment {
    
    NSLog(@"%s", __FUNCTION__);
}

- (IBAction)clickLoginAndRegister:(UIButton *)sender {
    
    QQLoginViewController *vc = [[QQLoginViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
