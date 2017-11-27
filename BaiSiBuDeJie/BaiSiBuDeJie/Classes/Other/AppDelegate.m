//
//  AppDelegate.m
//  BaiSiBuDeJie
//
//  Created by Mac on 2017/11/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "QQEssenceViewController.h"
#import "QQNewViewController.h"
#import "QQFriendTrendViewController.h"
#import "QQPublishViewController.h"
#import "QQMeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBar;
    
    QQEssenceViewController *essenceVc = [[QQEssenceViewController alloc] init];
    UINavigationController *navEssense = [[UINavigationController alloc] initWithRootViewController:essenceVc];
    [tabBar addChildViewController:navEssense];
    
    QQNewViewController *newVc = [[QQNewViewController alloc] init];
    UINavigationController *navNew = [[UINavigationController alloc] initWithRootViewController:newVc];
    [tabBar addChildViewController:navNew];
    
    QQPublishViewController *publishVc = [[QQPublishViewController alloc] init];
    [tabBar addChildViewController:publishVc];
    
    QQFriendTrendViewController *friendTrendVc = [[QQFriendTrendViewController alloc] init];
    UINavigationController *navFriendTrend = [[UINavigationController alloc] initWithRootViewController:friendTrendVc];
    [tabBar addChildViewController:navFriendTrend];
    
    QQMeViewController *meVc = [[QQMeViewController alloc] init];
    UINavigationController *navMe = [[UINavigationController alloc] initWithRootViewController:meVc];
    [tabBar addChildViewController:navMe];
    
    navEssense.tabBarItem.title = @"精华";
    navEssense.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    navEssense.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_icon_selected"];
    
    navNew.tabBarItem.title = @"新帖";
    navNew.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    navNew.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_icon_selected"];
    
    publishVc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
    publishVc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_icon_selected"];
    
    navFriendTrend.tabBarItem.title = @"关注";
    navFriendTrend.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    navFriendTrend.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_icon_selected"];
    
    navMe.tabBarItem.title = @"我";
    navMe.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    navMe.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_icon_selected"];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
