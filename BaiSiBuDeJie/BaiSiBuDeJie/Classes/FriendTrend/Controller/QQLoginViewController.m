//
//  QQLoginViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQLoginViewController.h"

@interface QQLoginViewController ()

@end

@implementation QQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Event Response
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
