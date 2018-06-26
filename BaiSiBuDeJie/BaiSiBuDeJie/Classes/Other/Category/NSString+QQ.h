//
//  NSString+QQ.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QQ)

/**
 富文本(行间距)
 
 @param string string
 @param fontSize fontSize
 @param lineSpacing lineSpacing
 @return return
 */
+ (NSMutableAttributedString *)qq_attributeString:(NSString *)string fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing;

@end
