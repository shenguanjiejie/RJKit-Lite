//
//  Tools.m
//  deyue
//
//  Created by ShenRuijie on 2017/6/17.
//  Copyright © 2017年 mikeshen. All rights reserved.
//

#import "Tools.h"
#import "UIImageView+CornerRadius.h" 
#import "UIApplication+RJPermission.h"
#import <sys/utsname.h>
#import "NSDate+JKExtension.h"
#import "NSAttributedString+YYText.h"
#import "RJKitLitePch.h"
//#import <Luban_iOS/UIImage+Luban_iOS_Extension_h.h>

@implementation Tools

+ (CGFloat)safeTop{
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].delegate.window.safeAreaInsets.top?:20;
    } else {
        return 20;
    }
}

+ (CGFloat)safeBottom{
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
    } else {
        return 0;
    }
}


+(CGSize)boundingRectWithString:(id)string font:(UIFont*) font size:(CGSize) size{
    if (!string) {
        return CGSizeZero;
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    //    [style setLineSpacing:1.0f];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] init];
    if ([string isKindOfClass:[NSString class]]) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:string];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
        [style setLineSpacing:1.0];
    }else if ([string isKindOfClass:[NSAttributedString class]]){
        attributedString = string;
        [style setLineSpacing:attributedString.yy_lineSpacing];
    }
    
    CGSize realSize = CGSizeZero;
    CGRect textRect = [attributedString.string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style} context:nil];
    realSize = textRect.size;
    
    realSize.width = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
}

+ (NSInteger)countWithString:(NSString *)string{
    NSInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    length -= (length - string.length) / 2;
    return (length +1) / 2;
}

+(void)callPhone:(NSString *)phoneNum{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){//
//        [MBProgressHUD showTipMessageInView:@"当前设备不支持拨打电话" timer:2.0];
        return;
    }
    
    NSString *callPhone = [NSString stringWithFormat:@"tel:%@", phoneNum];
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 10.0) {
        /// 大于等于10.0系统使用此openURL方法
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callPhone]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        }
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callPhone]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }
}

+ (void)verticalImageAndTitleButton:(UIButton *)button spacing:(CGFloat)spacing{
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    if (button.widthConstraint) {
        button.widthConstraint.constant = MAX(titleSize.width, imageSize.width);
    }else{
        [button addWidthConstraintWithConstant:MAX(titleSize.width, imageSize.width)];
    }
    
    if (button.heightConstraint) {
        button.heightConstraint.constant = totalHeight;
    }else{
        [button addHeightConstraintWithConstant:totalHeight];
    }
}

