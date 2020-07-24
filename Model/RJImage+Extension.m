//
//  RJImage+Extension.m
//  diling
//
//  Created by shenruijie on 2019/1/15.
//  Copyright © 2019 shenguanjiejie. All rights reserved.
//

#import "RJImage+Extension.h"
#import <objc/message.h>
#import <QMUILab.h>
//#import "NSObject+MJCoding.h"

static const int kIndexPathKey;

@implementation RJImage (Extension)

//MJExtensionCodingImplementation

//+ (NSArray *)mj_ignoredCodingPropertyNames{
//    return @[@"imageView",@"ossProgressBlock"];
//}


QMUISynthesizeIdStrongProperty(ossProgressBlock, setOssProgressBlock)

QMUISynthesizeIdStrongProperty(imageView, setImageView)

-(void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &kIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &kIndexPathKey);
}

+ (NSArray<NSString *> *)urlsWithKeys:(NSArray<NSString *> *)keys radius:(CGFloat)radius{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0;i < keys.count; i++) {
        NSString *key = keys[i];
//        [arr addObject:kRJWebImageUrl(key, 800, (int)radius).absoluteString];
    }
    return arr;
}
+ (NSArray<NSString *> *)thumbUrlsWithKeys:(NSArray<NSString *> *)keys radius:(CGFloat)radius{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0;i < keys.count; i++) {
        NSString *key = keys[i];
//        [arr addObject:kRJWebImageUrl(key, 200, (int)radius).absoluteString];
    }
    return arr;
}

@end
