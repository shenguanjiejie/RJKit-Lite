//
//  UICollectionView+RJExtension.m
//  diling
//
//  Created by shenruijie on 2019/2/16.
//  Copyright © 2019 shenguanjiejie. All rights reserved.
//

#import "UIScrollView+RJExtension.h"
#import "NSObject+YYAdd.h"
@implementation UIScrollView (RJExtension)


- (void)rj_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        if (touch.window != [UIApplication sharedApplication].keyWindow) {
            [self rj_touchesBegan:touches withEvent:event];
            return;
        }
    }
    
    [self rj_touchesBegan:touches withEvent:event];
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UICollectionView swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(rj_touchesBegan:withEvent:)];
    });
}

@end
