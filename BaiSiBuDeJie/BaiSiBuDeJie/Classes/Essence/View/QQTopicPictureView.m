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
        
        // 重新调整图片尺寸大小
        if (topic.isBigPicture) {
            
            CGFloat imageW = SCREEN_WIDTH - QQMargin * 2;
            CGFloat imageH = imageW * topic.image.height / topic.image.width;
            CGSize size = CGSizeMake(imageW, imageH);
            
            UIGraphicsBeginImageContext(size);
            
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
        }
    }];
    
    if (topic.isBigPicture) {
        
        self.seeBigPictureutton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
    } else {
        
        self.seeBigPictureutton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
