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

@interface QQTabBarController ()

@end

@implementation QQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllChildViewControllers];
    
//    QQEssenceViewController *essenceVc = [[QQEssenceViewController alloc] init];
//    UINavigationController *navEssense = [[UINavigationController alloc] initWithRootViewController:essenceVc];
//    [self addChildViewController:navEssense];
//
//    QQNewViewController *newVc = [[QQNewViewController alloc] init];
//    UINavigationController *navNew = [[UINavigationController alloc] initWithRootViewController:newVc];
//    [self addChildViewController:navNew];
//
//    QQPublishViewController *publishVc = [[QQPublishViewController alloc] init];
//    [self addChildViewController:publishVc];
//
//    QQFriendTrendViewController *friendTrendVc = [[QQFriendTrendViewController alloc] init];
//    UINavigationController *navFriendTrend = [[UINavigationController alloc] initWithRootViewController:friendTrendVc];
//    [self addChildViewController:navFriendTrend];
//
//    QQMeViewController *meVc = [[QQMeViewController alloc] init];
//    UINavigationController *navMe = [[UINavigationController alloc] initWithRootViewController:meVc];
//    [self addChildViewController:navMe];
//
//    navEssense.tabBarItem.title = @"精华";
//    navEssense.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    navEssense.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_icon_selected"];
//
//    navNew.tabBarItem.title = @"新帖";
//    navNew.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    navNew.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_icon_selected"];
//
//    publishVc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    publishVc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_icon_selected"];
//
//    navFriendTrend.tabBarItem.title = @"关注";
//    navFriendTrend.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    navFriendTrend.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_icon_selected"];
//
//    navMe.tabBarItem.title = @"我";
//    navMe.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    navMe.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_icon_selected"];
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


//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self addChildViewControllers];
//}
//
///// 添加所有控制器
//- (void)addChildViewControllers
//{
//    /** 设置字体渲染颜色为橙色(因为选中设置为图片,并且图片渲染模式设置为 Original 模式,所以不会对图片有影响) */
//    self.tabBar.tintColor = HQColor;
//
//    HQHomeController *home = [[HQHomeController alloc] init];
//    [self addChildViewController:home title:@"首页" image:@"tabbar_01"];
//
//    HQNewsController *news = [[HQNewsController alloc] init];
//    [self addChildViewController:news title:@"消息频道" image:@"tabbar_02"];
//
//    HQConsultController *consult = [[HQConsultController alloc] init];
//    [self addChildViewController:consult title:@"健康咨询" image:@"tabbar_03"];
//
//    HQProfileController *profile = [[HQProfileController alloc] init];
//    [self addChildViewController:profile title:@"我的" image:@"tabbar_04"];
//}
//

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
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];

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
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self addChildViewController:vc];
}

@end
