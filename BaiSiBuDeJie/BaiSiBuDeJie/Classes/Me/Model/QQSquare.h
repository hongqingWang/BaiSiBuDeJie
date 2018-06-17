//
//  QQSquare.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQSquare : NSObject

/// 按钮名称
@property (nonatomic, copy) NSString *name;
/// 按钮的图片地址
@property (nonatomic, copy) NSString *icon;
/// pp scheme类型格式的参数如“活动”按钮：mod://App_To_Activity “http:\/\/5963.yoyuan.com.cn\/?from=5963”“寂寞约会”webview所加载的url
@property (nonatomic, copy) NSString *url;

@end
