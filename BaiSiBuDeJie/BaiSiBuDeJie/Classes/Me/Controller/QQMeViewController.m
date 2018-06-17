//
//  QQMeViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQMeViewController.h"
#import "QQSettingController.h"

static NSString * const ID = @"cell";

@interface QQMeViewController ()<UICollectionViewDataSource>

@end

@implementation QQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupFooterView];
}

#pragma mark - setupNav
- (void)setupNav {
    
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_setting" target:self action:@selector(setting)];
    UIBarButtonItem *nightItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_moon" selectedImageName:@"qq_nav_moon_selected" target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
}

#pragma mark - setupFooterView
- (void)setupFooterView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor randomColor];
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    self.tableView.tableFooterView = collectionView;
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

@end
