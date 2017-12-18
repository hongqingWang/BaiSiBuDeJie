//
//  UIColor+QQ.h
//  QQScrollView
//
//  Created by Mac on 07/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define QQ_FIRST_COLOR                      [UIColor colorWithRed:((float)((0x592F12 & 0xFF0000) >> 16))/255.0 green:((float)((0x592F12 & 0xFF00) >> 8))/255.0 blue:((float)(0x592F12 & 0xFF))/255.0 alpha:1.0]
//#define QQ_SECOND_COLOR                     [UIColor colorWithRed:((float)((0xA3836D & 0xFF0000) >> 16))/255.0 green:((float)((0xA3836D & 0xFF00) >> 8))/255.0 blue:((float)(0xA3836D & 0xFF))/255.0 alpha:1.0]
//#define QQ_THIRD_COLOR                      [UIColor colorWithRed:((float)((0xDDCDA6 & 0xFF0000) >> 16))/255.0 green:((float)((0xDDCDA6 & 0xFF00) >> 8))/255.0 blue:((float)(0xDDCDA6 & 0xFF))/255.0 alpha:1.0]
//#define QQ_ORANGE_COLOR                     [UIColor colorWithRed:((float)((0xFF6C1E & 0xFF0000) >> 16))/255.0 green:((float)((0xFF6C1E & 0xFF00) >> 8))/255.0 blue:((float)(0xFF6C1E & 0xFF))/255.0 alpha:1.0]
//#define QQ_GREEN_COLOR                      [UIColor colorWithRed:((float)((0xA1D09C & 0xFF0000) >> 16))/255.0 green:((float)((0xA1D09C & 0xFF00) >> 8))/255.0 blue:((float)(0xA1D09C & 0xFF))/255.0 alpha:1.0]
//#define QQ_GRAY_COLOR                       [UIColor colorWithRed:((float)((0xB9B5AB & 0xFF0000) >> 16))/255.0 green:((float)((0xB9B5AB & 0xFF00) >> 8))/255.0 blue:((float)(0xB9B5AB & 0xFF))/255.0 alpha:1.0]
//#define QQ_HEX_COLOR(HEX)                   [UIColor colorWithRed:((float)((HEX & 0xFF0000) >> 16))/255.0 green:((float)((HEX & 0xFF00) >> 8))/255.0 blue:((float)(HEX & 0xFF))/255.0 alpha:1.0]

@interface UIColor (QQ)

/**
 * 随机色
 */
+ (UIColor *)qq_randomColor;

//// 默认alpha位1
//+ (UIColor *)colorWithHexString:(NSString *)color;
//
////从十六进制字符串获取颜色，
////color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
//+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
