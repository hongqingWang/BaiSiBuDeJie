//
//  QQNavigationController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 06/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNavigationController.h"

@interface QQNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation QQNavigationController

+ (void)load {
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"qq_nav_background"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem qq_backItemWithImageName:@"qq_nav_back" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - Event Response
- (void)back {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
}

@end
