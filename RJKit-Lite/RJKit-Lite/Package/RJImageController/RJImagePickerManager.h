//
//  RJImagePickerManager.h
//  AppKing
//
//  Created by shenruijie on 2018/4/10.
//  Copyright © 2018年 shenruijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"
#import "RJImage.h"

typedef void (^rj_imagePickerCompletionBlock)(NSArray<RJImage *> *images);

@interface RJImagePickerManager : NSObject

@property (nonatomic, strong) TZImagePickerController *pickerController;

/**
 *  限制的图片数量,默认为1
 */
@property (assign, nonatomic) NSInteger limitCount;

/**
 *  已经选中了的图片的数量
 */
//@property (assign, nonatomic) int selectedNum;

/**
 是否需要裁剪
 */
@property (nonatomic, assign) BOOL shouldClip;

/**
 *  剪切图片的大小
 */
@property (nonatomic, assign) CGSize imageSize;

/**
 *  是否要切成圆形图片
 */
@property (nonatomic, assign) BOOL shouldClipToCircle;


@property (nonatomic, copy) rj_imagePickerCompletionBlock imagePickerCompletionBlock;
@property (nonatomic, copy) dispatch_block_t imagePickerCancelBlock;


-(instancetype)initWithCompletion:(void (^)(RJImage * image))completion;

-(instancetype)initWithLimitCount:(NSInteger)limitCount completion:(rj_imagePickerCompletionBlock)completion;

- (void)presentPickerController;

@end
