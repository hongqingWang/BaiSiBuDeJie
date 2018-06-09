//
//  QQSubTag.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/7.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQSubTag : NSObject

/// 推荐标签的图片url地址
@property (nonatomic, copy) NSString *image_list;
/// 标签名称
@property (nonatomic, copy) NSString *theme_name;
/// 订阅的数量
@property (nonatomic, copy) NSString *sub_number;

@end