+ (void)verticalTitleAndImageButton:(UIButton *)button spacing:(CGFloat)spacing{
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    button.imageEdgeInsets = UIEdgeInsetsMake((totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, (totalHeight - titleSize.height), 0);
    if (button.widthConstraint) {
        button.widthConstraint.constant = MAX(titleSize.width, imageSize.width);
    }else{
        [button addWidthConstraintWithConstant:MAX(titleSize.width, imageSize.width)];
    }
    
    if (button.heightConstraint) {
        button.heightConstraint.constant = totalHeight;
    }else{
        [button addHeightConstraintWithConstant:totalHeight];
    }
}

+ (void)rightImageButton:(UIButton *)button spacing:(CGFloat)spacing{
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    
//    spacing /= 2;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width - spacing ,0, imageSize.width + spacing)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width + spacing, 0, -titleSize.width - spacing)];
    
}

+ (NSString *)stringWithBytes:(int64_t)bytes{
    if (bytes < 1024 * 1024){
        return [NSString stringWithFormat:@"%.2fKB",bytes / 1024.0];
    }else{
        return [NSString stringWithFormat:@"%.2fMB",bytes / (1024 * 1024.0)];
    }
}

+ (NSString *)distanceStringWithDistance:(CGFloat)distance{
    NSInteger new = distance;
    if (new >= 1000){
        return [NSString stringWithFormat:@"%.2fkm",new/1000.0];
    }else{
        return [NSString stringWithFormat:@"%zdm",new];
    }
}

// A present B,A.presentedViewController = B,B.presentingViewController = A
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [Tools topViewControllerWithoutModel];
    while (resultVC.presentedViewController) {
        resultVC = [Tools _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [Tools _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [Tools _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+(UIViewController *)topViewControllerWithoutModel{
    return [Tools _topViewController:[[UIApplication sharedApplication].windows.firstObject rootViewController]];
}

+ (void)openAppStoreWithAppUrl:(NSString *)url{
    
    NSURL *appUrl = [NSURL URLWithString:url];
    
    if([[UIApplication sharedApplication] canOpenURL:appUrl]){
        if (kSystemVersion < 10) {
            [[UIApplication sharedApplication] openURL:appUrl];
        }else{
            [[UIApplication sharedApplication] openURL:appUrl options:@{} completionHandler:nil];
        }
    }else{
        [[Tools topViewController] showAlertWithTitle:@"打开AppStore失败" message:@"请手动前往AppStore下载更新 : )" confirmHandler:nil];
    }
}

+ (void)limitTextWithTextView:(UITextView *)textView limit:(NSInteger)limit{
    NSString *toBeString = textView.text;
    //获取高亮部分
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (limit > 0 && toBeString.length > limit)){
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:limit];
        if (rangeIndex.length == 1){
            textView.text = [toBeString substringToIndex:limit];
        }else{
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, limit)];
            NSInteger tmpLength;
            if (rangeRange.length > limit) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            textView.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}

+ (void)getVideoPreViewImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image))completion
{
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
    if (image) {
        if (completion) {
            completion(image);
        }
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        //要定制帧时间
        //    gen.requestedTimeToleranceAfter = CMTimeMake(<#int64_t value#>, <#int32_t timescale#>);
        //    gen.requestedTimeToleranceBefore = CMTimeMake(<#int64_t value#>, <#int32_t timescale#>);
        NSError *error = nil;
        CGImageRef image = [gen copyCGImageAtTime:CMTimeMakeWithSeconds(0, 10) actualTime:NULL error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *img = [[UIImage alloc] initWithCGImage:image];
            if (img) {
//                [[SDWebImageManager sharedManager].imageCache storeImage:img forKey:url];
                [[SDImageCache sharedImageCache] storeImage:img forKey:url completion:nil];
                if (completion) {
                    completion(img);
                }
            }else{
                if (completion) {
                    completion(placeholderImage);
                }
            }
            CGImageRelease(image);
        });
    });
}

+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

+ (void)setLabel:(UILabel *)label space:(CGFloat)space text:(NSString *)text font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
//        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    label.attributedText = attributeStr;
}

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
+(CGFloat)getSpaceLabelHeightwithString:(NSString *)string speace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

//+ (RMessageView *)showRMessageViewWithTitle:(NSString *)title{
//    RMessageView *view = [[RMessageView alloc] initWithDelegate:nil title:title subtitle:nil iconImage:nil type:RMessageTypeError customTypeName:@"error" duration:1 inViewController:[Tools topViewController] callback:nil buttonTitle:nil buttonCallback:nil atPosition:RMessagePositionTop canBeDismissedByUser:YES];
//    
//    view.backgroundColor = kYellowColor;
//    [view present];
//    return view;
//}


+ (NSData *)compressImage:(UIImage *)image lessThan:(NSUInteger)maxLength newImageBlock:(void (^)(UIImage *newImage))newImageBlock{
    // Compress by quality
    if (!image) {
        return nil;
    }
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (data.length < maxLength) return data;
    CGImageRef imageRef = [image CGImage];
    CGSize size = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    if (!width || !height) {
        return nil;
    }
    CGSize compressSize;
    CGFloat ratio = MAX(width / height, height / width);
    
    //    a，图片宽或者高均小于或等于1280时图片尺寸保持不变，但仍然经过图片压缩处理，得到小文件的同尺寸图片
    //    b，宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
    //    c，宽或者高大于1280，但是图片宽高比大于2时，并且宽以及高均大于1280，则宽或者高取小的等比压缩至1280
    //    d，宽或者高大于1280，但是图片宽高比大于2时，并且宽或者高其中一个小于1280，则压缩至同尺寸的小文件图片
    if (MAX(width, height) > 1280) {
        if (ratio > 2) {
            if (MIN(width, height) > 1280) {
                if (height > width) {
                    compressSize = CGSizeMake(1280, 1280 * ratio);
                }else{
                    compressSize = CGSizeMake(1280 * ratio, 1280);
                }
                image = [image imageByResizeToSize:compressSize contentMode:UIViewContentModeScaleAspectFill];
            }
        }else{
            if (height > width) {
                compressSize = CGSizeMake(1280 / ratio, 1280);
            }else{
                compressSize = CGSizeMake(1280, 1280 / ratio);
            }
            image = [image imageByResizeToSize:compressSize contentMode:UIViewContentModeScaleAspectFill];
        }
    }
    
    data = UIImageJPEGRepresentation(image, 0.5);
    image = [UIImage imageWithData:data];
//    data = UIImageJPEGRepresentation(image, 1);
//
//    for (NSInteger i = 0; i < 6; i++) {
//        if (data.length > maxLength) {
//            image = [UIImage imageWithData:data];
//            data = UIImageJPEGRepresentation(image, 0.83);
//        }
//    }
    
    if (newImageBlock) {
        newImageBlock(image);
    }
    return data;
}

