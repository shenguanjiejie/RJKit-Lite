//
//  UIViewController+UIAlertController.m
//  innerCloud
//
//  Created by Ruijie on 2017/3/29.
//  Copyright © 2017年 Ruijie. All rights reserved.
//

#import "UIViewController+RJAlert.h"

@implementation UIViewController (RJAlert)


#pragma mark - Alert
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void(^)(UIAlertAction *confirmAction))handler {
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:kLocalString(OK) style:UIAlertActionStyleDefault handler:handler];
    [self showAlertWithTitle:title message:message cancelAction:nil confirmAction:confirmAction];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kLocalString(cancel) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:handler];
    [self showAlertWithTitle:title message:message cancelAction:cancelAction confirmAction:confirmAction];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(UIAlertAction *confirmAction))cancelBlock confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:handler];
    [self showAlertWithTitle:title message:message cancelAction:cancelAction confirmAction:confirmAction];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(UIAlertAction *)cancelAction confirmAction:(UIAlertAction *)confirmAction {
    
    if (cancelAction == nil && confirmAction == nil) return;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    cancelAction != nil ? [alertController addAction:cancelAction] : nil;
    confirmAction != nil ? [alertController addAction:confirmAction] : nil;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showSheetWithTitle:(NSString *)title message:(NSString *)message otherActions:(NSArray<UIAlertAction *> *)otherActions{
    if (!otherActions.count) {
        return;
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kLocalString(cancel) style:UIAlertActionStyleCancel handler:nil];
    
    [self showSheetWithTitle:title message:message cancelAction:cancelAction otherActions:otherActions];
}

- (void)showSheetWithTitle:(NSString *)title message:(NSString *)message ancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(UIAlertAction *confirmAction))cancelBlock otherActions:(NSArray<UIAlertAction *> *)otherActions{
    if (!otherActions.count) {
        return;
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    
    [self showSheetWithTitle:title message:message cancelAction:cancelAction otherActions:otherActions];
}

- (void)showSheetWithTitle:(NSString *)title message:(NSString *)message cancelAction:(UIAlertAction *)cancelAction otherActions:(NSArray<UIAlertAction *> *)otherActions{
    
    if (cancelAction == nil) return;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    cancelAction != nil ? [alertController addAction:cancelAction] : nil;
    for (UIAlertAction *action in otherActions) {
        [alertController addAction:action];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

//- (RMessageView *)showRMessageViewWithTitle:(NSString *)title{
//    RMessageView *view = [[RMessageView alloc] initWithDelegate:nil title:title subtitle:nil iconImage:nil type:RMessageTypeError customTypeName:@"error" duration:1+ title.length * 0.1 inViewController:self callback:nil buttonTitle:nil buttonCallback:nil atPosition:RMessagePositionTop canBeDismissedByUser:YES];
//
//    view.backgroundColor = kYellowColor;
//    [view present];
//    return view;
//}

/**RJ 2020-05-09 18:25:57 //*/
//- (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<TYAlertAction *> *)actions{
//    TYAlertView *alertView = [TYAlertView alertViewWithTitle:title message:message];
////    alertView.backgroundColor = [UIColor clearColor];
////    alertView.buttonCancelBgColor = kGrayColor;
////    alertView.buttonDefaultBgColor = kPinkColor;
//
//    alertView.buttonHeight = 50;
////    alertView.buttonSpace = 10;
//    alertView.buttonCornerRadius = 8;
//    alertView.buttonSpace = 10;
//
////    alertView.buttonDefaultBgColor = [UIColor whiteColor];
////    alertView.buttonCancelBgColor = [UIColor whiteColor];
//
//    for (TYAlertAction *action in actions) {
//        [alertView addAction:action];
//    }
//    [alertView addAction:[TYAlertAction actionWithTitle:kLocalString(cancel) style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
//
//    }]];
//    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
//    [self presentViewController:alertController animated:YES completion:nil];
//}

@end
