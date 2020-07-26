//
//  RJChooseImageView.m
//  ruijie
//
//  Created by shenruijie on 2018/1/27.
//  Copyright © 2018年 shenruijie. All rights reserved.
//

//#import "MWPhotoBrowser.h"
#import "RJChooseImageView.h"
#import "RJImageCollectionCell.h"
#import "RJImagePickerManager.h"
#import "TBActionSheet.h"

#import "RJKitLitePch.h"
#import "YBImageBrowser.h"
//#import "RJVideoVC.h"
//#import "YYCache+Qiniu.h"
/**RJ 2019-02-28 17:48:16 -*/
//#import <UMengUShare/UMSocialWechatHandler.h>


@interface RJChooseImageView ()<UICollectionViewDelegate,UICollectionViewDataSource,TBActionSheetDelegate,YBImageBrowserDelegate,YBImageBrowserDataSource,UICollectionViewDragDelegate,UICollectionViewDropDelegate>
{
    TBActionSheet *_sheet;
    
//    RJVideoVC *_videoVC;
    //    UIImage *_addImage;
    //用来保存原始的数据,因为_images会被请求到图片后替换为图片
}

/** 记录拖拽的 indexPath */
@property (nonatomic, strong) NSIndexPath *dragIndexPath;

@property (nonatomic, strong) YBImageBrowser *imageBrowser;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RJChooseImageView
#pragma mark - Life Cycle


- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    return [self initWithImages:[NSMutableArray array] style:RJChooseImageViewStyleWhite scrollDirection:scrollDirection];
}

- (instancetype)initWithImages:(NSMutableArray *)images style:(RJChooseImageViewStyle)style scrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        if (_images) {
            _images = images;
            _tempArray = [images copy];
//            _resultImages = [images mutableCopy];
        }else{
            _images = [NSMutableArray array];
            _tempArray = [NSMutableArray array];
//            _resultImages = [NSMutableArray array];
        }
        
        //        _mutableImages = [_images mutableCopy];
        _style = style;
        _scrollDirection = scrollDirection;
        
        if (_style == RJChooseImageViewStyleWhite) {
            self.backgroundColor = [UIColor whiteColor];
        }else{
            self.backgroundColor = kBackgroundColor;
        }
        
        //初始化参数
        [self variableInit];
        
        //设置Views
        [self setViews];
    }
    return self;
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//
//
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self parentViewController].navigationController.delegate = nil;
//    [self parentViewController].navigationController.navigationBar.hidden = YES;
//}


-(void)variableInit{
    _shouldAdd = YES;
    _maxCount = 9;
    _cellSize = CGSizeMake(100, 100);
    _marginInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _deleteIndexs = [NSMutableArray array];
    _addImages = [NSMutableArray array];
}

#pragma mark ----setViews

