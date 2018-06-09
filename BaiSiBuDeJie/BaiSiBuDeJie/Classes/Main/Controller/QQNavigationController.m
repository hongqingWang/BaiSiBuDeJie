//
//  QQNavigationController.m
//  BaiSiBuDeJie
//
//  Created by Mac on 06/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNavigationController.h"
#import "UIBarButtonItem+QQ.h"

@interface QQNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation QQNavigationController

+ (void)load {
    
    /**
     * 'appearanceWhenContainedIn:' is deprecated: first deprecated in iOS 9.0 - Use +appearanceWhenContainedInInstancesOfClasses: instead
     */
//    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"qq_nav_background"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self.interactivePopGestureRecognizer.delegate
                                   action:@selector(handleNavigationTransition:)];
    
#pragma clang diagnostic pop
    
    [self.view addGestureRecognizer:pan];
    // 根控制器不触发滑动手势,防止假死
    pan.delegate = self;
    // 禁用系统自带的手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem qq_backItemWithImageName:@"qq_nav_back" target:self action:@selector(back)];
//        NSLog(@"%@", self.interactivePopGestureRecognizer);
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
