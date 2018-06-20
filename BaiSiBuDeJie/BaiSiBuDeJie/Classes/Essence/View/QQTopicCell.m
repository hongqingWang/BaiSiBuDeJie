//
//  QQTopicCell.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQTopicCell.h"
#import "QQTopic.h"
#import <UIImageView+WebCache.h>

@interface QQTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commantButton;

@end

@implementation QQTopicCell

- (void)setTopic:(QQTopic *)topic {
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.timeLabel.text = topic.passtime;
    self.myTextLabel.text = topic.text;
    
    [self.dingButton setTitle:[NSString stringWithFormat:@"%@", topic.ding] forState:UIControlStateNormal];
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

@end
