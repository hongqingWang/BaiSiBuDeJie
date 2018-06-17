//
//  QQSquareCell.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/17.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQSquareCell.h"
#import "QQSquare.h"
#import <UIImageView+WebCache.h>

@interface QQSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation QQSquareCell

- (void)setItem:(QQSquare *)item {
    _item = item;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}

@end
