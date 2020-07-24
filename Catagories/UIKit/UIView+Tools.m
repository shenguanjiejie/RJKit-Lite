//
//  UIView+Tools.m
//  AppKing
//
//  Created by ShenRuijie on 2017/7/19.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import "UIView+Tools.h"
#import "UIButton+WebCache.h"

static __weak id rj_currentFirstResponder;

@implementation UIView (Tools)

- (UIButton *)addImageButtonWithImage:(id)image{
    return [self addButtonWithFont:nil title:nil titleColor:nil image:image];
}

- (UIButton *)addButtonWithFont:(UIFont *)font title:(NSString *)title titleColor:(UIColor *)titleColor image:(id)image{
    UIButton *button = [[UIButton alloc]init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = font?font:kFontSize(13);
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor?titleColor:kBlackColor forState:UIControlStateNormal];
    if (image) {
        if ([image isKindOfClass:[UIImage class]]) {
            [button setImage:image forState:UIControlStateNormal];
        }else if ([image isKindOfClass:[NSString class]]){
            [button sd_setImageWithURL:[NSURL URLWithString:image] forState:UIControlStateNormal placeholderImage:kPlaceholderImage options:SDWebImageLowPriority completed:nil];
        }else if ([image isKindOfClass:[NSURL class]]){
            [button sd_setImageWithURL:image forState:UIControlStateNormal placeholderImage:kPlaceholderImage options:SDWebImageLowPriority completed:nil];
        }
    }
    [self addSubview:button];
    return button;
}

