//
//  QQTopicCell.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopicCell.h"
#import "QQTopic.h"
#import "QQUser.h"
#import "QQComment.h"
#import "UIImageView+QQ.h"
#import "UIImage+QQ.h"
#import "NSString+QQ.h"

#import "QQTopicPictureView.h"
#import "QQTopicGifView.h"
#import "QQTopicVideoView.h"

@interface QQTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *hotCommentView;
@property (weak, nonatomic) IBOutlet UILabel *hotCommentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotCommentViewTopCons;

/// QQTopicPictureView
@property (nonatomic, weak) QQTopicPictureView *topicPictureView;
/// QQTopicGifView
@property (nonatomic, strong) QQTopicGifView *topicGifView;
/// QQTopicVideoView
@property (nonatomic, weak) QQTopicVideoView *topicVideoView;

@end

@implementation QQTopicCell

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    [self.profileImageView qq_setAvatarWithUrlString:[topic.u.header firstObject] placeholderImage:[UIImage qq_avatarImageWithImageName:@"defaultUserIcon"]];
    self.nameLabel.text = topic.u.name;
    self.timeLabel.text = topic.passtime;
    self.myTextLabel.attributedText = [NSString qq_attributeString:topic.text fontSize:QQContentTextFontSize lineSpacing:QQTextRowSpace];
    
    [self setupButton:self.dingButton number:topic.up placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.down placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.forward placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    [self setupCommentWithTopic:topic];
    
    [self setupXibViewWithTopic:topic];
}

- (void)setupButton:(UIButton *)button number:(NSUInteger)number placeholder:(NSString *)placeholder {
    
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setupCommentWithTopic:(QQTopic *)topic {
    
    if (topic.top_comments.count > 0) {
        self.hotCommentView.hidden = NO;
        QQComment *comment = [topic.top_comments firstObject];
        self.hotCommentLabel.text = [NSString stringWithFormat:@"%@: %@", comment.u.name, comment.content];
        self.hotCommentViewTopCons.constant = 0;
        
    } else {
        
        self.hotCommentView.hidden = YES;
        self.hotCommentViewTopCons.constant = -(self.hotCommentView.qq_h + QQMargin);
    }
}

- (void)setupXibViewWithTopic:(QQTopic *)topic {
    
    if ([topic.type isEqualToString:@"image"]) {
        
        [self.contentView addSubview:self.topicPictureView];
        self.topicPictureView.hidden = NO;
        self.topicGifView.hidden = YES;
        self.topicVideoView.hidden = YES;
        self.topicPictureView.topic = topic;
        
    } else if ([topic.type isEqualToString:@"gif"]) {
        
        [self.contentView addSubview:self.topicGifView];
        self.topicPictureView.hidden = YES;
        self.topicGifView.hidden = NO;
        self.topicVideoView.hidden = YES;
        self.topicGifView.topic = topic;
        
    } else if ([topic.type isEqualToString:@"video"]) {
        
        [self.contentView addSubview:self.topicVideoView];
        self.topicPictureView.hidden = YES;
        self.topicGifView.hidden = YES;
        self.topicVideoView.hidden = NO;
        self.topicVideoView.topic = topic;
        
    } else if ([topic.type isEqualToString:@"text"]) {
        
        self.topicPictureView.hidden = YES;
        self.topicGifView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.dingButton setBackgroundImage:[UIImage qq_imageFromColor:[UIColor backgroundColor] size:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
    [self.caiButton setBackgroundImage:[UIImage qq_imageFromColor:[UIColor backgroundColor] size:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
    [self.repostButton setBackgroundImage:[UIImage qq_imageFromColor:[UIColor backgroundColor] size:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
    [self.commentButton setBackgroundImage:[UIImage qq_imageFromColor:[UIColor backgroundColor] size:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.topic.type isEqualToString:@"image"]) {
        self.topicPictureView.frame = self.topic.middleViewframe;
    } else if ([self.topic.type isEqualToString:@"gif"]) {
        self.topicGifView.frame = self.topic.middleViewframe;
    } else if ([self.topic.type isEqualToString:@"video"]) {
        self.topicVideoView.frame = self.topic.middleViewframe;
    } else if ([self.topic.type isEqualToString:@"text"]) {
        
    }
}

#pragma mark - Getters And Setters
- (QQTopicPictureView *)topicPictureView {
    if (_topicPictureView == nil) {
        _topicPictureView = [QQTopicPictureView qq_viewFromNib];
    }
    return _topicPictureView;
}

- (QQTopicGifView *)topicGifView {
    if (_topicGifView == nil) {
        _topicGifView = [[QQTopicGifView alloc] init];
    }
    return _topicGifView;
}

- (QQTopicVideoView *)topicVideoView {
    if (_topicVideoView == nil) {
        _topicVideoView = [QQTopicVideoView qq_viewFromNib];
    }
    return _topicVideoView;
}

@end
