//
//  RJVideoCollectionCell.m
//  diling
//
//  Created by shenruijie on 2017/11/19.
//  Copyright © 2017年 diling. All rights reserved.
//

#import "RJVideoCollectionCell.h"

@implementation RJVideoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _playImageView = [[UIImageView alloc]init];
        _playImageView.backgroundColor = [UIColor clearColor];
        _playImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _playImageView.contentMode = UIViewContentModeCenter;
        _playImageView.clipsToBounds = YES;
        _playImageView.image = kImageNamed(play);
        [self.contentView addSubview:_playImageView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_playImageView);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_playImageView]|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_playImageView]|" options:0 metrics:nil views:views]];
    }
    return self;
}

@end
