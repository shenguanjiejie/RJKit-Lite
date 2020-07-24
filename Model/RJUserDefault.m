//
//  RJUserDefault.m
//  diling
//
//  Created by shenruijie on 2018/1/15.
//  Copyright © 2018年 diling. All rights reserved.
//

#import "RJUserDefault.h"
//#import <CCUserDefaultsManager.h>
#import "NSObject+Reflection.h"
@implementation RJUserDefault

singleton_implementation(RJUserDefault)

+(void)load{
    /// 将CCUserDefault添加到CCUserDefaultsManager中,那么CCUserDefault的成员变量的`set`和`get`方法都会映射成与`NSUserDefaults`对应的存取方法
//    [[CCUserDefaultsManager sharedManager] addClass:self];
}

- (instancetype)init{
    self = [super init];
    if (self) {
//        self.token = @"";
//        self.userIdText = @"";
//        self.avatar = @"";
//        self.phone = @"";
//        self.nickname = @"";
//        self.userMemberCode = @"";
//        self.notificationAllow = YES;
//        self.notificationDetailAllow = YES;
//        self.notificationShakeAllow = YES;
//        self.notificationSoundAllow = YES;
        [self initAllProperties];
    }
    return self;
}

@end
