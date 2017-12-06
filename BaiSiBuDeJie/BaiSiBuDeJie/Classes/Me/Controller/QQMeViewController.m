//
//  QQMeViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQMeViewController.h"
#import "QQSettingController.h"

@interface QQMeViewController ()

@end

@implementation QQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self setupNav];
}

#pragma mark - setupNav
- (void)setupNav {
    
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_setting" target:self action:@selector(setting)];
    UIBarButtonItem *nightItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_moon" selectedImageName:@"qq_nav_moon_selected" target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
}

#pragma mark - Event Response
- (void)setting {
    
    QQSettingController *vc = [[QQSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)night:(UIButton *)button {
    
    button.selected = !button.selected;
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
