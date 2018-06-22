//
//  QQTopicVideoView.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopicVideoView.h"
#import "QQTopic.h"
#import "QQVideo.h"
#import "UIImageView+QQ.h"

@interface QQTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageView;

@end

@implementation QQTopicVideoView

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    self.placeholderImageView.hidden = NO;

    [self.imageView qq_setOriginImageWithURLString:[topic.video.thumbnail firstObject] thumbnailImage:[topic.video.thumbnail_small firstObject] placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.placeholderImageView.hidden = YES;
    }];
    
    [self dealPlayCount:topic];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%zd", topic.video.duration / 60, topic.video.duration % 60];
}

- (void)dealPlayCount:(QQTopic *)topic {
    
    if (topic.video.playcount >= 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.video.playcount / 10000.0];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%ld播放", topic.video.playcount];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