/**RJ 2020-05-09 16:46:51 */
//+ (UIImageView *)setLeftStarForCell:(UITableViewCell *)cell info:(RJBaseCellInfo *)info{
//    UIImageView *imageView = [cell.contentView addImageViewWithImage:kImageNamed(add_service_star) contentMode:UIViewContentModeScaleAspectFit];
//    [cell.contentView addLeftAlignConstraintToView:imageView constant:2];
//    [cell.contentView addVAlignConstraintToView:imageView constant:0];
//    [imageView addWidthConstraintWithConstant:info.leftMargin - 4];
//    return imageView;
//}

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value
{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }
        
        // Get the top level "bundle" which may actually be the framework
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        // Check to see if the resource bundle exists inside the top level bundle
        bundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"RJKit" ofType:@"bundle"]];
        
        // 从MJRefresh.bundle中查找资源
//        bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
//        bundle = [NSBundle bundleWithIdentifier:@"RJKit"];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return value;
//    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

+ (NSTimer *)scheduledTimerWithButton:(UIButton *)button title:(NSString *)title time:(NSInteger)time block:(void (^)(NSTimer *timer))block{
    if (time <= 0) {
        [button setTitle:title forState:UIControlStateNormal];
        return nil;
    }
    button.userInteractionEnabled = NO;
    if (!button.backgroundColor) {
        button.backgroundColor = kLightGrayColor;
    }
    __block NSInteger tempTime = time;
    NSString *buttonTitle = button.titleLabel.text;
    
    [button setTitle:[NSString stringWithFormat:@"%zds",time] forState:UIControlStateNormal];
    UIColor *buttonBgColor = button.backgroundColor;
    button.backgroundColor = kLightGrayColor;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
        tempTime--;
        if (tempTime == 0) {
            button.userInteractionEnabled = YES;
            button.backgroundColor = buttonBgColor;
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            [timer invalidate];
            timer = nil;
        }else{
            NSString *timeTitle = [NSString stringWithFormat:@"%lds",(long)tempTime];
            [button setTitle:timeTitle forState:UIControlStateNormal];
        }
        if (block) {
            block(timer);
        }
    } repeats:YES];
    
    return timer;
}

// 苹果设备类型说明 ： https://www.theiphonewiki.com/wiki/Models

+ (NSString *)deviceModelName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    //simulator
    if ([platform isEqualToString:@"i386"])          return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";
    
    //AirPods
    if ([platform isEqualToString:@"AirPods1,1"])    return @"AirPods";
    
    //Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"])    return @"Apple TV (2nd generation)";
    if ([platform isEqualToString:@"AppleTV3,1"])    return @"Apple TV (3rd generation)";
    if ([platform isEqualToString:@"AppleTV3,2"])    return @"Apple TV (3rd generation)";
    if ([platform isEqualToString:@"AppleTV5,3"])    return @"Apple TV (4th generation)";
    if ([platform isEqualToString:@"AppleTV6,2"])    return @"Apple TV 4K";
    
    //Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])    return @"Apple Watch (1st generation)";
    if ([platform isEqualToString:@"Watch1,2"])    return @"Apple Watch (1st generation)";
    if ([platform isEqualToString:@"Watch2,6"])    return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,7"])    return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,3"])    return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch2,4"])    return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch3,1"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,2"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,3"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,4"])    return @"Apple Watch Series 3";
    
    //HomePod
    if ([platform isEqualToString:@"AudioAccessory1,1"])    return @"HomePod";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])    return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,2"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,3"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,4"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,5"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,6"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad4,1"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"])    return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])    return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,7"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,3"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,11"])    return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad6,12"])    return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad7,1"])    return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,2"])    return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,3"])    return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])    return @"iPad Pro (10.5-inch)";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad4,4"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])    return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])    return @"iPad mini 4";
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])     return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])     return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])     return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])     return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])     return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])     return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])     return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])     return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])     return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    //iPod touch
    if ([platform isEqualToString:@"iPod1,1"])    return @"iPod touch";
    if ([platform isEqualToString:@"iPod2,1"])    return @"iPod touch (2nd generation)";
    if ([platform isEqualToString:@"iPod3,1"])    return @"iPod touch (3rd generation)";
    if ([platform isEqualToString:@"iPod4,1"])    return @"iPod touch (4th generation)";
    if ([platform isEqualToString:@"iPod5,1"])    return @"iPod touch (5th generation)";
    if ([platform isEqualToString:@"iPod7,1"])    return @"iPod touch (6th generation)";
    
    return platform;
    
}