- (void)setViews{
    /**RJ 2019-01-15 18:38:16 注释下一行*/
//    _videoVC = [[RJVideoVC alloc] init];
    //    _videoVC.transitionAnimator = [[RJPushTransitionAnimator alloc]init];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = _scrollDirection;
    //定义行和列之间的间距
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 5.0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    //    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[RJImageCollectionCell class] forCellWithReuseIdentifier:@"RJImageCollectionCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // 为collectionView添加长按手势。
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(reorderCollectionView:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
#if 0
    /**RJ 2019-02-16 13:26:36 drag&drop*/
    _collectionView.dragInteractionEnabled = YES;
    _collectionView.dragDelegate = self;
    _collectionView.dropDelegate = self;
    /**RJ 2019-02-16 13:27:59
        这是 CollectionView 独有的属性，因为 其独有的二维网格的布局，因此在重新排序的过程中有时候会发生元素回流了，有时候只是移动到别的位置，不想要这样的效果，就
     * Reordering cadence 重排序节奏 可以调节集合视图重排序的响应性，当它打乱顺序并回流其布局时
     * 默认值是 UICollectionViewReorderingCadenceImmediate. 当开始移动的时候就立即回流集合视图布局，可以理解为实时的重新排序
     * UICollectionViewReorderingCadenceFast 如果你快速移动，CollectionView 不会立即重新布局，只有在停止移动的时候才会重新布局
     */
    _collectionView.reorderingCadence = UICollectionViewReorderingCadenceImmediate;
    /**RJ 2019-02-16 13:28:29
        弹簧加载是一种导航和激活控件的方式，在整个系统中，当处于 dragSession 的时候，只要悬浮在cell上面，就会高亮，然后就会激活
     * UITableView 和 UICollectionView 都可以使用该方式加载，因为他们都遵守 UISpringLoadedInteractionSupporting 协议
     * 当用户在单元格使用弹性加载时，我们要选择 CollectionView 或tableView 中的 item 或cell
     * 使用 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSpringLoadItemAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos); 来自定义也是可以的
     */
    _collectionView.springLoaded = YES;
#endif
    [self addSubview:_collectionView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
    NSDictionary *metrics = @{@"top":@(_marginInset.top),@"left":@(_marginInset.left),@"bottom":@(_marginInset.bottom),@"right":@(_marginInset.right)};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[_collectionView]-right-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_collectionView]-bottom-|" options:0 metrics:metrics views:views]];
}

#pragma mark - Event Response

// 长按手势响应方法。
- (void)reorderCollectionView:(UILongPressGestureRecognizer *)longPressGesture {
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:{
            // 手势开始。
            CGPoint touchPoint = [longPressGesture locationInView:self.collectionView];
            NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
            if (selectedIndexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            // 手势变化。
            CGPoint touchPoint = [longPressGesture locationInView:self.collectionView];
            NSIndexPath *endIndexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
            /**RJ 2019-02-16 14:32:49 不许移动到加号*/
            if (endIndexPath.row == self.images.count) {
                break;
            }
            
            [self.collectionView updateInteractiveMovementTargetPosition:touchPoint];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            // 手势结束。
            [self.collectionView endInteractiveMovement];
            break;
        }
        default:{
            [self.collectionView cancelInteractiveMovement];
            break;
        }
    }
}

- (void)deleteImage:(UIButton *)button{
    
    RJImage *rj_image = _images[button.tag];
    
    if ([_tempArray containsObject:rj_image]) {
        // 如果删除的是最初的图片,则使用_deleteIndexs记录
        [_deleteIndexs addObject:@([_tempArray indexOfObject:rj_image])];
    }else{
        if ([_addImages containsObject:rj_image]) {
            // 如果删除的不是最初的,而是新加入的,则删掉_addImages中该图片的记录
            [_addImages removeObject:rj_image];
        }
    }
    
    [_images removeObjectAtIndex:button.tag];
    _mainImage = _images.firstObject;
//    [_resultImages removeObjectAtIndex:button.tag];
    
    /**shenruijie 2018-01-23 09:59:16 删除最后一项后,将状态重置为None 因为不同地方的需求不同,所以如果需要这样的处理,最好是用block自己做相关处理*/
    //    if (!button.tag) {
    //        self.assetsPickerType = RJChooseImageViewTypeNone;
    //    }
    
    if (self.didDeleteImageBlock) {
        self.didDeleteImageBlock(_images, button.tag);
    }
    
    [_collectionView reloadData];
}

#pragma mark - Private Methods

#if 0
- (void)setAddImage{
    
    if (_images.count >= _maxCount && _mutableImages.lastObject == _addImage) {
        // 图片个数大于最大值,且_mutableImages中存在addImage
        [_mutableImages removeLastObject];
    }else if (_images.count < _maxCount && _mutableImages.lastObject != _addImage){
        // 图片个数少于最大值,且_mutableImages中不存在addImage
        [_mutableImages addObject:_addImage];
    }
}
#endif

#pragma mark - Public Methods
- (void)reloadData{
    [_collectionView reloadData];
}


- (void)setImages:(NSMutableArray<RJImage *> *)images{
    if (_images == images) {
        return;
    }
    
    if (!_images) {
        _images = [NSMutableArray array];
    }
    
    _images = images;
    _tempArray = [images copy];
//    _resultImages = [images mutableCopy];
    [_deleteIndexs removeAllObjects];
    if (images.firstObject) {
        self.mainImage = images.firstObject;
    }
    [_collectionView reloadData];
#if 0
    _mutableImages = [_images mutableCopy];
    if (_images.count < _maxCount) {
        if (_style == RJChooseImageViewStyleWhite) {
            [_mutableImages addObject:[UIImage imageNamed:@"StoreEditAddImagePlaceHolder"]];
        }else{
            [_mutableImages addObject:[UIImage imageNamed:@"StoreAddPhotoImage"]];
        }
    }
#else
    
#endif
}

- (void)setStyle:(RJChooseImageViewStyle)style{
    if (_style == style) {
        return;
    }
    
    _style = style;
    if (style == RJChooseImageViewStyleWhite) {
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = kBackgroundColor;
    }
    
}

- (void)setMaxCount:(NSInteger)maxCount{
    if (_maxCount == maxCount) {
        return;
    }
    _maxCount = maxCount;
    
    [_collectionView reloadData];
    //    [self setAddImage];
}

- (void)pickImage{
    if (self.shouldAddBlock && !self.shouldAddBlock()) {
        return;
    }
    NSInteger limit = 1;
    if (CGSizeEqualToSize(self.imageClipSize, CGSizeZero)) {
        limit = self.maxCount - _images.count;
    }
    @weakify(self)
    RJImagePickerManager *pickerVC = [[RJImagePickerManager alloc] initWithLimitCount:limit completion:^(NSArray<RJImage *> *images) {
        @strongify(self)
        for (RJImage *rj_image in images) {
//            rj_image.tag = 1;
        }
        [self.images addObjectsFromArray:images];
//        [self.resultImages addObjectsFromArray:rj_images];
        [self.addImages addObjectsFromArray:images];
        
        /**shenruijie 2018-04-22 15:32:37 如果之前没有其他图片,那么要将选的图片中的第一张置为main*/
        if (self.images.count == images.count) {
            self.mainImage = self.images.firstObject;
        }
        
        [self.collectionView reloadData];
        if (self.assetsPickerType != RJChooseImageViewTypeImage) {
            self.assetsPickerType = RJChooseImageViewTypeImage;
        }
        
        if (self.didAddImageBlock) {
            self.didAddImageBlock(self.images,self.images.count);
        }
    }];
    pickerVC.imageSize = self.imageClipSize;
    if (!CGSizeEqualToSize(self.imageClipSize, CGSizeZero)) {
        pickerVC.shouldClip = YES;
    }
    [pickerVC presentPickerController];
}

#pragma mark - UICollectionViewDelegates
#pragma mark ---- UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!self.shouldAdd) {
        return _images.count;
    }
    
    if (_images.count >= _maxCount) {
        return _maxCount;
    }
    if (!self.shouldEdit) {
        return _images.count;
    }
    return _images.count + 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"RJImageCollectionCell";
    RJImageCollectionCell * cell = (RJImageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = self.cellCorneradius;
    cell.clipsToBounds = YES;
    
    if (indexPath.row == _images.count) {
        cell.tipLab.hidden = YES;
        if (_style == RJChooseImageViewStyleWhite) {
            cell.imageView.image = kImageNamed(add_image);
        }else{
            cell.imageView.image = kImageNamed(add_image);
        }
        cell.deleteBtn.hidden = YES;
        cell.playImageView.hidden = YES;
    }else{
        RJImage *rj_image = _images[indexPath.row];
        if (rj_image.image) {
            cell.imageView.image = rj_image.image;
        }else{
            [cell.imageView sd_setImageWithURL:rj_image.url placeholderImage:kPlaceholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (image) {
                    rj_image.image = image;
                }
            }];
//            [cell.imageView sd_setImageWithURL:rj_image.url.mj_url placeholderImage:kPlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                if (image) {
//                    rj_image.image = image;
//                }
//            }];
        }
        
        cell.playImageView.hidden = !(self.assetsPickerType == RJChooseImageViewTypeVideo);
        
        if (self.shouldEdit) {
            cell.deleteBtn.tag = indexPath.row;
            [cell.deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteBtn.hidden = NO;
        }else{
            cell.deleteBtn.hidden = YES;
        }
        
        if (self.showTip && rj_image == self.mainImage) {
            cell.tipLab.hidden = NO;
        }else{
            cell.tipLab.hidden = YES;
        }
    }
    
    return cell;
}

