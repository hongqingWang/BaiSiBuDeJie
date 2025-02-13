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
    // 头像高
    _cellHeight += 35;
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - QQMargin * 2, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:QQTextRowSpace];
    // 解决`Label`不能正确换行问题
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSParagraphStyleAttributeName] = paragraphStyle;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:QQContentTextFontSize];
    _cellHeight += [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    _cellHeight += QQMargin;
    
    // 视频
    if ([self.type isEqualToString:@"video"]) {
        
        _cellHeight += QQMargin;
        
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
        
        _cellHeight += QQMargin;
        
        CGFloat middleViewX = QQMargin;
        CGFloat middleViewY = _cellHeight;
        CGFloat middleViewW = SCREEN_WIDTH - QQMargin * 2;
        CGFloat middleViewH = middleViewW * self.image.height / self.image.width;
        
        if (middleViewH > SCREEN_HEIGHT) {
            middleViewH = 350;
        }
        
        self.middleViewframe = CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
        _cellHeight += middleViewH;
    }
    
    // gif
    if ([self.type isEqualToString:@"gif"]) {
        
        _cellHeight += QQMargin;
        
        CGFloat middleViewX = QQMargin;
        CGFloat middleViewY = _cellHeight;
        CGFloat middleViewW = SCREEN_WIDTH - QQMargin * 2;
        CGFloat middleViewH = middleViewW * self.gif.height / self.gif.width;
        
        self.middleViewframe = CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
        _cellHeight += middleViewH;
    }
    
    // 四个按钮的View(BottomView)
    _cellHeight += 44;
    
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

- (BOOL)isBigPicture {
    return self.image.height > SCREEN_HEIGHT;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"top_comments":@"QQComment"
             };
}

@end