- (UIView *)addViewWithBackgroundColor:(UIColor *)backgroundColor{
    UIView *view = [[UIView alloc]init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = backgroundColor?backgroundColor:[UIColor clearColor];
    [self addSubview:view];
    return view;
}

- (UIImageView *)addImageViewWithImage:(id)image contentMode:(UIViewContentMode)contentMode{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = contentMode;
    imageView.clipsToBounds = YES;
    if (image) {
        if ([image isKindOfClass:[UIImage class]]) {
            imageView.image = image;
        }else if ([image isKindOfClass:[NSString class]]){
            [imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:kPlaceholderImage completed:nil];
        }else if ([image isKindOfClass:[NSURL class]]){
            [imageView sd_setImageWithURL:image placeholderImage:kPlaceholderImage completed:nil];
        }
    }
    [self addSubview:imageView];
    return imageView;
}

- (UILabel *)addLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text{
    UILabel *label = [[UILabel alloc]init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = font?font:kFontSize(13);
    label.textColor = textColor?textColor:kBlackColor;
    label.text = text;
    [self addSubview:label];
    return label;
}

- (UITextField *)addTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text keybordType:(UIKeyboardType)keyboardType{
    UITextField *textField = [[UITextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = textColor?textColor:kBlackColor;
    textField.font = font?font:kFontSize(13);
    textField.text = text;
    textField.contentMode = UIViewContentModeLeft;
    textField.keyboardType = keyboardType;
    [self addSubview:textField];
    return textField;
}

#ifdef FlatUI_FlatUIKit_h
- (UIButton *)addFlatButtonWithFont:(UIFont *)font title:(NSString *)title titleColor:(UIColor *)titleColor image:(id)image{
    FUIButton *button = [[FUIButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.buttonColor = kGreenColor;
    button.shadowColor = [UIColor greenSeaColor];
    button.shadowHeight = 3.0;
    button.cornerRadius = 5.0;
    button.titleLabel.font = font?font:kFontSize(13);
    [button setTitleColor:titleColor?:[UIColor whiteColor] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (image) {
        if ([image isKindOfClass:[UIImage class]]) {
            [button setImage:image forState:UIControlStateNormal];
        }else if ([image isKindOfClass:[NSString class]]){
            [button sd_setImageWithURL:[NSURL URLWithString:image] forState:UIControlStateNormal placeholderImage:kPlaceholderImage options:SDWebImageLowPriority completed:nil];
        }else if ([image isKindOfClass:[NSURL class]]){
            [button sd_setImageWithURL:image forState:UIControlStateNormal placeholderImage:kPlaceholderImage options:SDWebImageLowPriority completed:nil];
        }
    }
    [self addSubview:button];
    return button;
}

- (UITextField *)addFlatTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text keybordType:(UIKeyboardType)keyboardType{
    FUITextField *textField = [[FUITextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.text = text;
    textField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    textField.font = font?font:kFontSize(13);
    textField.textFieldColor = [UIColor whiteColor];
    textField.textColor = textColor?textColor:kBlackColor;
    textField.borderColor = kGreenColor;
    textField.borderWidth = 2.0;
    textField.cornerRadius = 5.0;
    textField.contentMode = UIViewContentModeLeft;
    textField.keyboardType = keyboardType;
    [self addSubview:textField];
    return textField;
}

#endif

- (UIView *)addBottomLine{
    UIView *lineView = [[UIView alloc]init];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0 green:220/255.0 blue:223/255.0 alpha:1.0];
    [self addSubview:lineView];
    
    [self addHAlignConstraintToView:lineView constant:0];
    [self addBottomAlignConstraintToView:lineView constant:0];
    [lineView addHeightConstraintWithConstant:0.5];
    return lineView;
}

-(UITextView *)addTextViewWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text placeholder:(NSString *)placehodler{
    UITextView *textView = [[UITextView alloc] init];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = textColor?textColor:kBlackColor;
    textView.font = font?font:kFontSize(13);
    textView.text = text;
    textView.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:textView];
    return textView;
}

- (UIView *)addTopLine{
    UIView *lineView = [[UIView alloc]init];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    lineView.backgroundColor = [UIColor colorWithRed:221/255.0 green:220/255.0 blue:223/255.0 alpha:1.0];
    [self addSubview:lineView];
    
    [self addHAlignConstraintToView:lineView constant:0];
    [self addTopAlignConstraintToView:lineView constant:0];
    [lineView addHeightConstraintWithConstant:0.5];
    
    return lineView;
}

- (UIImageView *)addRightArrow:(UIImage *)image{
    UIImageView *arrowIV = [[UIImageView alloc]init];
    arrowIV.translatesAutoresizingMaskIntoConstraints = NO;
    arrowIV.contentMode = UIViewContentModeCenter;
    arrowIV.image = image;
    [self addSubview:arrowIV];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(arrowIV);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[arrowIV(30)]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[arrowIV]|" options:0 metrics:nil views:views]];
    
    return arrowIV;
}

+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame lineLength:(int)length lineSpacing:(int)spacing lineColor:(UIColor *)color{
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

+ (id)rj_currentFirstResponder {
    rj_currentFirstResponder = nil;
    // 通过将target设置为nil，让系统自动遍历响应链
    // 从而响应链当前第一响应者响应我们自定义的方法
    [[UIApplication sharedApplication] sendAction:@selector(wty_findFirstResponder:)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    return rj_currentFirstResponder;
}
- (void)rj_findFirstResponder:(id)sender {
    // 第一响应者会响应这个方法，并且将静态变量wty_currentFirstResponder设置为自己
    rj_currentFirstResponder = self;
}


//+ (void)roundedLayer:(CALayer *)viewLayer
//              radius:(float)r
//              shadow:(BOOL)s
//{
//    [viewLayer setMasksToBounds:YES];
//    [viewLayer setCornerRadius:r];
//    [viewLayer setBorderColor:[RGB(180, 180, 180) CGColor]];
//    [viewLayer setBorderWidth:1.0f];
//    if(s)
//    {
//        [viewLayer setShadowColor:[RGB(0, 0, 0) CGColor]];
//        [viewLayer setShadowOffset:CGSizeMake(0, 0)];
//        [viewLayer setShadowOpacity:1];
//        [viewLayer setShadowRadius:2.0];
//    }
//    return;
//}

@end