#pragma mark ----UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellSize;
}

//定义每个UICollectionViewCell 的 inset
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark ---- UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _images.count) {
        if (self.shouldAddImageBlock) {
            if (!self.shouldAddImageBlock(_images, indexPath.row)){
                return;
            }
        }
        
        if (self.assetsPickerType == RJChooseImageViewTypeNone) {
            _sheet = [[TBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:kLocalString(cancel) destructiveButtonTitle:nil otherButtonTitles:@"添加图片",@"添加视频", nil];
            [_sheet show];
        }else if (self.assetsPickerType == RJChooseImageViewTypeImage){
            [self pickImage];
        }else if (self.assetsPickerType == RJChooseImageViewTypeVideo){
            
        }
        return;
    }
    
    /**shenruijie 2018-04-22 15:19:32 修改主图*/
    RJImage *rj_image = _images[indexPath.row];
    if (self.showTip && rj_image != self.mainImage) {
        self.mainImage = rj_image;
        [self.collectionView reloadData];
    }
    
    if (self.didSelectImageBlock) {
        self.didSelectImageBlock(_images,indexPath.row);
        return;
    }
    
    /**RJ 2019-01-15 18:38:48 // */
    // 预览视频
//    if (self.assetsPickerType == RJChooseImageViewTypeVideo) {
//        RJImageCollectionCell *cell = (RJImageCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        UMShareVideoObject *shareObject = [[UMShareVideoObject alloc] init];
//        shareObject.videoUrl = self.videoInfo.url;
//        shareObject.thumbImage = cell.imageView.image;
//        _videoVC.transitionHelper.transitionView = cell.imageView;
//        _videoVC.shareObject = shareObject;
//        //        [self parentViewController].navigationController.delegate = _videoVC.transitionHelper;
//        //        [[self parentViewController].navigationController pushViewController:_videoVC animated:YES];
//        [[self parentViewController] presentViewController:_videoVC animated:YES completion:nil];
//        return;
//    }
    
#if 0
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    [browser setCurrentPhotoIndex:indexPath.row];
    [[self parentViewController].navigationController pushViewController:browser animated:YES];
#else
    _imageBrowser = [[YBImageBrowser alloc] init];
    _imageBrowser.delegate = self;
    _imageBrowser.dataSource = self;
//    _imageBrowser. = 0.3;
    _imageBrowser.currentPage = indexPath.row;
    [_imageBrowser show];
#endif
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

// 是否允许移动item。
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    /**RJ 2019-02-16 14:06:03 不允许移动加号*/
    if (indexPath.row == self.images.count) {
        return NO;
    }
    return YES;
}

