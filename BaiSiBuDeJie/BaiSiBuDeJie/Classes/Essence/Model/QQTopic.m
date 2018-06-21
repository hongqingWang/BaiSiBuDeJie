//
//  QQTopic.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopic.h"
#import "QQComment.h"
#import "QQUser.h"
#import "QQVideo.h"

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
    
    // 视频
    if ([self.type isEqualToString:@"video"]) {
        _cellHeight += 100;
    }
    
    // 评论
    if (self.top_comments.count > 0) {
        
        _cellHeight += QQMargin;
        QQComment *comment = [self.top_comments firstObject];
        NSString *hotCommentString = [NSString stringWithFormat:@"%@: %@", comment.u.name, comment.content];
        CGSize commentSize = CGSizeMake(SCREEN_WIDTH - QQMargin * 4, MAXFLOAT);
        _cellHeight += [hotCommentString boundingRectWithSize:commentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight += QQMargin;
        _cellHeight += QQMargin;
    }
    
    return _cellHeight;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"top_comments":@"QQComment"
             };
}

@end
