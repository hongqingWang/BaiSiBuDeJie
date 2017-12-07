//
//  QQNavigationController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 06/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNavigationController.h"

@interface QQNavigationController ()

@end

@implementation QQNavigationController

+ (void)load {
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"qq_nav_background"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
    
    NSLog(@"%s", __FUNCTION__);
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem qq_backItemWithImageName:@"qq_nav_back" target:self action:@selector(back)];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
}

@end
