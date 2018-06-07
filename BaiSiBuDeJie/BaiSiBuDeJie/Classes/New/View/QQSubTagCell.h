//
//  QQSubTagCell.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/7.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQSubTag;

@interface QQSubTagCell : UITableViewCell

+ (instancetype)subTagCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) QQSubTag *subTag;

@end
