//
//  RJImagePickerVC.h
//  innerCloud
//
//  Created by Ruijie on 2017/3/28.
//  Copyright © 2017年 Ruijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJImagePickerVC : UIViewController

/**
 *  限制的图片数量
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

-(instancetype)initWithCompletion:(void (^)(UIImage * image))completion;

-(instancetype)initWithLimitCount:(NSInteger)limitCount completion:(void (^)(NSArray<UIImage *> * images))completion;
@end
