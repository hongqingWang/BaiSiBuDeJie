//
//  QQRefreshHeader.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQRefreshHeader.h"

@implementation QQRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
//        self.lastUpdatedTimeLabel.hidden = YES;
//        self.stateLabel.font = [UIFont systemFontOfSize:18];
//        self.stateLabel.textColor = [UIColor redColor];
//        [self setTitle:@"Q下拉可以刷新Q" forState:MJRefreshStateIdle];
//        [self setTitle:@"Q松开立即刷新Q" forState:MJRefreshStatePulling];
//        [self setTitle:@"Q正在刷新数据中...Q" forState:MJRefreshStateRefreshing];
        self.automaticallyChangeAlpha = YES;
    }
    return self;
}

@end
