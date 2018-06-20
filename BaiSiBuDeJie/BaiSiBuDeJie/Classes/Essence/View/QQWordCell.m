//
//  QQWordCell.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQWordCell.h"
#import "QQTopic.h"

@implementation QQWordCell

- (void)setTopic:(QQTopic *)topic {
    [super setTopic:topic];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = [NSString stringWithFormat:@"%@", NSStringFromClass([self class])];
    }
    return self;
}

@end
