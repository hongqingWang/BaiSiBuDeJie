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

@interface QQTabBarController ()

@end

@implementation QQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllChildViewControllers];
}

#pragma mark - addAllChildViewControllers
- (void)addAllChildViewControllers {
    
    QQEssenceViewController *essenceVc = [[QQEssenceViewController alloc] init];
    [self addChildViewController:essenceVc title:@"精华" image:@"tabBar_essence"];

    QQNewViewController *newVc = [[QQNewViewController alloc] init];
    [self addChildViewController:newVc title:@"新帖" image:@"tabBar_new"];

    QQPublishViewController *publishVc = [[QQPublishViewController alloc] init];
    [self addNoNavChildViewController:publishVc title:nil image:@"tabBar_publish"];
    
    QQFriendTrendViewController *friendTrendVc = [[QQFriendTrendViewController alloc] init];
    [self addChildViewController:friendTrendVc title:@"关注" image:@"tabBar_friendTrends"];

    QQMeViewController *meVc = [[QQMeViewController alloc] init];
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
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

/**
 添加子控制器(无导航控制器)
 
 @param vc vc
 @param title title
 @param image image
 */
- (void)addNoNavChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image {
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    NSString *selectedImage = [NSString stringWithFormat:@"%@_selected", image];
    vc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selectedImage];
    
    [self addChildViewController:vc];
}

@end
