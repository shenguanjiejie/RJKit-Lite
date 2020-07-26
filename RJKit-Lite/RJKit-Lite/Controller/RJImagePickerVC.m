//
//  RJImagePickerVC.m
//  innerCloud
//
//  Created by Ruijie on 2017/3/28.
//  Copyright © 2017年 Ruijie. All rights reserved.
//

#import "RJImagePickerVC.h"
#import "TZImagePickerController.h"
#import "RSKImageCropViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UIViewController+RJAlert.h"
#import "UIApplication+RJPermission.h"
#import "RJKitLitePch.h"

@interface RJImagePickerVC ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UIGestureRecognizerDelegate>
{
    UITableView *_tableView;
    void (^_completion)(UIImage *image);
    void (^_imagesCompletion)(NSArray *images);
    BOOL _originalNavigationControllerNavigationBarHidden;
}
@end

@implementation RJImagePickerVC

#pragma mark - Life Cycle

-(instancetype)initWithCompletion:(void (^)(UIImage * image))completion{
    return [self initWithLimitCount:1 completion:^(NSArray *images) {
        if (completion) {
            completion([images firstObject]);
        }
    }];
}

-(instancetype)initWithLimitCount:(NSInteger)limitCount completion:(void (^)(NSArray<UIImage *> * images))completion{
    self = [super init];
    if (self) {
        _imagesCompletion = completion;
        _limitCount = limitCount;
        _shouldClip = NO;
//        _imageSize = CGSizeZero;
//        _shouldClipToCircle = NO;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择图片";
    self.view.backgroundColor = kBackgroundColor;
    
#ifdef kCustomNavigationBar
    [self setNavigationBarViewWithTitle:self.title backSelector:@selector(back)];
#else
    [self setNavigationBarViewWithBackMsg:kLocalString(choose_image) backSelector:@selector(back)];
#endif
    //初始化参数
    [self variableInit];
    
    //设置Views
    [self setViews];
    
    //获取数据
    [self getData];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _originalNavigationControllerNavigationBarHidden = self.navigationController.navigationBar.hidden;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:_originalNavigationControllerNavigationBarHidden animated:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


-(void)variableInit{
    
}

- (void)getData{
    
}

- (void)reloadData{
    
}

#pragma mark ----setViews

- (void)setViews{
#pragma mark <#headerView#>
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self.view addHAlignConstraintToView:_tableView constant:0];
    [self.view addBottomAlignConstraintToView:_tableView constant:0];
    [self.navigationBarView addTopConstraintToView:_tableView constant:0];
}

#pragma mark - Event Response
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Methods

- (void)completionWithImage:(UIImage *)image{
    [self dismissViewControllerAnimated:NO completion:nil];
//    [self.navigationController popViewControllerAnimated:NO];
    if (self.shouldClip) {
        [self pushToRSKImageCropViewControllerWithImage:image];
    }else{
        if (_imagesCompletion) {
            _imagesCompletion(@[image]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


- (void)pushToRSKImageCropViewControllerWithImage:(UIImage *)image{
    
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.maskLayerStrokeColor = [UIColor whiteColor];
    imageCropVC.applyMaskToCroppedImage = YES;
    imageCropVC.avoidEmptySpaceAroundImage = YES;
    imageCropVC.cropMode = RSKImageCropModeCustom;
    imageCropVC.delegate = self;
    imageCropVC.dataSource = self;
    [self.navigationController pushViewController:imageCropVC animated:NO];
}


#pragma mark - UITableViewDelegate & tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        BOOL permission = [UIApplication photoPermissionWithAlert:YES handler:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self presentToTZPicker];
            }
        }];
        
        if (permission) {
            [self presentToTZPicker];
        }
//        PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
//        if ( authorStatus == PHAuthorizationStatusDenied ) {
//            [self showAlertWithTitle:@"没有权限" message:@"没有访问您相册的权限,请打开相机访问权限" confirmHandler:nil];
//            return;
//        }
    }else{
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
//            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//            if (authStatus == AVAuthorizationStatusDenied){
//                [self showAlertWithTitle:@"没有权限" message:@"没有访问您相机的权限,请打开相机访问权限后" confirmHandler:nil];
//                return;
//            }
        }
    }
}

- (void)presentToTZPicker{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.limitCount delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.autoDismiss = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.maxImagesCount = _limitCount;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPreview = NO;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:nil];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)presentToPicker{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    //资源类型为照相机
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = view;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"从相册选择";
    }else{
        cell.textLabel.text = @"拍一张图片";
    }
    
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    //获取视频data
//    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
//    DDDLog(@"---%@",videoURL);
    //    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    //    DDDLog(@"***%@",videoData);
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (_limitCount >= 1) {
//        CGSize size = image.size;
//        CGFloat height = size.height;
//        CGFloat width = size.width;
//        if (height > 1000 || width > 1000) {
//            CGFloat scale = MAX(height / 1000 , width / 1000);
//            image = [image imageByResizeToSize:CGSizeMake(width / scale, height / scale)];
//        }
        [self completionWithImage:image];
    }
    
}

//链接：http://www.jianshu.com/p/1eeaec2ae0fa
//+ (void) convertVideoWithModel:(RZProjectFileModel *) model
//{
//    model.filename = [NSString stringWithFormat:@"%ld.mp4",RandomNum];
//    //保存至沙盒路径
//    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *videoPath = [NSString stringWithFormat:@"%@/Image", pathDocuments];
//    model.sandBoxFilePath = [videoPath stringByAppendingPathComponent:model.filename];
//
//    //转码配置
//    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:model.assetFilePath options:nil];
//    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
//    exportSession.shouldOptimizeForNetworkUse = YES;
//    exportSession.outputURL = [NSURL fileURLWithPath:model.sandBoxFilePath];
//    exportSession.outputFileType = AVFileTypeMPEG4;
//    [exportSession exportAsynchronouslyWithCompletionHandler:^{
//        int exportStatus = exportSession.status;
//        RZLog(@"%d",exportStatus);
//        switch (exportStatus)
//        {
//            case AVAssetExportSessionStatusFailed:
//            {
//                // log error to text view
//                NSError *exportError = exportSession.error;
//                DDLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
//                break;
//            }
//            case AVAssetExportSessionStatusCompleted:
//            {
//                RZLog(@"视频转码成功");
//                NSData *data = [NSData dataWithContentsOfFile:model.sandBoxFilePath];
//                model.fileData = data;
//            }
//        }
//    }];
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (_limitCount == 1) {
        UIImage *image = [photos firstObject];
        [self completionWithImage:image];
    }else if(_imagesCompletion){
        _imagesCompletion(photos);
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(nonnull UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle{
    if (_imagesCompletion) {
        _imagesCompletion([NSArray arrayWithObject:croppedImage]);
    }
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    int controllerCount = (int)self.navigationController.viewControllers.count;
    [self.navigationController popToViewController:self.navigationController.viewControllers[controllerCount - 3] animated:YES];
    
}

#pragma mark 辅助方法

- (CGRect)getRect{
    //
    if (self.imageSize.width == 0 || self.imageSize.height == 0) {
        self.imageSize = CGSizeMake(kScreenWidth, kScreenWidth);
    }
    
    CGFloat scale = MIN(kScreenWidth / self.imageSize.width, kScreenHeight / self.imageSize.height);
    CGSize scaleSize = CGSizeMake(scale * self.imageSize.width, scale * self.imageSize.height);
    CGRect rect = CGRectMake(self.view.centerX - scaleSize.width / 2.0, self.view.centerY - scaleSize.height / 2.0, scaleSize.width, scaleSize.height);
    return rect;
}



@end
