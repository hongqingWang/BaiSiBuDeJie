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
#import "UIImageView+QQ.h"
#import "UIImage+QQ.h"

@interface QQTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commantButton;

@property (weak, nonatomic) IBOutlet UIView *hotCommentView;

@end

@implementation QQTopicCell

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    [self.profileImageView qq_setAvatarWithUrlString:[topic.u.header firstObject] placeholderImage:[UIImage qq_avatarImageWithImageName:@"defaultUserIcon"]];
    self.nameLabel.text = topic.u.name;
    self.timeLabel.text = topic.passtime;
    self.myTextLabel.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.up placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.down placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.forward placeholder:@"分享"];
    [self setupButton:self.commantButton number:topic.comment placeholder:@"评论"];
    
    if (topic.top_comments.count > 0) {
        self.hotCommentView.hidden = NO;
    } else {
        self.hotCommentView.hidden = YES;
    }
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= QQMargin;
    
    [super setFrame:frame];
}

@end
