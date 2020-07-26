//
//  RJUserDefault.h
//  diling
//
//  Created by shenruijie on 2018/1/15.
//  Copyright © 2018年 diling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "User.h"
#import "RJKitLitePch.h"

@interface RJUserDefault : NSObject

singleton_interface(RJUserDefault)

/**保存userId*/
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *userIdText;
/**保存用户手机号*/
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) RJCountryEnum country;
@property (nonatomic, copy) NSString *countryText;

@property (nonatomic, assign) RJSexEnum sex;
@property (nonatomic, copy) NSString *sexText;

/**保存用户头像*/
@property (nonatomic, copy) NSString *avatar;

/**保存用户photos*/
@property (nonatomic, assign) NSArray *imageUrls;

/**保存用户昵称*/
@property (nonatomic, copy) NSString *nickname;

/**保存用户登录密码*/
@property (nonatomic, copy) NSString *password;

/**保存城市名*/
@property (nonatomic, copy) NSString *cityName;

/**保存城市ID*/
@property (nonatomic, copy) NSString *cityId;

/**保存IP地址*/
@property (nonatomic, copy) NSString *ipAddress;

/**经度*/
@property (nonatomic, assign) CGFloat longitude;

/**纬度*/
@property (nonatomic, assign) CGFloat latitude;

/**保存Token值*/
@property (nonatomic, copy) NSString *token;

/**保存MemberCode值*/
@property (nonatomic, copy) NSString *userMemberCode;

@property (nonatomic, copy) NSString *userProtocolUrl;
@property (nonatomic, copy) NSString *privacyProtocolUrl;

@property (nonatomic, copy) NSString *rightServer;

@property (nonatomic, assign) BOOL notificationAllow;
@property (nonatomic, assign) BOOL notificationDetailAllow;
@property (nonatomic, assign) BOOL notificationSoundAllow;
@property (nonatomic, assign) BOOL notificationShakeAllow;

@end
