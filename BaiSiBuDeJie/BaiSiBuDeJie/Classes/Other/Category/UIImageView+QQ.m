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
#import <AFNetworking.h>

@implementation UIImageView (QQ)

- (void)qq_setAvatarWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!image) return;
        
        self.image = [image qq_avatarImage];
    }];
}

- (void)qq_setOriginImageWithURLString:(NSString *)originURLString thumbnailImage:(NSString *)thumbnailURLString placeholder:(UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:originURLString];
//    typedef void(^SDExternalCompletionBlock)(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL);
    
    if (originImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:originURLString] placeholderImage:placeholder completed:completedBlock];
//        self.image = originImage;
//        completedBlock(originImage, nil, 0, [NSURL URLWithString:originURLString]);
    } else {
        if (manager.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originURLString] placeholderImage:placeholder completed:completedBlock];
        } else if (manager.isReachableViaWWAN) {
            [self sd_setImageWithURL:[NSURL URLWithString:thumbnailURLString] placeholderImage:placeholder completed:completedBlock];
        } else {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:thumbnailURLString];
            if (thumbnailImage) {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailURLString] placeholderImage:placeholder completed:completedBlock];
//                self.image = thumbnailImage;
//                completedBlock(thumbnailImage, nil, 0, [NSURL URLWithString:thumbnailURLString]);
            } else {
                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
//                self.image = placeholder;
            }
        }
    }
}









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
