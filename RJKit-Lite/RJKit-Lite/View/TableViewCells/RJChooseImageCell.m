//
//  RJChooseImageCell.m
//  diling
//
//  Created by shenruijie on 2018/1/25.
//  Copyright © 2018年 diling. All rights reserved.
//

#import "RJKitLitePch.h"
#import "RJChooseImageCell.h"


@implementation RJChooseImageCell

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self className] scrollDirection:scrollDirection];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier scrollDirection:UICollectionViewScrollDirectionHorizontal];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier scrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageVC = [[RJChooseImageView alloc] init];
        _imageVC.maxCount = 4;
        _imageVC.cellSize = CGSizeMake(100, 100);
        _imageVC.assetsPickerType = RJChooseImageViewTypeImage;
        _imageVC.style = RJChooseImageViewStyleWhite;
        _imageVC.shouldEdit = YES;
        _imageVC.scrollDirection = scrollDirection;
        
//        UIViewController *topVC = [Tools topViewController];
//        [topVC addChildViewController:_imageVC];
//        [_imageVC didMoveToParentViewController:topVC];
//        UIView *view = _imageVC.view;
//        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_imageVC];
        
        //        [self.contentView addAllAlignConstraintToView:view constant:15];
        [_imageVC addMarginsConstraintWithEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        //        UIImageView *imageView = [self.contentView addImageViewWithImage:kImageNamed(add_service_star) contentMode:UIViewContentModeScaleAspectFit];
        //        [self.contentView addLeftAlignConstraintToView:imageView constant:2];
        //        [self.contentView addVAlignConstraintToView:imageView constant:0];
        //        [view addRightConstraintToView:imageView constant:2];
    }
    return self;
    
}



@end
