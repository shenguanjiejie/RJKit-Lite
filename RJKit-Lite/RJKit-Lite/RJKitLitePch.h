//
//  User.h
//  diling
//
//  Created by shenruijie on 2018/12/18.
//  Copyright © 2018 shenguanjiejie. All rights reserved.
//

/**RJ 2020-05-09 16:44:56 */
#import "QMUIKit.h"
#import "YYCategories.h"
#import "UIView+Tools.h"
#import "UIView+RJVFL.h"
#import <SDWebImage/SDWebImage.h>
#import "UIViewController+RJInject.h"
#import "UIViewController+RJNavigationBarView.h"
#import "Tools.h"
#import "RJImage.h"

#define kSafeTop [Tools safeTop]
#define kSafeBottom [Tools safeBottom]
#define _kImageNamed(name) [UIImage imageNamed:@#name]
#define kImageNamed(name) _kImageNamed(name)
#define kStringWithNum(num) [NSString stringWithFormat:@"%@",@(num)]
#define kIndexPath(section,row) [NSIndexPath indexPathForRow:row inSection:section]
#define kPlaceholderAvatar [UIImage imageNamed:@"avatar"]
#define kPlaceholderImage [UIImage imageNamed:@"placeholder_image"]

#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0)
#define kHexColor(value) kRGBColor(((0x##value)&0xFF0000) >> 16, ((0x##value)&0xFF00) >> 8 ,  ((0x##value)&0xFF))

#define kGrayColor  kHexColor(666666)
#define kBlackColor kHexColor(3a3a3a)
#define kGreenColor kHexColor(28b654)
#define kLightGrayColor  kHexColor(999999)
#define kPinkColor kHexColor(FF526A)
#define kRedColor kHexColor(f65900)
#define kHeightLightGrayColor  kHexColor(dddcdd)
#define kBlueColor  kHexColor(2095f2)
#define kBackgroundColor kHexColor(edf1f5)
#define kPlaceholderColor kHexColor(C7C7CD)
#define kSeparateColor kPlaceholderColor


#define kIsiPhone            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define kIsBigiPhone       (kIsiPhone && kScreenHeight >= 736.0)
#define kFontSize(x) [UIFont systemFontOfSize:(kIsBigiPhone ? (x)+1:(x)+0.5)]
#define kSystemFontSize(x) [UIFont systemFontOfSize:(x)]

