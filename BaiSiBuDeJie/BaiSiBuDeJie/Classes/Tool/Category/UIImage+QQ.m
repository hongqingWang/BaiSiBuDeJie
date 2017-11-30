//
//  UIImage+QQ.m
//  BaiSiBuDeJie
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "UIImage+QQ.h"

@implementation UIImage (QQ)

+ (instancetype)imageOriginalWithName:(NSString *)imageName {
    
    UIImage *imageNormal = [UIImage imageNamed:imageName];
    return [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
