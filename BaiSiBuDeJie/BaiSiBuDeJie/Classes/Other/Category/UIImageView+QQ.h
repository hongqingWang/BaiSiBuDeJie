//
//  UIImageView+QQ.h
//  MVVM
//
//  Created by 王红庆 on 2018/4/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (QQ)

- (void)qq_setAvatarWithUrlString:(NSString *_Nullable)urlString placeholderImage:(UIImage *_Nullable)placeholderImage;

- (void)qq_setOriginImageWithURLString:(NSString *_Nullable)originURLString thumbnailImage:(NSString *)thumbnailURLString placeholder:(UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock;








- (void)qq_imageName:(NSString *_Nullable)imageName;
- (void)qq_setImageWithUrlString:(NSString *_Nullable)urlString placeholderImage:(UIImage *_Nullable)placeholderImage isAvatar:(BOOL)isAvatar;

@end
