//
//  QQSeeBigPictureViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQSeeBigPictureViewController.h"

@interface QQSeeBigPictureViewController ()

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation QQSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Event Response
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture:(UIButton *)sender {
    
}

@end
