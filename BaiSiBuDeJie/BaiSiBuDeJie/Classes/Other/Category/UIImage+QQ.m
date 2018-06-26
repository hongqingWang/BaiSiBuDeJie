//
//  UIImage+QQ.m
//  BaiSiBuDeJie
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "UIImage+QQ.h"

@implementation UIImage (QQ)

- (UIImage *)qq_avatarImage {
    
    // 图像的上下文-内存中开辟一个地址,跟屏幕无关
    /**
     * 1>绘图的尺寸
     * 2>不透明:false(透明) / true(不透明)
     * 3>scale:屏幕分辨率,默认情况下生成的图像使用'1.0'的分辨率,图像质量不好
     *         可以指定'0',会选择当前设备的屏幕分辨率
     */
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 实例化一个圆形的路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    // 进行路径裁切 - 后续的绘图,都会出现在圆形路径内部,外部的全部干掉
    [path addClip];
    
    // 绘图'drawInRect'就是在指定区域内拉伸屏幕
    [self drawInRect:rect];
    
    // 取得结果
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    // 返回结果
    return newImage;
}

+ (UIImage *)qq_avatarImageWithImageName:(NSString *)imageName {
    
    return [[self imageNamed:imageName] qq_avatarImage];
}

+ (instancetype)imageOriginalWithName:(NSString *)imageName {
    
    UIImage *imageNormal = [UIImage imageNamed:imageName];
    return [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 根据颜色生成图片
 
 @param color color
 @param size size
 @return return
 */
+ (UIImage *)qq_imageFromColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    // 创建图片
    UIGraphicsBeginImageContext(size);
    // 创建图片上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置当前填充颜色的图形上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 填充颜色
    CGContextFillRect(context, rect);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}







- (UIImage *)qq_imageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor {
    
    // 1.图像的上下文-内存中开辟一个地址,跟屏幕无关
    /**
     * 1.绘图的尺寸
     * 2.不透明:false(透明) / true(不透明)
     * 3.scale:屏幕分辨率,默认情况下生成的图像使用'1.0'的分辨率,图像质量不好
     *         可以指定'0',会选择当前设备的屏幕分辨率
     */
    //    UIGraphicsBeginImageContextWithOptions(size, true, 0);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // 背景填充(在裁切之前做填充)
    //    [backgroundColor setFill];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //    UIRectFill(rect);
    // 2.绘图'drawInRect'就是在指定区域内拉伸屏幕
    [self drawInRect:rect];
    
    // 3.取得结果
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    // 5.返回结果
    return newImage;
}
- (UIImage *)qq_roundImageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth {
    
    // 1.图像的上下文-内存中开辟一个地址,跟屏幕无关
    /**
     * 1>绘图的尺寸
     * 2>不透明:false(透明) / true(不透明)
     * 3>scale:屏幕分辨率,默认情况下生成的图像使用'1.0'的分辨率,图像质量不好
     *         可以指定'0',会选择当前设备的屏幕分辨率
     */
    //    UIGraphicsBeginImageContextWithOptions(size, true, 0);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    // 背景填充(在裁切之前做填充)
    [backgroundColor setFill];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIRectFill(rect);
    
    // 1.1 实例化一个圆形的路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    // 1.2 进行路径裁切 - 后续的绘图,都会出现在圆形路径内部,外部的全部干掉
    [path addClip];
    
    // 2.绘图'drawInRect'就是在指定区域内拉伸屏幕
    [self drawInRect:rect];
    
    // 3.绘制内切的圆形
    [lineColor setStroke];
    path.lineWidth = lineWidth;
    [path stroke];
    
    // 4.取得结果
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    
    // 6.返回结果
    return newImage;
}

@end
