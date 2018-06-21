//
//  QQTopic.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopic.h"

@implementation QQTopic

- (CGFloat)cellHeight {
    
    if (_cellHeight) return _cellHeight;
    
    _cellHeight += QQMargin;
    _cellHeight += 35;
    _cellHeight += QQMargin;
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - QQMargin * 2, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += QQMargin;
    
    _cellHeight += 35;
    
    _cellHeight += QQMargin;
    
    return _cellHeight;
}

@end
