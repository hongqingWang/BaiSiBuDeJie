//
//  UIImageView+QQ.h
//  MVVM
//
//  Created by 王红庆 on 2018/4/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (QQ)

- (void)qq_setAvatarWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;









- (void)qq_imageName:(NSString *)imageName;
- (void)qq_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage isAvatar:(BOOL)isAvatar;

@end
