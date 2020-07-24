//
//  RJImagePickerManager.m
//  AppKing
//
//  Created by shenruijie on 2018/4/10.
//  Copyright © 2018年 shenruijie. All rights reserved.
//

#import "RJImagePickerManager.h"
#import "RSKImageCropViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UIViewController+RJAlert.h"
#import "UIApplication+RJPermission.h"
#import "NSObject+RJObject.h"

@interface RJImagePickerManager ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UIGestureRecognizerDelegate>
{
    void (^_completion)(UIImage *image);
    
}
@end

@implementation RJImagePickerManager

#pragma mark - Life Cycle

-(instancetype)initWithCompletion:(void (^)(RJImage * image))completion{
    return [self initWithLimitCount:1 completion:^(NSArray *images) {
        if (completion) {
            completion([images firstObject]);
        }
    }];
}

-(instancetype)initWithLimitCount:(NSInteger)limitCount completion:(void (^)(NSArray<RJImage *> * images))completion{
    self = [super init];
    if (self) {
        _imagePickerCompletionBlock = completion;
        _limitCount = limitCount;
        _shouldClip = NO;
        //        _imageSize = CGSizeZero;
        //        _shouldClipToCircle = NO;
        
        self.pickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.limitCount delegate:self];
        _pickerController.allowPickingVideo = NO;
        _pickerController.allowPickingGif = NO;
        _pickerController.autoDismiss = NO;
        _pickerController.allowPickingOriginalPhoto = NO;
        _pickerController.maxImagesCount = _limitCount;
        _pickerController.allowTakePicture = YES;
        _pickerController.allowPreview = NO;
        // 你可以通过block或者代理，来得到用户选择的照片.
        [_pickerController setDidFinishPickingPhotosHandle:nil];
//        [[Tools topViewController] presentViewController:_pickerController animated:YES completion:nil];
    }
    
    return self;
}

- (void)presentPickerController{
    self.object = self;
    [[Tools topViewController] presentViewController:_pickerController animated:YES completion:nil];
}

#pragma mark - Private Methods

- (void)completionWithImage:(RJImage *)image{
    //    [[Tools topViewController].navigationController popViewControllerAnimated:NO];
    if (self.shouldClip) {
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image.image];
        imageCropVC.maskLayerStrokeColor = [UIColor whiteColor];
        imageCropVC.applyMaskToCroppedImage = YES;
        imageCropVC.avoidEmptySpaceAroundImage = YES;
        imageCropVC.cropMode = RSKImageCropModeCustom;
        imageCropVC.delegate = self;
        imageCropVC.dataSource = self;
        [_pickerController pushViewController:imageCropVC animated:NO];
    }else{
        if (_imagePickerCompletionBlock) {
            _imagePickerCompletionBlock(@[image]);
            [_pickerController dismissViewControllerAnimated:YES completion:nil];
            self.object = nil;
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取视频data
    //    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    //    DDDLog(@"---%@",videoURL);
    //    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    //    DDDLog(@"***%@",videoData);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    RJImage *rjImage = [[RJImage alloc] initWithImage:image];
    
    if (_limitCount >= 1) {
        [self completionWithImage:rjImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (self.imagePickerCancelBlock) {
        self.imagePickerCancelBlock();
    }
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (_limitCount == 1) {
        
        RJImage *image = [[RJImage alloc] initWithImage:photos.firstObject];
//        image.asset = assets.firstObject;
        [self completionWithImage:image];
    }else if(_imagePickerCompletionBlock){
        NSArray *images = [RJImage rj_imagesWithImages:photos];
//        for (NSInteger i = 0; i < images.count; i++) {
//            RJImage *image = images[i];
//            image.asset = assets[i];
//        }
        _imagePickerCompletionBlock(images);
        [_pickerController dismissViewControllerAnimated:YES completion:nil];
        self.object = nil;
    }
}

-(void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    
}

-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset{
    
}

#pragma mark - RSKImageCropViewControllerDelegate

- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller{
    return [self getRect];
}

- (CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller{
    return [self getRect];
}

- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller{
    CGRect rect = [self getRect];
    
    if (self.shouldClipToCircle) {
        return [UIBezierPath bezierPathWithArcCenter:CGRectGetCenter(rect) radius:rect.size.width / 2.0 startAngle:0 endAngle:2*M_PI clockwise:YES];
    }
    
    return [UIBezierPath bezierPathWithRect:rect];
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller{
    [_pickerController.selectedAssets removeAllObjects];
    [_pickerController.selectedModels removeAllObjects];
    [_pickerController.selectedAssetIds removeAllObjects];
    [_pickerController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(nonnull UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle{
    if (_imagePickerCompletionBlock) {
        _imagePickerCompletionBlock([NSArray arrayWithObject:[RJImage rj_imageWithImage:croppedImage]]);
    }
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
    self.object = nil;
}

#pragma mark 辅助方法

- (CGRect)getRect{
    //
    if (self.imageSize.width == 0 || self.imageSize.height == 0) {
        self.imageSize = CGSizeMake(kScreenWidth, kScreenWidth);
    }
    
    CGFloat scale = MIN(kScreenWidth / self.imageSize.width, kScreenHeight / self.imageSize.height);
    CGSize scaleSize = CGSizeMake(scale * self.imageSize.width, scale * self.imageSize.height);
    CGRect rect = CGRectMake(kScreenWidth / 2 - scaleSize.width / 2.0, kScreenHeight / 2.0 - scaleSize.height / 2.0, scaleSize.width, scaleSize.height);
    return rect;
}
@end
