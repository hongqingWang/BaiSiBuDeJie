//
//  UIImage+QQ.h
//  BaiSiBuDeJie
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QQ)

- (UIImage *)qq_avatarImageWithSize:(CGSize)size;

+ (instancetype)imageOriginalWithName:(NSString *)imageName;




- (UIImage *)qq_imageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor;
- (UIImage *)qq_roundImageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth;

@end
