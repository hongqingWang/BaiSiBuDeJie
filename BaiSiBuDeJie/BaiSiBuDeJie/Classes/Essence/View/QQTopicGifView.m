//
//  QQTopicGifView.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopicGifView.h"
#import <FLAnimatedImage.h>
#import "QQTopic.h"
#import "QQGif.h"
#import "UIImageView+QQ.h"

@interface QQTopicGifView ()

@property (nonatomic, strong) FLAnimatedImageView *animateImageView;

@end

@implementation QQTopicGifView

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
//    self.placeholderImageView.hidden = NO;
    
    NSString *pictureURLString = [NSString string];
    NSString *pictureThumbnailURLString = [NSString string];
    
    pictureURLString = [topic.gif.images firstObject];
    pictureThumbnailURLString = [topic.gif.gif_thumbnail firstObject];
    
    [self.animateImageView qq_setOriginImageWithURLString:pictureURLString thumbnailImage:pictureThumbnailURLString placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        FLAnimatedImage *animateImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
        self.animateImageView.animatedImage = animateImage;
//        self.placeholderImageView.hidden = YES;
    }];
}
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    
    [self addSubview:self.animateImageView];
    
    self.animateImageView.image = [UIImage imageNamed:@"defaultUserIcon"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.animateImageView.frame = self.bounds;
}

#pragma mark - Getters And Setters
- (FLAnimatedImageView *)animateImageView {
    if (_animateImageView == nil) {
        _animateImageView = [[FLAnimatedImageView alloc] init];
    }
    return _animateImageView;
}

@end
