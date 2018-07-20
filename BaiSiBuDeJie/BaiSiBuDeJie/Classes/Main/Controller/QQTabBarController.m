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

@interface QQTabBarController ()<UITabBarDelegate>

// 记录上一次点击tabbar，使用时，记得先在init或viewDidLoad里 初始化 = 0
@property (nonatomic,assign) NSInteger  indexFlag;

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
    
    self.indexFlag = 0;
    
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

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        // 执行动画
        NSMutableArray *tabBarButtonArray = [NSMutableArray array];
        for (UIView *button in self.tabBar.subviews) {
            if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [tabBarButtonArray addObject:button];
            }
        }
/**************************************** 添加动画 ****************************************/
        /**
         * 先放大,再缩小
         */
        [self tabBarItemAnimationZoomWithTabBarButtonArray:tabBarButtonArray index:index];
        /**
         * Z轴旋转
         */
//        [self tabBarItemAnimationRotationZWithTabBarButtonArray:tabBarButtonArray index:index];
        /**
         * Y轴位移
         */
//        [self tabBarItemAnimationMoveYWithTabBarButtonArray:tabBarButtonArray index:index];
        /**
         * 放大并保持
         */
//        [self tabBarItemAnimationZoomOutWithTabBarButtonArray:tabBarButtonArray index:index];
        
        self.indexFlag = index;
    }
}

#pragma mark - setupTabBar
- (void)setupTabBar {
    
    QQTabBar *tabBar = [[QQTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - TabBarItemAnimation
/**
 * 先放大,再缩小
 */
- (void)tabBarItemAnimationZoomWithTabBarButtonArray:(NSArray *)tabBarButtonArray index:(NSInteger)index {
    
    // 放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;                               // 执行时间
    animation.repeatCount = 1;                              // 执行次数
    animation.autoreverses = YES;                           // 完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   // 初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     // 结束伸缩倍数
    [[tabBarButtonArray[index] layer] addAnimation:animation forKey:nil];
}

/**
 * Z轴旋转
 */
- (void)tabBarItemAnimationRotationZWithTabBarButtonArray:(NSArray *)tabBarButtonArray index:(NSInteger)index {
    
    // z轴旋转180度
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;                               // 执行时间
    animation.repeatCount = 1;                              // 执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];     // 初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:M_PI];    // 结束伸缩倍数
    [[tabBarButtonArray[index] layer] addAnimation:animation forKey:nil];
}

/**
 * Y轴位移
 */
- (void)tabBarItemAnimationMoveYWithTabBarButtonArray:(NSArray *)tabBarButtonArray index:(NSInteger)index {
    
    // 向上移动
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    // 速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;                               // 执行时间
    animation.repeatCount = 1;                              // 执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];     // 初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:-10];     // 结束伸缩倍数
    [[tabBarButtonArray[index] layer] addAnimation:animation forKey:nil];
}

/**
 * 放大并保持
 */
- (void)tabBarItemAnimationZoomOutWithTabBarButtonArray:(NSArray *)tabBarButtonArray index:(NSInteger)index {

    // 放大效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;                               // 执行时间
    animation.repeatCount = 1;                              // 执行次数
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;               // 保证动画效果延续
    animation.fromValue = [NSNumber numberWithFloat:1.0];   // 初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.15];    // 结束伸缩倍数
    [[tabBarButtonArray[index] layer] addAnimation:animation forKey:nil];
    // 移除其他tabbar的动画
    for (int i = 0; i < tabBarButtonArray.count; i++) {
        if (i != index) {
            [[tabBarButtonArray[i] layer] removeAllAnimations];
        }
    }
}
    
@end
