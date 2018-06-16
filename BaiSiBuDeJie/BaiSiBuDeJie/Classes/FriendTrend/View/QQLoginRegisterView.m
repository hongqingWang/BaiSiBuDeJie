//
//  QQLoginRegisterView.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQLoginRegisterView.h"

@interface QQLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end

@implementation QQLoginRegisterView

+ (instancetype)loginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    UIImage *heighlightedImage = [UIImage imageNamed:@"loginBtnBgClick"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    heighlightedImage = [heighlightedImage stretchableImageWithLeftCapWidth:heighlightedImage.size.width * 0.5 topCapHeight:heighlightedImage.size.height * 0.5];
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
    [_loginRegisterButton setBackgroundImage:heighlightedImage forState:UIControlStateHighlighted];
}

@end
