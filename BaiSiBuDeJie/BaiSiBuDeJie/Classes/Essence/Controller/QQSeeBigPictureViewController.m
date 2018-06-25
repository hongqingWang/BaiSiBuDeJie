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
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation QQSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor redColor];
    
//    scrollView.frame = self.view.bounds;
//    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
//    scrollView.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:scrollView atIndex:0];
//    self.scrollView = scrollView;
}

#pragma mark - Event Response
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture:(UIButton *)sender {

    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
}

@end
