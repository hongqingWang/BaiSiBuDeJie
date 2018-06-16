//
//  QQLoginViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQLoginViewController.h"
#import "QQLoginRegisterView.h"
#import "QQFastLoginView.h"

@interface QQLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewLeadConstrains;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation QQLoginViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    QQLoginRegisterView *loginView = [QQLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    QQLoginRegisterView *registerView = [QQLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    
    QQFastLoginView *fastLoginView = [QQFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    QQLoginRegisterView *loginView = [self.middleView.subviews firstObject];
    loginView.frame = CGRectMake(0, 0, self.middleView.qq_w * 0.5, self.middleView.qq_h);

    QQLoginRegisterView *registerView = [self.middleView.subviews lastObject];
    registerView.frame = CGRectMake(self.middleView.qq_w * 0.5, 0, self.middleView.qq_w * 0.5, self.middleView.qq_h);
    
    QQFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
}

#pragma mark - Event Response
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    _middleViewLeadConstrains.constant = _middleViewLeadConstrains.constant == 0 ? -self.middleView.qq_w * 0.5 : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