// 更新数据源。
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    /**RJ 2019-02-16 14:07:03 不允许移动到加号*/
    if (destinationIndexPath.row == self.images.count) {
        return;
    }
    /**RJ 2019-02-16 14:10:08 这里还没有考虑编辑的时候tempArray的处理,将来要实现的,不然会混乱,这里有点麻烦*/
    RJImage *image = [self.images objectAtIndex:sourceIndexPath.item];
    [self.images removeObjectAtIndex:sourceIndexPath.item];
    [self.images insertObject:image atIndex:destinationIndexPath.item];
    // 重新加载当前显示的item。
    [collectionView reloadItemsAtIndexPaths:[collectionView indexPathsForVisibleItems]];
}

/* 提供一个 给定 indexPath 的可进行 drag 操作的 item（类似 hitTest: 方法周到该响应的view ）
 * 如果返回 nil，则不会发生任何拖拽事件
 */
//- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
//
//    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:self.dataSource[indexPath.item]];
//    //    itemProvider.preferredPresentationSize
//    //    session.progressIndicatorStyle = UIDropSessionProgressIndicatorStyleNone;
//
//    [itemProvider registerItemForTypeIdentifier:kItemForTypeIdentifier loadHandler:^(NSItemProviderCompletionHandler  _Null_unspecified completionHandler, Class  _Null_unspecified __unsafe_unretained expectedValueClass, NSDictionary * _Null_unspecified options) {
//
//    }];
//
//    //    itemProvider registerDataRepresentationForTypeIdentifier:<#(nonnull NSString *)#> visibility:<#(NSItemProviderRepresentationVisibility)#> loadHandler:<#^NSProgress * _Nullable(void (^ _Nonnull completionHandler)(NSData * _Nullable, NSError * _Nullable))loadHandler#>
//
//    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
//    self.dragIndexPath = indexPath;
//    return @[item];
//}
//


