//
//  QQSeeBigPictureViewController.m
//  BaiSiBuDeJie
//
//  Created by 王红庆 on 2018/6/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "QQSeeBigPictureViewController.h"
#import "QQTopic.h"
#import "QQImage.h"
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface QQSeeBigPictureViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation QQSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:scrollView atIndex:0];
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.topic.image.big firstObject]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.saveButton.enabled = YES;
    }];
    imageView.qq_w = scrollView.qq_w;
    imageView.qq_h = imageView.qq_w * self.topic.image.height / self.topic.image.width;
    imageView.qq_x = scrollView.qq_x;
    if (imageView.qq_h > SCREEN_HEIGHT) {
        imageView.qq_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.qq_h);
    } else {
        imageView.qq_centerY = scrollView.qq_h * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片缩放
    CGFloat maxScale = self.topic.image.width / imageView.qq_w;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Event Response
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture:(UIButton *)sender {
    
    NSError *error;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        NSLog(@"1 - %@", [NSThread currentThread]);
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
        
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
    
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
//    } else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
//    }
//}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    self.scrollView.frame = self.view.bounds;
}

@end
