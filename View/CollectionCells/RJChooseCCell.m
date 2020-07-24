//
//  RJChooseCCell.m
//  diling
//
//  Created by shenruijie on 2018/6/12.
//  Copyright © 2018年 diling. All rights reserved.
//

#import "RJChooseCCell.h"

@implementation RJChooseCCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLab.numberOfLines = 1;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.userInteractionEnabled = NO;
        
        UIView *contentView = self.contentView;
        _imageView = [contentView addImageViewWithImage:nil contentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addVAlignConstraintToViews:@[_imageView] constant:3];
        
        [_imageView addLeftMarginConstraintWithConstant:0];
        [_imageView addWidthConstraintWithConstant:20].active = NO;
        [_imageView setSquareConstraint];
        [self.titleLab addRightConstraintToView:_imageView constant:3].active = NO;
        
        self.image = kImageNamed(MineAttentionNotSelected);
        self.selectedImage = kImageNamed(MineAttentionSelected);
        self.textColor = kBlackColor;
        self.selectedTextColor = kGreenColor;
    }
    return self;
}

- (void)setShowImageView:(BOOL)showImageView{
    _showImageView = showImageView;

    if (showImageView) {
        _imageView.widthConstraint.active = YES;
        _imageView.rightConstraint.active = YES;
        self.titleLab.leftConstraint.active =  NO;
        _imageView.image = self.image;
        _imageView.highlightedImage = self.selectedImage;
    }else{
        _imageView.widthConstraint.active = NO;
        _imageView.rightConstraint.active = NO;
        self.titleLab.leftConstraint.active =  YES;
        _imageView.image = nil;
        _imageView.highlightedImage = nil;
    }
}


- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    self.imageView.highlightedImage = selectedImage;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.titleLab.textColor = textColor;
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor{
    _selectedTextColor = selectedTextColor;
    self.titleLab.highlightedTextColor = selectedTextColor;
}

- (void)setChoose:(BOOL)choose{
    _choose = choose;
    self.titleLab.highlighted = choose;
    self.imageView.highlighted = choose;
    
    if (choose) {
        self.titleLab.text = _selectedTitle;
        self.titleLab.backgroundColor = _selectedLabelColor;
    }else{
        self.titleLab.text = _title;
        self.titleLab.backgroundColor = _labelColor;
    }
}
@end
