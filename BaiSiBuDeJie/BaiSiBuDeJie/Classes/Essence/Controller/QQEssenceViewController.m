//
//  QQEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQEssenceViewController.h"

@interface QQEssenceViewController ()

/// 标题栏
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation QQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupScrollView];
    [self setupTitlesView];
}

- (void)setupScrollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor randomColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
}

- (void)setupTitlesView {
    
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.qq_w, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    [self setupTitleButton];
    [self setupTitleUnderline];
}

- (void)setupTitleButton {
    
    NSInteger titleButtonCount = 5;
    CGFloat titleButtonW = self.titlesView.qq_w / titleButtonCount;
    CGFloat titleButtonH = self.titlesView.qq_h;
    
    for (int i = 0; i < titleButtonCount; i++) {
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.frame = CGRectMake(titleButtonW * i, 0, titleButtonW, titleButtonH);
        titleButton.backgroundColor = [UIColor randomColor];
        [self.titlesView addSubview:titleButton];
    }
}

- (void)setupTitleUnderline {
    
    
}

#pragma mark - setupNav
- (void)setupNav {
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qq_nav_title"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_item_game" target:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qq_itemWithImageName:@"qq_nav_item_random" target:self action:@selector(random)];
}

#pragma mark - Event Response
- (void)game {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)random {
    
    NSLog(@"%s", __FUNCTION__);
}

@end
