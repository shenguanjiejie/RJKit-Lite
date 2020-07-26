//
//  RJContentViewCell.m
//  diling
//
//  Created by shenruijie on 2017/12/29.
//  Copyright © 2017年 diling. All rights reserved.
//

#import "RJContentViewCell.h"
#import "UIView+Tools.h"
#import "RJKitLitePch.h"

@implementation RJContentViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.rj_contentView = [self.contentView addViewWithBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addHAlignConstraintToViews:@[self.rj_contentView] constant:15];
        [self.contentView addTopAlignConstraintToView:self.rj_contentView constant:15];
        [self.contentView addBottomAlignConstraintToView:self.rj_contentView constant:0];
        
    }
    return self;
}
@end
