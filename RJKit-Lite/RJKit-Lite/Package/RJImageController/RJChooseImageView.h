//
//  RJChooseImageView.h
//  diling
//
//  Created by shenruijie on 2018/1/27.
//  Copyright © 2018年 diling. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RJRecordVC.h"
#import "RJImage.h"

@class RJChooseImageView;

typedef enum : NSUInteger {
    RJChooseImageViewStyleWhite,
    RJChooseImageViewStyleGray,
} RJChooseImageViewStyle;

typedef NS_ENUM(NSUInteger, RJChooseImageViewType) {
    RJChooseImageViewTypeNone,
    RJChooseImageViewTypeImage,
    RJChooseImageViewTypeVideo,
};


typedef void (^RJChooseAssetsBlock)(NSArray<RJImage *> *array, NSInteger index);
typedef BOOL (^RJChooseAssetsShouldAddBlock)();

@protocol RJChooseImageViewDelegate <NSObject>

@end
/**RJ 2019-02-15 00:00:50 不需要用Controller,可以用View*/
@interface RJChooseImageView : UIView

/**
 */
@property (nonatomic, strong) NSMutableArray<RJImage *> *images;

/**
 用来保存最原始的数据
 */
@property (nonatomic, copy, readonly) NSArray<RJImage *> *tempArray;

/**
 UIImage类型的数组,
 */
//@property (nonatomic, strong, readonly) NSMutableArray<RJImage *> *resultImages;

/**
 保存删除的图片的ID
 */
@property (nonatomic, strong) NSMutableArray *deleteIndexs;

/**
 保存新加入的图片,tag = 1
 */
@property (nonatomic, strong) NSMutableArray<RJImage *> *addImages;

/**shenruijie 2018-04-24 16:18:02 主图,默认图,预设图片*/
@property (nonatomic, strong) RJImage *mainImage;

/**
 已经上传了的数量
 */
@property (nonatomic, assign) NSInteger operationCount;

/**
 用来记录原始的图片数组,编辑图片的时候有用
 */
//@property (nonatomic, strong, readonly) NSArray *tempArray;

/**
 是否可以删除图片,默认为NO
 */
@property (nonatomic, assign) BOOL shouldEdit;

@property (nonatomic, assign) RJChooseImageViewType assetsPickerType;

@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;


//@property (nonatomic, strong) RJQiniuVideoInfo *videoInfo;

/**
 是否有添加按钮,默认为YES
 */
@property (nonatomic, assign) BOOL shouldAdd;

/**shenruijie 2018-04-22 15:14:48 是否显示下面的小label,default NO*/
@property (nonatomic, assign) BOOL showTip;

@property (nonatomic, assign) NSInteger maxCount;

/**展示图片Cell的size*/
@property (nonatomic, assign) CGSize cellSize;

/**RJ 2019-02-15 21:23:29 cell圆角大小,默认0*/
@property (nonatomic, assign) CGFloat cellCorneradius;

/**切图大小*/
@property (nonatomic, assign) CGSize imageClipSize;

/**
 四周边距
 */
@property (nonatomic, assign) UIEdgeInsets marginInset;

@property (nonatomic, copy) RJChooseAssetsBlock didDeleteImageBlock;

/**RJ 2019-02-14 13:38:40 是否允许添加内容,实现该block可以拦截"+"号点击事件*/
@property (nonatomic, copy) BOOL (^shouldAddImageBlock)(NSArray<RJImage *> *array, NSInteger index);
@property (nonatomic, copy) RJChooseAssetsBlock didSelectImageBlock;
@property (nonatomic, copy) RJChooseAssetsBlock didAddImageBlock;
@property (nonatomic, copy) RJChooseAssetsShouldAddBlock shouldAddBlock;

@property (nonatomic, assign) RJChooseImageViewStyle style;

@property (nonatomic,weak) id<RJChooseImageViewDelegate> delegate;

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection;

- (instancetype)initWithImages:(NSMutableArray *)images style:(RJChooseImageViewStyle)style scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

/**RJ 2019-02-14 13:41:30 调用该方法将直接进入选择图片的controller*/
- (void)pickImage;

- (void)reloadData;


@end
