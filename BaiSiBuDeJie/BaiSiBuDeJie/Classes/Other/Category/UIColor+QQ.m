//
//  UIColor+QQ.m
//  QQScrollView
//
//  Created by Mac on 07/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "UIColor+QQ.h"

@implementation UIColor (QQ)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:0.5];
}

+ (UIColor *)lineColor {
    return [UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1.0];
}

/**
 * 灰色背景颜色
 */
+ (UIColor *)backgroundColor {
    return [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0];
}

/**
 * 昵称颜色(普通)
 */
+ (UIColor *)nameColor {
    return [UIColor colorWithRed:67 / 255.0 green:115 / 255.0 blue:166 / 255.0 alpha:1.0];
}

/**
 * 昵称颜色(会员)
 */
+ (UIColor *)vipNameColor {
    return [UIColor colorWithRed:244 / 255.0 green:48 / 255.0 blue:40 / 255.0 alpha:1.0];
}

/**
 * 评论背景色
 */
+ (UIColor *)commentBackgroundColor {
    return [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
}

//+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
//{
//    
//    //删除字符串中的空格
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    // String should be 6 or 8 characters
//    if ([cString length] < 6)
//    {
//        return [UIColor clearColor];
//    }
//    // strip 0X if it appears
//    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
//    if ([cString hasPrefix:@"0X"])
//    {
//        cString = [cString substringFromIndex:2];
//    }
//    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
//    if ([cString hasPrefix:@"#"])
//    {
//        cString = [cString substringFromIndex:1];
//    }
//    if ([cString length] != 6)
//    {
//        return [UIColor clearColor];
//    }
//    
//    // Separate into r, g, b substrings
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    //r
//    NSString *rString = [cString substringWithRange:range];
//    //g
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    //b
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
//}
//
////默认alpha值为1
//+ (UIColor *)colorWithHexString:(NSString *)color
//{
//    return [self colorWithHexString:color alpha:1.0f];
//}

@end
