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
#import <NSData+ImageContentType.h>

@interface QQTopicGifView ()

@property (nonatomic, strong) FLAnimatedImageView *animateImageView;
/// gif标识
@property (nonatomic, strong) UIImageView *gifLogoImageView;

@end

@implementation QQTopicGifView

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    [self.animateImageView qq_setOriginImageWithURLString:[topic.gif.images firstObject] thumbnailImage:[topic.gif.gif_thumbnail firstObject] placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:imageData];

        if (imageFormat == SDImageFormatGIF) {

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                FLAnimatedImage *animateImage = [FLAnimatedImage animatedImageWithGIFData:imageData];

                dispatch_async(dispatch_get_main_queue(), ^{

                    self.animateImageView.animatedImage = animateImage;
                });
            });
        }
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
    [self addSubview:self.gifLogoImageView];
    
    self.animateImageView.image = [UIImage imageNamed:@"defaultUserIcon"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.animateImageView.frame = self.bounds;
    self.gifLogoImageView.frame = CGRectMake(0, 0, 31, 31);
}

#pragma mark - Getters And Setters
- (FLAnimatedImageView *)animateImageView {
    if (_animateImageView == nil) {
        _animateImageView = [[FLAnimatedImageView alloc] init];
        _animateImageView.runLoopMode = NSDefaultRunLoopMode;
    }
    return _animateImageView;
}

- (UIImageView *)gifLogoImageView {
    if (_gifLogoImageView == nil) {
        _gifLogoImageView = [[UIImageView alloc] init];
        _gifLogoImageView.image = [UIImage imageNamed:@"common-gif"];
    }
    return _gifLogoImageView;
}

@end
