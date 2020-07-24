//
//  NSObject+RJObject.m
//  AppKing
//
//  Created by ShenRuijie on 2017/7/5.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import "NSObject+RJExtension.h"
 /**RJ 2020-05-08 21:24:36 Swift不能再使用MJExtension*/
//#import "NSObject+MJKeyValue.h"
#import <objc/message.h>

static void const *objectKey = @"objectKey";
static void const *otherObjectKey = @"otherObjectKey";

@implementation NSObject (object)

//- (void)setObject:( __kindof __unused NSObject *)object{
//    objc_setAssociatedObject(self, objectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- ( __kindof NSObject *)object{
//    return objc_getAssociatedObject(self, objectKey);
//}

- (void)setOtherObject:( __kindof __unused NSObject *)otherObject{
    objc_setAssociatedObject(self, otherObjectKey, otherObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- ( __kindof NSObject *)otherObject{
    return objc_getAssociatedObject(self, otherObjectKey);
}

 /**RJ 2020-05-08 21:24:36 Swift不能再使用MJExtension*/
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [NSObject swizzleClassMethod:@selector(mj_replacedKeyFromPropertyName) with:@selector(rj_replacedKeyFromPropertyName)];
//    });
//}
//
//+ (NSDictionary *)rj_replacedKeyFromPropertyName{
//    NSDictionary *dict = [NSObject rj_replacedKeyFromPropertyName];
//    /**RJ 2019-09-09 11:38:59 字典中包含ID*/
//    if (dict && [dict containsObjectForKey:@"ID"]) {
//        return dict;
//    }
//
//    NSMutableDictionary *idDict = [@{@"ID":@[@"id",@"ID"]} mutableCopy];
//    if (dict) {
//        [idDict setValuesForKeysWithDictionary:dict];
//    }
//    return idDict;
//}
//
//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    return [NSDictionary dictionary];
//}


#pragma mark - Notification
- (void)postNotificationWithStatus:(RJObjectStatus)status{
    [self postNotificationWithStatus:status object:nil params:nil];
}

- (void)postNotificationWithStatus:(RJObjectStatus)status object:(NSObject *)object params:(NSDictionary *)params{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSStringFromClass([self class]) object:object userInfo:@{@"object":self?:[NSNull null],@"status":@(status),@"params":params?:@{}}];
}

- (void)observeClass:(Class)class{
    [self observeClass:class object:nil];
}

- (void)observeClass:(Class)class object:(nullable id)object{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rj_objectNotification:) name:NSStringFromClass(class) object:object];
}

- (void)rj_objectNotification:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self rj_notificationSelWithObject:notification.userInfo[@"object"] status:[notification.userInfo[@"status"] integerValue] params:notification.userInfo[@"params"]];
    });
}

- (void)rj_notificationSelWithObject:(__kindof NSObject *)object status:(RJObjectStatus)status params:(NSDictionary *)params{
    
}

#pragma mark - NSInvocation

/// 该方法接收一个方法的签名,和一个可变参数
- (id)performSelector:(SEL)aSelector withObjects:(id)object,... {
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil) {
        NSAssert(false, @"找不到 %@ 方法",NSStringFromSelector(aSelector));
    }
    // 包装方法
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 设置方法调用者
    invocation.target = self;
    // 设置需要调用的方法
    invocation.selector = aSelector;
    // 获取除去self、_cmd以外的参数个数
    NSInteger paramsCount = signature.numberOfArguments - 2;
    // 设置参数
    va_list params;
    va_start(params, object);
    int i = 0;
    // [GKEndMark end] 是自定义的结束符号,仅此而已,从而使的该方法可以接收nil做为参数
    for (id tmpObject = object; ![(id)tmpObject  isEqual: @"kEnd"]; tmpObject = va_arg(params, id)) {
        // 防止越界
        if (i >= paramsCount) break;
        // 去掉self,_cmd所以从2开始
        [invocation setArgument:&tmpObject atIndex:i + 2];
        i++;
    }
    va_end(params);
    // 调用方法
    [invocation invoke];
    // 获取返回值
    id returnValue = nil;
//    if (signature.methodReturnType) {
//        [invocation getReturnValue:&returnValue];
//    }
    /**RJ 2019-03-21 11:08:53 防止返回值为void会导致崩溃的问题*/
    if (signature.methodReturnType && signature.methodReturnLength != 0) {
        [invocation getReturnValue:&returnValue];
    }

    return returnValue;
}



@end
