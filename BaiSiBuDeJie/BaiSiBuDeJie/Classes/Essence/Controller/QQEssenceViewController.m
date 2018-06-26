//
//  QQEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQEssenceViewController.h"
#import "QQTitleButton.h"
#import "QQRecommendViewController.h"
#import "QQVideoViewController.h"
#import "QQPictureViewController.h"
#import "QQWordViewController.h"
#import "QQRankViewController.h"

@interface QQEssenceViewController ()<UIScrollViewDelegate>

/// 标题栏
@property (nonatomic, weak) UIView *titlesView;
/// ScrollView
@property (nonatomic, weak) UIScrollView *scrollView;
/// 上一次点击的按钮
@property (nonatomic, weak) QQTitleButton *previousClickedTitleButton;
/// 下划线
@property (nonatomic, weak) UIView *titleUnderline;

@end

@implementation QQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildViewControllers];
    [self setupNav];
    [self setupScrollView];
    [self setupTitlesView];
    
    [self addChildViewControllerWithIndex:0];
}

/**
 * 添加子控制器
 */
- (void)setupAllChildViewControllers {
    
    QQRecommendViewController *recommendVc = [[QQRecommendViewController alloc] init];
    recommendVc.urlString = QQRecommendURL;
    [self addChildViewController:recommendVc];
    
    QQVideoViewController *videoVc = [[QQVideoViewController alloc] init];
    videoVc.urlString = QQVideoURL;
    [self addChildViewController:videoVc];
    
    QQPictureViewController *pictureVc = [[QQPictureViewController alloc] init];
    pictureVc.urlString = QQPictureURL;
    [self addChildViewController:pictureVc];
    
    QQWordViewController *wordVc = [[QQWordViewController alloc] init];
    wordVc.urlString = QQWordURL;
    [self addChildViewController:wordVc];
    
    QQRankViewController *rankVc = [[QQRankViewController alloc] init];
    rankVc.urlString = QQRankURL;
    [self addChildViewController:rankVc];
}

- (void)setupScrollView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.qq_w;
//    CGFloat scrollViewH = scrollView.qq_h;
    
//    for (NSUInteger i = 0; i < count; i++) {
//
//        UIView *childView = self.childViewControllers[i].view;
//        childView.frame = CGRectMake(scrollViewW * i, 0, scrollViewW, scrollViewH);
//        [scrollView addSubview:childView];
//    }
    scrollView.contentSize = CGSizeMake(scrollViewW * count, 0);
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
    
    NSArray *titles = @[@"推荐", @"视频", @"图片", @"笑话", @"排行"];
    NSUInteger titleButtonCount = 5;
    CGFloat titleButtonW = self.titlesView.qq_w / titleButtonCount;
    CGFloat titleButtonH = self.titlesView.qq_h;
    
    for (NSUInteger i = 0; i < titleButtonCount; i++) {
        QQTitleButton *titleButton = [[QQTitleButton alloc] init];
        titleButton.frame = CGRectMake(titleButtonW * i, 0, titleButtonW, titleButtonH);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        titleButton.tag = i;
    }
}

- (void)setupTitleUnderline {
    
    QQTitleButton *firstButton = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.qq_h = 2;
    titleUnderline.qq_y = self.titlesView.qq_h - titleUnderline.qq_h;
    titleUnderline.qq_w = 70;
    titleUnderline.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    firstButton.selected = YES;
    self.previousClickedTitleButton = firstButton;
    [firstButton.titleLabel sizeToFit];
    self.titleUnderline.qq_w = firstButton.titleLabel.qq_w + QQMargin;
    self.titleUnderline.qq_centerX = firstButton.qq_centerX;
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

- (void)titleButtonClick:(QQTitleButton *)titleButton {
    
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:QQTitlerButtonDidRepeatClickNotification object:nil];
    }
    
    [self dealTitleButtonClick:titleButton];
}

- (void)dealTitleButtonClick:(QQTitleButton *)titleButton {
    
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleUnderline.qq_w = titleButton.titleLabel.qq_w + QQMargin;
        self.titleUnderline.qq_centerX = titleButton.qq_centerX;
        
        CGFloat offsetX = self.scrollView.qq_w * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        
    } completion:^(BOOL finished) {
        
        [self addChildViewControllerWithIndex:index];
    }];
    
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        
        UIViewController *childVc = self.childViewControllers[i];
        if (!childVc.isViewLoaded) {
            continue;
        }
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        
        if (![scrollView isKindOfClass:[UIScrollView class]]) {
            continue;
        }
        
        scrollView.scrollsToTop = (i == index);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.qq_w;
    QQTitleButton *button = self.titlesView.subviews[index];

    // 这句会造成轻轻左右滑动一下,就下拉刷新的 Bug
//    [self titleButtonClick:button];
    [self dealTitleButtonClick:button];
}

/**
 * 添加第 index 个子控制器到 ScrollView 中
 */
- (void)addChildViewControllerWithIndex:(NSUInteger)index {
    
//    UIViewController *childVc = self.childViewControllers[index];
//    if (childVc.isViewLoaded) {
//        return;
//    }
    
    UIView *childView = self.childViewControllers[index].view;
    
    if (childView.superview) {
        return;
    }
//    if (childView.window) {
//        return;
//    }
    
    CGFloat scrollViewW = self.scrollView.qq_w;
    childView.frame = CGRectMake(scrollViewW * index, 0, scrollViewW, self.scrollView.qq_h);
    [self.scrollView addSubview:childView];
}

/**
 * viewWithTag 的递归原理
 */
//- (UIView *)viewWithTag:(NSInteger)tag {
//
//    if (self.tag == tag) {
//        return self;
//    }
//
//    for (UIView *subView in self.subViews) {
//        UIView *resultView = [subView viewWithTag:tag];
//        if (resultView) {
//            return resultView;
//        }
//    }
//    return nil;
//}

@end
