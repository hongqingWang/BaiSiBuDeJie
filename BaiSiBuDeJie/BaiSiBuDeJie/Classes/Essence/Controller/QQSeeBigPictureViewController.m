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
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {
                if (oldStatus == PHAuthorizationStatusNotDetermined) {
                    NSLog(@"请允许访问相册");
                }
            } else if (status == PHAuthorizationStatusAuthorized) {
                [self saveImageIntoAlbum];
            } else if (status == PHAuthorizationStatusRestricted) {
                [SVProgressHUD showErrorWithStatus:@"系统原因，暂时无法访问相册!"];
            }
        });
    }];
}

- (void)saveImageIntoAlbum {
    
    // 保存图片到系统相册
    PHFetchResult<PHAsset *> *createdAssets = [self createdAssets];
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败!"];
        return;
    }
    
    // 创建自己App的相册
    PHAssetCollection *assetCollection = [self creatCollection];
    if (assetCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败!"];
        return;
    }
    
    NSError *error = nil;
    // 添加图片到自定义相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
}

#pragma mark - 创建App相册
- (PHAssetCollection *)creatCollection {
    
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    PHFetchResult<PHAssetCollection *> *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *titleCollection in result) {
        if ([titleCollection.localizedTitle isEqualToString:title]) {
            return titleCollection;
        }
    }
    
    NSError *error = nil;
    __block NSString *createdCollectionID;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error];
    if (error) return nil;
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}

- (PHFetchResult<PHAsset *> *)createdAssets {
    
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    // 保存图片到系统相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    if (error) return nil;
    // 获取图片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    self.scrollView.frame = self.view.bounds;
}

@end