+ (NSTimer *)scheduledTimerWithLabel:(UILabel *)label format:(NSString *)format endTime:(NSDate *)endTime endText:(NSString *)endText block:(RJTimerBlock)block{
    
    __block NSInteger sec = [endTime timeIntervalSinceNow];
    if (sec <= 0) {
        label.text = endText;
        return nil;
    }
    
    label.text =[NSString stringWithFormat:format,[endTime descriptionIntervalSinceNow]];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
        sec--;
        if (sec == 0) {
            label.text = endText;
            [timer invalidate];
            timer = nil;
        }else{
            label.text =[NSString stringWithFormat:format,[endTime descriptionIntervalSinceNow]];
        }
        if (block) {
            block(timer,[endTime descriptionIntervalSinceNow]);
        }
    } repeats:YES];
    
    return timer;
}

+ (NSString *)lastCallMethod
{
    NSArray *symbols = [NSThread callStackSymbols];
    NSInteger maxCount = symbols.count;
    NSString *secondSymbol = maxCount > 2 ? symbols[2] : (maxCount > 1 ? symbols[1] : [symbols firstObject]);
    if (secondSymbol.length == 0) {
        return @"";
    }
    
    NSString *pattern = @"[+-]\\[.{0,}\\]";
    NSError *error;
    NSRegularExpression *express = [NSRegularExpression regularExpressionWithPattern:pattern options:kNilOptions error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        return @"";
    }
    
    NSTextCheckingResult *checkResult = [[express matchesInString:secondSymbol options:NSMatchingReportCompletion range:NSMakeRange(0, secondSymbol.length)] lastObject];
    NSString *findStr = [secondSymbol substringWithRange:checkResult.range];
    return findStr ?: @"";
}

+ (NSString *)chineseNumberWithLong:(long)number{
    int count = 0;
    NSInteger tempNum = number;
    NSDictionary *dict = @{@0:@"零",@1:@"一",@2:@"二",@3:@"三",@4:@"四",@5:@"五",@6:@"六",@7:@"七",@8:@"八",@9:@"九"};
    while(tempNum != 0){
        tempNum /= 10;
        ++count;
    }
    
    tempNum = number;
    
    NSString *str = @"";
    for (NSInteger i = count - 1; i >= 0; i --) {
        NSInteger num = tempNum / pow(10, i);
        if (num) {
            if (i) {
                if (i % 8 == 0) {
                    str = [NSString stringWithFormat:@"%@%@亿",str,tempNum == number?@"":dict[@(num)]];
                }else if (i % 4 == 0){
                    str = [NSString stringWithFormat:@"%@%@万",str,tempNum == number?@"":dict[@(num)]];
                }else if (i % 3 == 0){
                    str = [NSString stringWithFormat:@"%@%@千",str,tempNum == number?@"":dict[@(num)]];
                }else if (i % 2 == 0){
                    str = [NSString stringWithFormat:@"%@%@百",str,tempNum == number?@"":dict[@(num)]];
                }else {
                    str = [NSString stringWithFormat:@"%@%@十",str,tempNum == number?@"":dict[@(num)]];
                }
            }else if (tempNum){
                str = [NSString stringWithFormat:@"%@%@",str,dict[@(num)]];
            }
        }
        tempNum %= (NSInteger)pow(10, i);
    }
    
    return str;
}

