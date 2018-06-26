//
//  QQRecommendViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQRecommendViewController.h"
#import <AFNetworking.h>
#import "QQTopic.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "QQTopicCell.h"

@interface QQRecommendViewController ()

@end

@implementation QQRecommendViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSString *)urlString {
    return QQRecommendURL;
}

@end
