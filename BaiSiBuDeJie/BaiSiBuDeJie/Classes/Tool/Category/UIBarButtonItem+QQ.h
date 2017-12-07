//
//  UIBarButtonItem+QQ.h
//  BaiSiBuDeJie
//
//  Created by Mac on 06/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (QQ)

+ (UIBarButtonItem *)qq_itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)qq_itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)qq_backItemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end

