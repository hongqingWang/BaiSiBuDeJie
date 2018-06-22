//
//  QQTopicPictureView.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopicPictureView.h"
#import "QQTopic.h"
#import "QQImage.h"
#import "UIImageView+QQ.h"

@interface QQTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureutton;

@end

@implementation QQTopicPictureView

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    self.placeholderImageView.hidden = NO;
    
    [self.imageView qq_setOriginImageWithURLString:[topic.image.big firstObject] thumbnailImage:[topic.image.thumbnail_small firstObject] placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.placeholderImageView.hidden = YES;
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
