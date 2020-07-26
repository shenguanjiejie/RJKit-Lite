//
//  NSObject+RJObject.h
//  AppKing
//
//  Created by ShenRuijie on 2017/7/5.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationInfo.h"

typedef void (^RJObjectObserverBlock)(NSObject *object);

@interface NSObject(RJExtension)

@property (strong, nonatomic) __kindof NSObject *otherObject;

//+ (NSDictionary *)rj_replacedKeyFromPropertyName;

- (void)postNotificationWithStatus:(RJObjectStatus)status;
- (void)postNotificationWithStatus:(RJObjectStatus)status object:(NSObject *)object params:(NSDictionary *)params;

- (void)observeClass:(Class)class;
- (void)observeClass:(Class)class object:(id)object;

- (void)rj_notificationSelWithObject:(__kindof NSObject *)object status:(RJObjectStatus)status params:(NSDictionary *)params;

- (id)performSelector:(SEL)aSelector withObjects:(id)object,...;

@end
