//
//  QQHTTPSessionManger.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQHTTPSessionManger.h"

@implementation QQHTTPSessionManger

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
//        NSLog(@"%@", [UIDevice currentDevice]);
//        NSLog(@"name = %@", [UIDevice currentDevice].name);
//        NSLog(@"model = %@", [UIDevice currentDevice].model);
//        NSLog(@"localizedModel = %@", [UIDevice currentDevice].localizedModel);
//        NSLog(@"systemName = %@", [UIDevice currentDevice].systemName);
//        NSLog(@"systemVersion = %@", [UIDevice currentDevice].systemVersion);
//
//        NSLog(@"identifierForVendor = %@", [UIDevice currentDevice].identifierForVendor);
//        NSLog(@"batteryState = %ld", [UIDevice currentDevice].batteryState);
//        NSLog(@"batteryLevel = %f", [UIDevice currentDevice].batteryLevel);
        
//        [self.requestSerializer setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"iPhone"];
//        [self.requestSerializer setValue:[UIDevice currentDevice] forHTTPHeaderField:@"OS"];
    }
    return self;
}

@end
