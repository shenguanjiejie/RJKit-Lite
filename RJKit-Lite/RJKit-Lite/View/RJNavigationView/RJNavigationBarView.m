//
//  ProgressNavigationBarView.m
//  kisshappy
//
//  Created by ShenRuijie on 2017/11/12.
//  Copyright © 2017年 shenguanjiejie. All rights reserved.
//

#import "RJNavigationBarView.h"
#import "UIImage+Draw.h"
#import "QMUIKit.h"
#import "RJKiteLitePch.h"

@interface RJNavigationBarView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@end

@implementation RJNavigationBarView


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(layoutSubviews), @selector(titleView_navigationBarLayoutSubviews));
    });
}

- (void)titleView_navigationBarLayoutSubviews {
    QMUINavigationTitleView *titleView = (QMUINavigationTitleView *)self.titleView;
    
    if ([titleView isKindOfClass:[QMUINavigationTitleView class]]) {
        CGFloat titleViewMaximumWidth = CGRectGetWidth(titleView.bounds);// 初始状态下titleView会被设置为UINavigationBar允许的最大宽度
        CGSize titleViewSize = [titleView sizeThatFits:CGSizeMake(titleViewMaximumWidth, CGFLOAT_MAX)];
        titleViewSize.height = ceil(titleViewSize.height);// titleView的高度如果非pt整数，会导致计算出来的y值时多时少，所以干脆做一下pt取整，这个策略不要改，改了要重新测试push过程中titleView是否会跳动
        
        // 当在UINavigationBar里使用自定义的titleView时，就算titleView的sizeThatFits:返回正确的高度，navigationBar也不会帮你设置高度（但会帮你设置宽度），所以我们需要自己更新高度并且修正y值
        if (CGRectGetHeight(titleView.bounds) != titleViewSize.height) {
            CGFloat titleViewMinY = flat(CGRectGetMinY(titleView.frame) - ((titleViewSize.height - CGRectGetHeight(titleView.bounds)) / 2.0));// 系统对titleView的y值布局是flat，注意，不能改，改了要测试
            titleView.frame = CGRectMake(CGRectGetMinX(titleView.frame), titleViewMinY, MIN(titleViewMaximumWidth, titleViewSize.width), titleViewSize.height);
        }
        
        // iOS 11 之后（iOS 11 Beta 5 测试过） titleView 的布局发生了一些变化，如果不主动设置宽度，titleView 里的内容就可能无法完整展示
        if (@available(iOS 11, *)) {
            if (CGRectGetWidth(titleView.bounds) != titleViewSize.width) {
                titleView.frame = CGRectSetWidth(titleView.frame, titleViewSize.width);
            }
        }
    } else {
        titleView = nil;
    }
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.backBtn.titleEdgeInsets, UIEdgeInsetsZero)) {
        self.backBtn.widthConstraint.constant = MAX(self.backBtn.constraints.firstObject.constant + 20,60);
    }
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.rightBtn.titleEdgeInsets, UIEdgeInsetsZero)) {
        self.rightBtn.widthConstraint.constant = MAX(self.rightBtn.constraints.firstObject.constant + 20,40);
    }
    
    [self titleView_navigationBarLayoutSubviews];
    
    if (titleView) {
        //        NSLog(@"【%@】系统布局后\ntitleView = %@", NSStringFromClass(titleView.class), titleView);
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [self addImageViewWithImage:nil contentMode:UIViewContentModeScaleAspectFill];
        _imageView.hidden = YES;
        [self addAllAlignConstraintToView:_imageView constant:0];
        
        self.titleView = [[QMUINavigationTitleView alloc] init];
        self.titleView.titleLabel.textColor = kBlackColor;
        self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleView.adjustsSubviewsTintColorAutomatically = NO;
        [self addSubview:self.titleView];
        [self addAllAlignConstraintToView:self.titleView edgeInset:UIEdgeInsetsMake(kSafeTop, 70, 0, 70)];
        
        _lineView = [self addViewWithBackgroundColor:kSeparateColor];
        [self addHAlignConstraintToView:_lineView constant:0];
        [self addBottomAlignConstraintToView:_lineView constant:0];
        [_lineView addHeightConstraintWithConstant:0.5];
    }
    return self;
}

- (void)setType:(RJNavigationBarViewType)type{
    _type = type;
    
    if (type == RJNavigationBarViewTypeClose && _backBtn) {
        [_backBtn setImage:kImageNamed(close) forState:UIControlStateNormal];
    }else if (type == RJNavigationBarViewTypeBack && _backBtn){
        [_backBtn setImage:kImageNamed(back) forState:UIControlStateNormal];
    }
    
    if (type == RJNavigationBarViewTypeProgress && !_collectionView) {
        [self.rightBtn setTitleColor:kPinkColor forState:UIControlStateNormal];
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //定义行和列之间的间距
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];

        [_collectionView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [_collectionView addWidthConstraintWithConstant:(_totalStep - 1) * (10 + 8) + 10];
//        [_collectionView.widthAnchor constraintEqualToConstant:(_totalStep - 1) * (10 + 8) + 10].active = YES;
        [self addTopAlignConstraintToView:_collectionView constant:kSafeTop];
        [self addBottomAlignConstraintToView:_collectionView constant:0];
    }
}

