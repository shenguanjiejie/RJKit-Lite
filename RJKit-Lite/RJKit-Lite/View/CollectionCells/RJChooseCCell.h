//
//  RJChooseCCell.h
//  diling
//
//  Created by shenruijie on 2018/6/12.
//  Copyright © 2018年 diling. All rights reserved.
//

//#import "RJButtonCCell.h"
#import "RJLabelCCell.h"
@interface RJChooseCCell : RJLabelCCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *selectedTitle;

@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *selectedLabelColor;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, assign) BOOL showImageView;

@property (nonatomic, assign, getter=isChose) BOOL choose;

@end
