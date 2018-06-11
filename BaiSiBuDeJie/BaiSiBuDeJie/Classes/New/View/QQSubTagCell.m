//
//  QQSubTagCell.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/7.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQSubTagCell.h"
#import "QQSubTag.h"
#import "UIImageView+QQ.h"

@interface QQSubTagCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *subscribeButton;

@end

@implementation QQSubTagCell

- (void)setSubTag:(QQSubTag *)subTag {
    _subTag = subTag;
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:subTag.image_list]];
    
    [self.iconImageView qq_setImageWithUrlString:subTag.image_list placeholderImage:nil isAvatar:YES];
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:subTag.image_list] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        
//        UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
//        
//        [[UIColor whiteColor] setFill];
//        
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        [path addClip];
//        [image drawAtPoint:CGPointZero];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        _iconImageView.image = image;
//    }];
    
    self.nameLabel.text = subTag.theme_name;
    [self resolveNumber];
}

- (void)resolveNumber {
    
    NSString *numberString = [NSString string];
    NSInteger numberInteger = _subTag.sub_number.integerValue;
    if (numberInteger > 10000) {
        CGFloat numFloat = numberInteger / 10000.0;
        numberString = [NSString stringWithFormat:@"%.1f万人订阅", numFloat];
        numberString = [numberString stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else {
        numberString = [NSString stringWithFormat:@"%ld人订阅", numberInteger];
    }
    self.countLabel.text = numberString;
}

+ (instancetype)subTagCellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"QQSubTagCell";
    QQSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QQSubTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
//    cell.backgroundColor = [UIColor qq_randomColor];
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.subscribeButton];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16);
        make.width.height.mas_equalTo(50);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(8);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImageView);
        make.left.equalTo(self.nameLabel);
    }];
    [self.subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-16);
    }];
}

#pragma mark - Getters And Setters
- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"社会新闻";
    }
    return _nameLabel;
}

- (UILabel *)countLabel {
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"1111";
        _countLabel.textColor = [UIColor lightGrayColor];
        _countLabel.font = [UIFont systemFontOfSize:14];
    }
    return _countLabel;
}

- (UIButton *)subscribeButton {
    if (_subscribeButton == nil) {
        _subscribeButton = [[UIButton alloc] init];
        [_subscribeButton setTitle:@"+ 订阅" forState:UIControlStateNormal];
        [_subscribeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_subscribeButton setBackgroundImage:[UIImage imageNamed:@"tagButtonBG"] forState:UIControlStateNormal];
    }
    return _subscribeButton;
}

@end