- (void)setTotalStep:(NSInteger)totalStep{
    _totalStep = totalStep;
    _collectionView.widthConstraint.constant = (_totalStep - 1) * (10 + 8) + 10;
}

- (void)setCurrentStep:(NSInteger)currentStep{
    _currentStep = currentStep;
    [_collectionView reloadData];
}

- (void)addBackBtn{
    self.backBtn = [[UIButton alloc]init];
    self.backBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.backBtn.backgroundColor = [UIColor clearColor];
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 11, 0, 30);
    self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 11, 0, -11);
    self.backBtn.titleLabel.font = kFontSize(16);
    self.backBtn.adjustsImageWhenHighlighted = NO;
//    [self.backBtn setTitle:backMsg forState:UIControlStateNormal];
    [self.backBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    if (_type == RJNavigationBarViewTypeBack) {
        [self.backBtn setImage:kImageNamed(back) forState:UIControlStateNormal];
    }else if (_type == RJNavigationBarViewTypeClose){
        [self.backBtn setImage:kImageNamed(close) forState:UIControlStateNormal];
    }
    [self addSubview:self.backBtn];
    
    [self addLeftAlignConstraintToView:_backBtn constant:0];
    [self addTopAlignConstraintToView:_backBtn constant:kSafeTop];
    [self addBottomAlignConstraintToView:_backBtn constant:0];
    [self.backBtn addWidthConstraintWithConstant:70];
}

- (void)addRightBtn{
    self.rightBtn = [[UIButton alloc]init];
    self.rightBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightBtn.backgroundColor = [UIColor clearColor];
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 11);
//    self.rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -11, 0, 11);
    self.rightBtn.titleLabel.font = kFontSize(16);
    self.rightBtn.adjustsImageWhenHighlighted = NO;
    //    [self.rightBtn setTitle:rightMsg forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kPinkColor forState:UIControlStateSelected];
    [self addSubview:self.rightBtn];
    
    [self addRightAlignConstraintToView:_rightBtn constant:0];
    [self addTopAlignConstraintToView:_rightBtn constant:kSafeTop];
    [self addBottomAlignConstraintToView:_rightBtn constant:0];
    [self.rightBtn addWidthConstraintWithConstant:70];
}

- (void)setNavigationBackMsg:(NSString *)backMsg{
    if (self.backBtn) {
        [self.backBtn setTitle:backMsg forState:UIControlStateNormal];
//        [self setNeedsLayout];
//        [UIView animateWithDuration:0.2 animations:^{
            [self layoutSubviews];
//        }];
//        [self titleView_navigationBarLayoutSubviews];
    }
}

- (void)setNavigationRightMsg:(NSString *)rightMsg{
    if (self.rightBtn) {
        [self.rightBtn setTitle:rightMsg forState:UIControlStateNormal];
//        [self titleView_navigationBarLayoutSubviews];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

#pragma mark - UICollectionViewDelegates
#pragma mark ---- UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.totalStep;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.contentView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
//    [cell.button setImage:[UIImage roundIconWithImage:[UIImage imageWithColor:kSeparateColor size:CGSizeMake(3, 3)] diameter:3] forState:UIControlStateNormal];
//    [cell.button setImage:[UIImage roundIconWithImage:[UIImage imageWithColor:kPinkColor size:CGSizeMake(3, 3)] diameter:3] forState:UIControlStateSelected];
//    [cell.button setImage:[UIImage roundIconWithImage:[UIImage imageWithColor:kRedColor size:CGSizeMake(5, 5)] diameter:5] forState:UIControlStateHighlighted];
    
    if (indexPath.row < _currentStep) {
        cell.layer.cornerRadius = 4;
        cell.backgroundColor = kPinkColor;
//        cell.button.selected = YES;
//        cell.button.highlighted = NO;
    }else if (indexPath.row == _currentStep){
        cell.backgroundColor = kRedColor;
        cell.layer.cornerRadius = 5;
//        cell.button.selected = NO;
//        cell.button.highlighted = YES;
    }else{
        cell.backgroundColor = kSeparateColor;
        cell.layer.cornerRadius = 4;
//        cell.button.selected = NO;
//        cell.button.highlighted = NO;
    }

    return cell;
}

#pragma mark ----UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _currentStep) {
        return CGSizeMake(10, 10);
    }
    return CGSizeMake(8, 8);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 0, 20, 0);
}

#pragma mark ---- UICollectionViewDelegate

//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == nil) {
//        for (UIView *subView in self.subviews) {
//            CGPoint tp = [subView convertPoint:point fromView:self];
//            if (CGRectContainsPoint(subView.bounds, tp)) {
//                if (!subView.hidden && subView.userInteractionEnabled) {
//                    view = subView;
//                }
//            }
//        }
//    }
//    return view;
//}

@end