+ (UILabel *)searchLabelWithTapAction:(dispatch_block_t)tapAction{
    UILabel *label = [[UILabel alloc]init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = kFontSize(13);
    label.textColor = kLightGrayColor;
//    label.text = @"搜索";
    label.layer.masksToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 16;
    label.backgroundColor = kBackgroundColor;
    label.userInteractionEnabled = YES;
    UITextField *textField = [label addTextFieldWithFont:kFontSize(13) textColor:kLightGrayColor text:nil keybordType:UIKeyboardTypeWebSearch];
    textField.placeholder = @"搜索";
    textField.tag = 100000;
    UIImageView *searchImageView = [label addImageViewWithImage:kImageNamed(searchBgLeftImage) contentMode:UIViewContentModeScaleAspectFit];
    [label addVAlignConstraintToView:searchImageView constant:8];
    [label addVAlignConstraintToView:textField constant:0];
    [searchImageView setSquareConstraint];
    
    [label addBunchConstraintsToViews:@[searchImageView,textField] constants:@[@15,@10,@15] direction:RJDirectionLeft];
    
//    [self.navigationBarView addTopConstraintToView:label constant:10];
//    [label addHeightConstraintWithConstant:32];
//    [self.view addHAlignConstraintToView:label constant:38];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if (tapAction) {
            tapAction();
        }
    }];
    [label addGestureRecognizer:tap];
    return label;
}


+ (CGRect)imageFrameWithAspectFillImageView:(UIImageView *)imageView{
    CGSize imageSize = imageView.intrinsicContentSize;
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    CGFloat scale = imageSize.width / imageSize.height;
    
    /**shenruijie 2018-06-29 16:31:41 图片真实frame*/
    if (scale > 1) {
        y = 0;
        height = imageView.size.height;
        width = height * scale;
        x = (imageView.size.width - width) / 2;
    }else{
        x = 0;
        width = imageView.size.width;
        height = width / scale;
        y = (imageView.size.height - height) / 2;
    }
    
    CGRect imageFrame = CGRectMake(x, y, width, height);
    return imageFrame;
}

+ (CGRect)imageFrameWithAspectFitImageView:(UIImageView *)imageView{
    CGSize imageSize = imageView.intrinsicContentSize;
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    CGFloat scale = imageSize.width / imageSize.height;
    
    /**shenruijie 2018-06-29 16:31:41 图片真实frame*/
    if (scale > 1) {
        x = 0;
        width = imageView.size.width;
        height = width / scale;
        y = (imageView.size.height - height) / 2;
    }else{
        y = 0;
        height = imageView.size.height;
        width = height * scale;
        x = (imageView.size.width - width) / 2;
    }
    
    CGRect imageFrame = CGRectMake(x, y, width, height);
    return imageFrame;
}


//- (UIImage * )imageWithImage:(UIImage *)image themeColor:(UIColor *)color {
//    UIGraphicsBeginImageContextWithOptions (image.size, NO, 0);
//    [color setFill];
//    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
//    UIRectFill (bounds);
//    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0];
////    if (blendMode != kCGBlendModeDestinationIn) {
//        [image drawInRect : bounds blendMode : kCGBlendModeDestinationIn alpha:1.0];
////    }
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
////    return [self imageForThemeColor:color blendMode:kCGBlendModeOverlay];
//}

/**RJ 2020-05-09 16:48:38 //*/
//+ (void)showChooseImageSheetWithTitle:(NSString *)title clipSize:(CGSize)size completionBlock:(rj_imagePickerCompletionBlock)completionBlock{
//    [[Tools topViewControllerWithoutModel] showSheetWithTitle:title message:nil otherActions:@[[UIAlertAction actionWithTitle:@"从相册选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        RJImagePickerManager *pickerVC = [[RJImagePickerManager alloc] initWithLimitCount:1 completion:completionBlock];
//        if (!CGSizeIsEmpty(size)) {
//            pickerVC.shouldClip = YES;
//            pickerVC.imageSize = size;
//        }
//        [pickerVC presentPickerController];
//    }],[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        RJCameraManager *manager = [[RJCameraManager alloc] init];
//        if (!CGSizeIsEmpty(size)) {
//            manager.shouldClip = YES;
//            manager.imageSize = size;
//        }
//        manager.cameraManagerCompletionBlock = ^(RJImage *image) {
//            completionBlock(@[image]);
//        };
//        [manager presentCameraController];
//    }]]];
//}

@end
