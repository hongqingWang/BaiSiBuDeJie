//
//  UIImageView+QQ.m
//  MVVM
//
//  Created by 王红庆 on 2018/4/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIImageView+QQ.h"
#import <UIImageView+WebCache.h>
#import "UIImage+QQ.h"

@implementation UIImageView (QQ)

- (void)qq_imageName:(NSString *)imageName {
    
    self.image = [UIImage imageNamed:imageName];
}

- (void)qq_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage isAvatar:(BOOL)isAvatar {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
//    [self sd_setImageWithURL:url placeholderImage:placeholderImage];
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (isAvatar) {
            NSLog(@"aa");
            self.image = [image qq_roundImageWithSize:image.size backgroundColor:[UIColor whiteColor] lineColor:[UIColor lightGrayColor] lineWidth:5.0];
        } else {
//            NSLog(@"bb");
            self.image = [image qq_imageWithSize:image.size backgroundColor:[UIColor whiteColor]];
        }
    }];
}

@end
