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
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface QQTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation QQTopicVideoView

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    UIImage *placeholder = nil;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:[topic.video.thumbnail firstObject]];
    
    if (originImage) {
        self.imageView.image = originImage;
    } else {
        if (manager.isReachableViaWiFi) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:[topic.video.thumbnail firstObject]] placeholderImage:placeholder];
        } else if (manager.isReachableViaWWAN) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:[topic.video.thumbnail_small firstObject]] placeholderImage:placeholder];
        } else {
            UIImage *thumbnilImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:[topic.video.thumbnail_small firstObject]];
            if (thumbnilImage) {
                self.imageView.image = thumbnilImage;
            } else {
                self.imageView.image = placeholder;
            }
        }
    }
    
    if (topic.video.playcount >= 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.video.playcount / 10000.0];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%ld播放", topic.video.playcount];
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%zd", topic.video.duration / 60, topic.video.duration % 60];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
