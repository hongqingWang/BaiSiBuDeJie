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

//#import <YYImage/YYImage.h>

@interface QQTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureutton;

@end

@implementation QQTopicPictureView

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    self.placeholderImageView.hidden = NO;
    
    NSString *pictureURLString = [NSString string];
    NSString *pictureThumbnailURLString = [NSString string];
    
    pictureURLString = [topic.image.big firstObject];
    pictureThumbnailURLString = [topic.image.thumbnail_small firstObject];
    
    [self.imageView qq_setOriginImageWithURLString:pictureURLString thumbnailImage:pictureThumbnailURLString placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.placeholderImageView.hidden = YES;
    }];
    
//    if ([topic.type isEqualToString:@"image"]) {
//
//
//    } else if ([topic.type isEqualToString:@"gif"]) {
//        pictureURLString = [topic.gif.images firstObject];
//        pictureThumbnailURLString = [topic.gif.gif_thumbnail firstObject];
//
////        self.imageView
//
//    }
    
//    NSLog(@"%@", pictureURLString);
    
//    [self.imageView qq_setOriginImageWithURLString:pictureURLString thumbnailImage:pictureThumbnailURLString placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (!image) return;
//
//        self.placeholderImageView.hidden = YES;
//    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}



@end
