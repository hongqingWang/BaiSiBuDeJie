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
#import "QQImage.h"
#import "QQGif.h"

@implementation QQTopic

- (CGFloat)cellHeight {
    
    if (_cellHeight) return _cellHeight;
    
    _cellHeight += QQMargin;
    _cellHeight += 35;
    _cellHeight += QQMargin;
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - QQMargin * 2, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += QQMargin;
    
    // 视频
    if ([self.type isEqualToString:@"video"]) {
        
        CGFloat middleViewX = QQMargin;
        CGFloat middleViewY = _cellHeight;
        CGFloat middleViewW = SCREEN_WIDTH - QQMargin * 2;
        CGFloat middleViewH = middleViewW * self.video.height / self.video.width;
        self.middleViewframe = CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
        _cellHeight += middleViewH;
        
//        // 宽高比大于1
//        if ((self.video.width / self.video.height) >= 1) {
//            CGFloat middleViewX = QQMargin;
//            CGFloat middleViewY = _cellHeight;
//            CGFloat middleViewW = SCREEN_WIDTH - QQMargin * 2;
//            CGFloat middleViewH = middleViewW * self.video.height / self.video.width;
//            self.middleViewframe = CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
//            _cellHeight += middleViewH;
//        } else {
//            CGFloat middleViewY = _cellHeight;
//            CGFloat middleViewH = SCREEN_HEIGHT / 2;
//            CGFloat middleViewW = middleViewH * self.video.width / self.video.height;
//            CGFloat middleViewX = (SCREEN_WIDTH - middleViewW) / 2;
//            self.middleViewframe = CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
//            _cellHeight += middleViewH;
//        }
    }
    
    // 图片
    if ([self.type isEqualToString:@"image"]) {
        
        CGFloat middleViewX = QQMargin;
        CGFloat middleViewY = _cellHeight;
        CGFloat middleViewW = SCREEN_WIDTH - QQMargin * 2;
        CGFloat middleViewH = middleViewW * self.image.height / self.image.width;
        
//        if (middleViewH > SCREEN_HEIGHT / 2) {
//            middleViewH = 200;
//        }
        
        self.middleViewframe = CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
        _cellHeight += middleViewH;
    }
    
    // gif
    if ([self.type isEqualToString:@"gif"]) {
        
        CGFloat middleViewX = QQMargin;
        CGFloat middleViewY = _cellHeight;
        CGFloat middleViewW = SCREEN_WIDTH - QQMargin * 2;
        CGFloat middleViewH = middleViewW * self.gif.height / self.gif.width;
        
        if (middleViewH > SCREEN_HEIGHT / 2) {
            middleViewH = 300;
        }
        
        self.middleViewframe = CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
        _cellHeight += middleViewH;
    }
    
    // 四个按钮的View(BottomView)
    _cellHeight += 35;
    
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
