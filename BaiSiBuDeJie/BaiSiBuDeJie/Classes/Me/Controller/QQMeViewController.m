//
//  QQMeViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQMeViewController.h"
#import "QQSettingController.h"
#import "QQSquareCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "QQSquare.h"

static NSString * const ID = @"cell";
static int const cols = 4;
static int const margin = 1;
#define itemWH (SCREEN_WIDTH - (cols - 1) * margin) / cols

@interface QQMeViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation QQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupFooterView];
    [self loadData];
}

#pragma mark - loadData
- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"square";
    para[@"c"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSArray *dictArray = responseObject[@"square_list"];
        self.squareItems = [QQSquare mj_objectArrayWithKeyValuesArray:dictArray];
        
        NSInteger count = self.squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        self.collectionView.qq_h = rows * itemWH;
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
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
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QQSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    _collectionView = collectionView;
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
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
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QQSquare *item = self.squareItems[indexPath.row];
    QQSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = item;
    return cell;
}

@end
