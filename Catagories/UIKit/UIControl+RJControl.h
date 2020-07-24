//
//  UIControl+RJControl.h
//  diling
//
//  Created by shenruijie on 2018/9/17.
//  Copyright © 2018年 diling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (RJControl)

/**RJ 2019-02-14 20:25:39 default:NO*/
@property (nonatomic, assign) BOOL rj_ban;

- (BOOL)rj_beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;

@end