#pragma mark - YBImageBrowserDataSource

- (NSInteger)yb_numberOfCellsInImageBrowser:(YBImageBrowser *)imageBrowser{
    return self.images.count;
}

- (id<YBIBDataProtocol>)yb_imageBrowser:(YBImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index{
    YBIBImageData *data = [YBIBImageData new];
    RJImage *rj_image = self.images[index];
    
    RJImageCollectionCell *cell = (RJImageCollectionCell *)[_collectionView cellForItemAtIndexPath:kIndexPath(0, index)];
    data.projectiveView = cell.imageView;
    data.thumbImage = rj_image.image;
    if (rj_image.image) {
        data.image = ^UIImage * _Nullable{
            return rj_image.image;
        };
    }else if (rj_image.url){
        data.imageURL = [NSURL URLWithString:rj_image.url];
    }
    
    return data;
}

#if 0
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    if (_images.count > _maxCount) {
        return _maxCount;
    }
    
    return _images.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    RJImage *rj_image = _images[index];
    if (rj_image.image) {
        return [MWPhoto photoWithImage:rj_image.image];
    }else {
        return [MWPhoto photoWithURL:[NSURL URLWithString:rj_image.url]];
    }
    
    return [[MWPhoto alloc] init];
}


//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    DDDLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    DDDLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}


//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    //    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    DDDLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    DDDLog(@"Did finish modal presentation");
//    [self dismissViewControllerAnimated:YES completion:nil];
}
#endif

#pragma mark - TBActionSheetDelegate

- (void)actionSheet:(TBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"click button:%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        [self pickImage];
    }else if (buttonIndex == 1){
        /**RJ 2019-01-15 22:01:41 //*/
//        RJRecordVC *recordVC = [[RJRecordVC alloc] init];
//        @weakify(self)
//        kSatellite.uploadVideoSuccessBlock = ^(RJQiniuVideoInfo *videoInfo) {
//            @strongify(self)
//            self.videoInfo = videoInfo;
//            [Tools getVideoPreViewImageWithUrl:videoInfo.url placeholderImage:nil completion:^(UIImage *image) {
//                if (image) {
//                    self.maxCount = 1;
//                    self.shouldEdit = NO;
//                    self.images = [@[[RJImage rj_imageWithImage:image]] mutableCopy];
//                    self.assetsPickerType = RJChooseImageViewTypeVideo;
//                }
//            }];
//        };
//        [self presentViewController:recordVC animated:YES completion:nil];
    }
}

- (void)actionSheet:(TBActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"willDismiss");
}

- (void)actionSheet:(TBActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"didDismiss");
}


@end
