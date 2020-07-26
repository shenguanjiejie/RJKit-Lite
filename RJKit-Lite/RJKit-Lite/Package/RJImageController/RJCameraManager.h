//
//  RJCameraManager.h
//  kisshappy
//
//  Created by shenruijie on 2018/4/17.
//  Copyright © 2018年 shenguanjiejie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJImage.h"

typedef void (^rj_cameraManagerCompletionBlock)(RJImage *image);

@interface RJCameraManager : NSObject

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

@property (nonatomic, strong) rj_cameraManagerCompletionBlock cameraManagerCompletionBlock;

- (void)presentCameraController;
@end
