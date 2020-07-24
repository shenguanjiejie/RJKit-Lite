//
//  RJImage+Extension.h
//  diling
//
//  Created by shenruijie on 2019/1/15.
//  Copyright © 2019 shenguanjiejie. All rights reserved.
//

#import "RJImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJImage (Extension)<NSCoding>

//@property (nonatomic, assign) int dilingId;
//@property (nonatomic, assign) int commentId;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSIndexPath *indexPath;

//@property (nonatomic, copy) OSSNetworkingUploadProgressBlock ossProgressBlock;


/**
 用key数组获得url数组
 */
+ (NSArray<NSString *> *)urlsWithKeys:(NSArray<NSString *> *)keys radius:(CGFloat)radius;

/**
 用key数组获得缩略图url数组
 */
+ (NSArray<NSString *> *)thumbUrlsWithKeys:(NSArray<NSString *> *)keys radius:(CGFloat)radius;


@end

NS_ASSUME_NONNULL_END
