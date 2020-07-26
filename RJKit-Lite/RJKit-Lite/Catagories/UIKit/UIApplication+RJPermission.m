//
//  UIApplication+RJPermission.m
//  AppKing
//
//  Created by ShenRuijie on 2017/8/22.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import "UIApplication+RJPermission.h"
#import "RJKiteLitePch.h"

@implementation UIApplication (RJPermission)


+ (void)showPermissionAlertWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(void (^)(UIAlertAction *confirmAction))cancelBlock confirmTitle:(NSString *)confirmTitle{
//    DDDLog(@"%s %@",__FUNCTION__,[Tools topViewController]);
    [[Tools topViewController] showAlertWithTitle:title message:message cancelTitle:kLocalString(cancel) cancelBlock:cancelBlock confirmTitle:confirmTitle confirmHandler:^(UIAlertAction *confirmAction) {
        if (kSystemVersion < 10) {
            [UIApplication.sharedApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else{
            [UIApplication.sharedApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }];
}

+(BOOL)locationPermissionWithManager:(CLLocationManager *)manager alert:(BOOL)alert cancelBlock:(void (^)(UIAlertAction *confirmAction))cancelBlock{
    
    if (CLLocationManager.locationServicesEnabled) {
        switch (CLLocationManager.authorizationStatus) {
                case kCLAuthorizationStatusNotDetermined:
                if (manager) {
                    [manager requestWhenInUseAuthorization];
                }
                return NO;
                case kCLAuthorizationStatusRestricted:
                case kCLAuthorizationStatusDenied:
                if (alert) {
                    [UIApplication showPermissionAlertWithTitle:kLocalString(location_denied) message:kLocalString(location_open) cancelBlock:cancelBlock confirmTitle:kLocalString(open_now)];
                }
                return NO;
                case kCLAuthorizationStatusAuthorizedAlways:
                case kCLAuthorizationStatusAuthorizedWhenInUse:
                return YES;
            default:
                break;
        }
    }
    
    return NO;
}

+ (BOOL)networkPermission{
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    __block BOOL permission = NO;
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //获取联网状态
        switch (state) {
                case kCTCellularDataRestricted:
                permission = NO;
                break;
                case kCTCellularDataNotRestricted:
                permission = YES;
                break;
                case kCTCellularDataRestrictedStateUnknown:
                permission = NO;
                break;
            default:
                break;
        };
    };
    
    return permission;
}

+ (BOOL)photoPermissionWithAlert:(BOOL)alert handler:(void (^)(PHAuthorizationStatus status) )handler{
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
            case PHAuthorizationStatusAuthorized:
            return YES;
            case PHAuthorizationStatusDenied:
            case PHAuthorizationStatusRestricted:
            if (alert) {
                [UIApplication showPermissionAlertWithTitle:kLocalString(photo_denied) message:kLocalString(photo_open) cancelBlock:nil confirmTitle:kLocalString(open_now)];
            }
            return NO;
            case PHAuthorizationStatusNotDetermined:
            [PHPhotoLibrary requestAuthorization:handler];
            return NO;
        default:
            break;
    }
}

+ (BOOL)cameraPermissionWithAlert:(BOOL)alert handler:(void (^)(BOOL granted) )handler{
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
    //    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
    
    switch (AVstatus) {
            case AVAuthorizationStatusAuthorized:
            return YES;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
            if (alert) {
                [UIApplication showPermissionAlertWithTitle:kLocalString(camera_denied) message:kLocalString(camera_open) cancelBlock:nil confirmTitle:kLocalString(open_now)];
            }
            return NO;
            case AVAuthorizationStatusNotDetermined:
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:handler];
            return NO;
        default:
            break;
    }
}

+ (void)notificationPermissionShouldRegister:(BOOL)shouldRegister resultBlock:(void (^)(BOOL result))resultBlock{
    if (kSystemVersion >= 10) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusNotDetermined:
                    if (shouldRegister) {
                        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                            if (!error) {
//                                DDDLog(@"request authorization succeeded!");
                            }
                        }];
                    }
                    if (resultBlock) {
                        resultBlock(NO);
                    }
                case UNAuthorizationStatusDenied:
                    if (resultBlock) {
                        resultBlock(NO);
                    }
                    
                case UNAuthorizationStatusAuthorized:
                    if (resultBlock) {
                        resultBlock(YES);
                    }
                default:
                    break;
            }
        }] ;
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wcast-of-sel-type"
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    switch (settings.types) {
        case UIUserNotificationTypeNone:
            if (shouldRegister) {
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            }
            if (resultBlock) {
                resultBlock(NO);
            }
        case UIUserNotificationTypeAlert:
        case UIUserNotificationTypeBadge:
        case UIUserNotificationTypeSound:
            if (resultBlock) {
                resultBlock(YES);
            }
        default:
            break;
    }
#pragma clang diagnostic pop
    
}

+ (BOOL)contactPermissionWithHandler:(void (^)(BOOL granted, NSError * _Nullable error))handler{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
            case CNAuthorizationStatusAuthorized:
            return YES;
            case CNAuthorizationStatusDenied:
            case CNAuthorizationStatusRestricted:
            return NO;
            case CNAuthorizationStatusNotDetermined:
            if (handler) {
                CNContactStore *contactStore = [[CNContactStore alloc] init];
                [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:handler];
            }
            return NO;
        default:
            break;
    }
}

+ (BOOL)calendarPermissionWithHandler:(void (^)(BOOL granted, NSError * _Nullable error))handler{
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (EKstatus) {
            case EKAuthorizationStatusAuthorized:
            return YES;
            case EKAuthorizationStatusDenied:
            case EKAuthorizationStatusRestricted:
            return NO;
            case EKAuthorizationStatusNotDetermined:
            if (handler) {
                EKEventStore *store = [[EKEventStore alloc]init];
                [store requestAccessToEntityType:EKEntityTypeEvent completion:handler];
            }
            return NO;
        default:
            break;
    }
}

@end
