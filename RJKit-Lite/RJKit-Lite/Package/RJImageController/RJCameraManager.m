//
//  RJCameraManager.m
//  kisshappy
//
//  Created by shenruijie on 2018/4/17.
//  Copyright © 2018年 shenguanjiejie. All rights reserved.
//

#import "RJCameraManager.h"
#import "RSKImageCropViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UIViewController+RJAlert.h"
#import "UIApplication+RJPermission.h"
#import "NSObject+RJObject.h"
#import "RJKiteLitePch.h"

@interface RJCameraManager()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource>
@property (nonatomic, strong) UIImagePickerController *pickerController;

@end

@implementation RJCameraManager

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
        if (_cameraManagerCompletionBlock) {
            _cameraManagerCompletionBlock(image);
            [_pickerController dismissViewControllerAnimated:YES completion:nil];
            self.object = nil;
        }
    }
}

- (void)presentCameraController{
    self.object = self;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        BOOL permission = [UIApplication cameraPermissionWithAlert:YES handler:^(BOOL granted) {
            if (granted) {
                [self presentToPicker];
            }
        }];
        
        if (permission) {
            [self presentToPicker];
        }
    }
}

- (void)presentToPicker{
    _pickerController = [[UIImagePickerController alloc] init];
    _pickerController.delegate = self;
    //设置拍照后的图片可被编辑
    //资源类型为照相机
    _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [[Tools topViewControllerWithoutModel] dismissViewControllerAnimated:NO completion:^{
    }];
    [[Tools topViewControllerWithoutModel] presentViewController:self.pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    RJImage *rjImage = [[RJImage alloc] init];
//    rjImage.asset = info[UIImagePickerControllerPHAsset];
    rjImage.image = info[UIImagePickerControllerOriginalImage];
    [self completionWithImage:rjImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
//    [_pickerController popViewControllerAnimated:YES];
    [_pickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(nonnull UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle{
    if (_cameraManagerCompletionBlock) {
        _cameraManagerCompletionBlock([RJImage rj_imageWithImage:croppedImage]);
    }
    [_pickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
