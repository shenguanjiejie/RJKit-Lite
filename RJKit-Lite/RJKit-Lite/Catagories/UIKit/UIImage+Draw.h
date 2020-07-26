//
//  UIImage+Draw.h
//  MTestM.iOS
//
//  Created by ShenRuijie on 15/2/28.
//  Copyright (c) 2015年 com.yuyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Header)

/**
 *  画圆头像
 *
 *  @param diameter 直径
 *
 *  @return 圆形图片
 */
- (nullable UIImage *)roundIconWithDiameter:(CGFloat)diameter;

/**
 *  画带边框的圆形头像
 *
 *  @param diameter    直径
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @param borderAlpha 边框透明度
 *
 *  @return 带有边框的圆形图片
 */
- (nullable UIImage *)roundIconWithDiameter:(CGFloat)diameter borderWidth:(CGFloat)borderWidth borderColor:(nonnull UIColor *)borderColor borderAlpha:(CGFloat)borderAlpha;

/**
 *  返回指定颜色的图片
 *
 *  @param color 背景色
 *  @param size  背景图大小
 *
 *  @return 对应背景色的图片
 */
+ (nullable UIImage *)imageWithColor:(nonnull UIColor *)color size:(CGSize)size;

/**
 *  拉伸图片
 *
 *  @param scale 拉伸比例
 *
 *  @return 拉伸后的图
 */
- (nullable UIImage *)imageWithScale:(CGFloat)scale;

/**
 Screen shot from view.
 */
+ (nullable UIImage *)imageFromView:(nonnull UIView *)theView withSize:(CGSize)size;

- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clipsToBounds;

+ (nullable UIImage *)imageWithQRImageView:(UIImage *_Nonnull)QRImage logoImage:(UIImage *_Nonnull)logoImage;

/**
 *  取得讨论组的头像
 *
 *  @param side        正方形头像的边长
 *  @param imageNames  参与讨论组的人的头像图片名
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 返回画出来的讨论组头像
 */
+ (nullable UIImage *)groupIconWithSide:(CGFloat)side imageNames:(nonnull NSArray *)imageNames borderWidth:(CGFloat)borderWidth borderColor:(nonnull UIColor *)borderColor;

/**
 *  取得讨论组的头像
 *
 *  @param side        正方形头像的边长
 *  @param userNumber  讨论组人数
 *  @param imageUrls  参与讨论组的人的头像url
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @param completion 取到头像后回调block
 *
 */
+ (void)drawGroupIconWithSide:(CGFloat)side imageUrls:(nonnull NSArray *)imageUrls borderWidth:(CGFloat)borderWidth borderColor:(nonnull UIColor *)borderColor completion:(nullable void (^)( UIImage * _Null_unspecified groupIcon))completion;

/**
 *  取得讨论组的头像
 *
 *  @param side        正方形头像的边长
 *  @param imageNames  参与讨论组的人的头像
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 返回画出来的讨论组头像
 */
+ (nullable UIImage *)groupIconWithSide:(CGFloat)side images:(nonnull NSArray *)images borderWidth:(CGFloat)borderWidth borderColor:(nonnull UIColor *)borderColor;

@end
