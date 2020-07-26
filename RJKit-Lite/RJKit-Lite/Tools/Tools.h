//
//  Tools.h
//  deyue
//
//  Created by ShenRuijie on 2017/6/17.
//  Copyright © 2017年 mikeshen. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RMessageView.h"
//#import "RJBaseCellInfo.h"
#import <RJVFL/UIView+RJVFL.h>
#import <SDWebImage/SDWebImage.h>
#import "UIImageView+WebCache.h"
#import "YYCategories.h"
#import "IQKeyboardManager.h"

#define kLocalString(key) [Tools localizedStringForKey:@#key value:nil]

typedef void (^RJTimerBlock)(NSTimer *timer,NSString *timeString);

@interface Tools : NSObject

+ (CGFloat)safeTop;
+ (CGFloat)safeBottom;

/**获得顶部的controller*/
+ (UIViewController *)topViewController;
+ (UIViewController *)topViewControllerWithoutModel;

/**计算文本的size*/
+ (CGSize)boundingRectWithString:(id)string font:(UIFont*) font size:(CGSize) size;

/**计算一个string的字数,两个字母算一个字*/
+ (NSInteger)countWithString:(NSString *)string;

/**拨打电话号码*/
+(void)callPhone:(NSString *)phoneNum;

/**设置button文字在下,图片在上*/
+ (void)verticalImageAndTitleButton:(UIButton *)button spacing:(CGFloat)spacing;

/**RJ 2019-01-17 13:08:26 button文字在上,图片在下*/
+ (void)verticalTitleAndImageButton:(UIButton *)button spacing:(CGFloat)spacing;

/**设置button图片在右边*/
+ (void)rightImageButton:(UIButton *)button spacing:(CGFloat)spacing;

/**字节转为字符串*/
+ (NSString *)stringWithBytes:(int64_t)bytes;

/**shenruijie 2018-03-03 20:12:10 根据距离返回字符串
    @param distance 单位千米
 */
+ (NSString *)distanceStringWithDistance:(CGFloat)distance;

/**打开appStore*/
+ (void)openAppStoreWithAppUrl:(NSString *)url;

/**textView的textDidChange代理方法中进行调用*/
+ (void)limitTextWithTextView:(UITextView *)textView limit:(NSInteger)limit;

/**获取视频第一帧图片*/
+ (void)getVideoPreViewImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image))completion;

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

/**给UILabel设置行间距和字间距*/
+ (void)setLabel:(UILabel *)label space:(CGFloat)space text:(NSString *)text font:(UIFont *)font;

/**强制调整屏幕转向*/
+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation;
/**
 计算富文本字体高度

 @param string string
 @param lineSpeace 行高
 @param font 字体
 @param width 字体所占宽度
 @return 富文本高度
 */
+(CGFloat)getSpaceLabelHeightwithString:(NSString *)string speace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

/**图片高斯模糊*/
+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

//+ (RMessageView *)showRMessageViewWithTitle:(NSString *)title;

/**压缩图片*/
+ (NSData *)compressImage:(UIImage *)image lessThan:(NSUInteger)maxLength newImageBlock:(void (^)(UIImage *newImage))newImageBlock;

/**RJ 2020-05-09 16:46:56 // */
//+ (UIImageView *)setLeftStarForCell:(UITableViewCell *)cell info:(RJBaseCellInfo *)info;

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

/**
 button倒计时
 @param title 原本的title,也是倒计时结束的title
 @param time 倒计时s数
 @param block 拿到timer后可以进行自己的操作
 @return timer
 */
+ (NSTimer *)scheduledTimerWithButton:(UIButton *)button title:(NSString *)title time:(NSInteger)time block:(void (^)(NSTimer *timer))block;

/**
 label倒计时
 @param format 格式,%@为倒计时文本
 @param endTime 结束时间
 @param endText 结束后显示内容
 @param block 拿到timer后可以进行自己的操作
 @return timer
 */
+ (NSTimer *)scheduledTimerWithLabel:(UILabel *)label format:(NSString *)format endTime:(NSDate *)endTime endText:(NSString *)endText block:(RJTimerBlock)block;

+ (NSString *)lastCallMethod;

+ (NSString *)deviceModelName;

/**shenruijie 2018-06-11 18:27:14 返回数字的中文数字形式*/
+ (NSString *)chineseNumberWithLong:(long)number;

/**shenruijie 2018-06-17 11:46:42 搜索label*/
+ (UILabel *)searchLabelWithTapAction:(dispatch_block_t)tapAction;

/**shenruijie 2018-07-03 16:31:04 获得imageView中的图片的frame*/
+ (CGRect)imageFrameWithAspectFillImageView:(UIImageView *)imageView;

/**shenruijie 2018-07-03 16:31:04 获得imageView中的图片的frame*/
+ (CGRect)imageFrameWithAspectFitImageView:(UIImageView *)imageView;

/**RJ 2020-05-09 16:48:29 //*/
//+ (void)showChooseImageSheetWithTitle:(NSString *)title clipSize:(CGSize)size completionBlock:(rj_imagePickerCompletionBlock)completionBlock;
@end




