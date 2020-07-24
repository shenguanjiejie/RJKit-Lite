//
//  UIApplication+RJPermission.h
//  AppKing
//
//  Created by ShenRuijie on 2017/8/22.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIViewController+RJAlert.h"
#import <CoreTelephony/CTCellularData.h>
#import <Photos/Photos.h>
#import <UserNotifications/UserNotifications.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>

#define RJAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

@interface UIApplication (RJPermission)


+ (void)showPermissionAlertWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(void (^)(UIAlertAction *confirmAction))cancelBlock confirmTitle:(NSString *)confirmTitle;

+(BOOL)locationPermissionWithManager:(CLLocationManager *)manager alert:(BOOL)alert cancelBlock:(void (^)(UIAlertAction *confirmAction))cancelBlock;

+ (BOOL)networkPermission;

+ (BOOL)photoPermissionWithAlert:(BOOL)alert handler:(void (^)(PHAuthorizationStatus status) )handler;

+ (BOOL)cameraPermissionWithAlert:(BOOL)alert handler:(void (^)(BOOL granted) )handler;

+ (void)notificationPermissionShouldRegister:(BOOL)shouldRegister resultBlock:(void (^)(BOOL result))resultBlock;

+ (BOOL)contactPermissionWithHandler:(void (^)(BOOL granted, NSError * _Nullable error))handler;

+ (BOOL)calendarPermissionWithHandler:(void (^)(BOOL granted, NSError * _Nullable error))handler;


@end
