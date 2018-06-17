//
//  QQTabBarController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2017/11/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQTabBarController.h"
#import "QQEssenceViewController.h"
#import "QQNewViewController.h"
#import "QQFriendTrendViewController.h"
#import "QQPublishViewController.h"
#import "QQMeViewController.h"
#import "UIImage+QQ.h"
#import "QQTabBar.h"
#import "QQNavigationController.h"

@interface QQTabBarController ()

@end

@implementation QQTabBarController


/**
 此方法只调用一次
 */
+ (void)load {
    
    /// 此方法不建议用,如果应用程序中如果有不止一个`TabBarItem`的话,也同样会被渲染
//    UITabBarItem *item = [UITabBarItem appearance];
    
    /**
     * 'appearanceWhenContainedIn:' is deprecated: first deprecated in iOS 9.0 - Use +appearanceWhenContainedInInstancesOfClasses: instead
     */
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
}

#pragma mark - Left Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllChildViewControllers];
    [self setupTabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - addAllChildViewControllers
- (void)addAllChildViewControllers {
    
    QQEssenceViewController *essenceVc = [[QQEssenceViewController alloc] init];
    [self addChildViewController:essenceVc title:@"精华" image:@"tabBar_essence"];

    QQNewViewController *newVc = [[QQNewViewController alloc] init];
    [self addChildViewController:newVc title:@"新帖" image:@"tabBar_new"];

//    QQPublishViewController *publishVc = [[QQPublishViewController alloc] init];
//    [self addNoNavChildViewController:publishVc title:nil image:@"tabBar_publish"];
    
    QQFriendTrendViewController *friendTrendVc = [[QQFriendTrendViewController alloc] init];
    [self addChildViewController:friendTrendVc title:@"关注" image:@"tabBar_friendTrends"];

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([QQMeViewController class]) bundle:nil];
    QQMeViewController *meVc = [storyBoard instantiateInitialViewController];
//    QQMeViewController *meVc = [[QQMeViewController alloc] init];
    [self addChildViewController:meVc title:@"我" image:@"tabBar_me"];
}

/**
 添加子控制器(导航控制器)

 @param vc vc
 @param title title
 @param image image
 */
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image {
    
    vc.title = title;

    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    NSString *selectedImage = [NSString stringWithFormat:@"%@_selected", image];
    vc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selectedImage];
    
    QQNavigationController *nav = [[QQNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

#pragma mark - setupTabBar
- (void)setupTabBar {
    
    QQTabBar *tabBar = [[QQTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

@end
