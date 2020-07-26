//
//  YYCache+Singleton.m
//  duDu
//
//  Created by RuiJie on 16/12/15.
//  Copyright © 2016年 youd. All rights reserved.
//

#import "YYCache+Singleton.h"
#import "User.h"
#import <objc/message.h>

static const int kUserKey;
static const int kServerInfoKey;
static const int kFriendsKey;

@implementation YYCache (Singleton)

static YYCache *_instance;

User *user(void){return _instance.user;}

BOOL containsUser(){return [_instance containsObjectForKey:@"UserKey"];}
User *diskUser(){return (User *)[_instance objectForKey:@"UserKey"];}
void cacheUser(User *user){[_instance setObject:user forKey:@"UserKey"];}

//ServerInfo* diskServerInfo(){return (ServerInfo *)[_instance objectForKey:@"ServerInfoKey"];}
//void cacheServerInfo(ServerInfo *serverInfo){[_instance setObject:serverInfo forKey:@"ServerInfoKey"];}

+ (YYCache *)sharedCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithPath:kCachePath];
//        _instance.serverInfo = [[ServerInfo alloc] init];
        _instance.user = [[User alloc] init];
    });
    return _instance;
}

- (void)setUser:(User *)user{
    objc_setAssociatedObject(self, &kUserKey, user, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(User *)user{
    return objc_getAssociatedObject(self, &kUserKey);
}

//- (void)setServerInfo:(ServerInfo *)serverInfo{
//    objc_setAssociatedObject(self, &kServerInfoKey, serverInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(ServerInfo *)serverInfo{
//    return objc_getAssociatedObject(self, &kServerInfoKey);
//}

- (void)setFriends:(NSArray<User *> *)friends{
    objc_setAssociatedObject(self, &kFriendsKey, friends, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSArray<User *> *)friends{
    return objc_getAssociatedObject(self, &kFriendsKey);
}


- (void)postSelfNotifacationWithStatus:(RJObjectStatus)status{
    NotificationInfo *info = [[NotificationInfo alloc] init];
    info.status = status;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"self" object:nil userInfo:@{@"info":info}];
}

- (void)postLoginOrLogoutNotifacation:(BOOL)isLogin{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login_or_logout" object:nil userInfo:@{@"info":@(isLogin)}];
}

@end
