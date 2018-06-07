//
//  QQAdView.h
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 18/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQAd;
@class QQAdView;

@protocol QQAdViewDelegete <NSObject>

/**
 * 点击广告图片跳转
 */
- (void)adView:(QQAdView *)adView tapAdImageView:(UITapGestureRecognizer *)tap;

/**
 * 点击跳过广告按钮
 */
- (void)adView:(QQAdView *)adView jumpAd:(UIButton *)button;

@end

@interface QQAdView : UIView

/// 模型
@property (nonatomic, strong) QQAd *ad;
/// QQAdViewDelegete
@property (nonatomic, weak) id <QQAdViewDelegete> delegate;
/// JumpButton
@property (nonatomic, strong) UIButton *jumpButton;

@end
