//
//  UIImage+Draw.m
//  MTestM.iOS
//
//  Created by ShenRuijie on 15/2/28.
//  Copyright (c) 2015年 com.yuyy. All rights reserved.
//

#import "UIImage+Draw.h"
#import "SDWebImageManager.h"

@implementation UIImage (Icon)

//画圆形头像
- (UIImage *) roundIconWithDiameter:(CGFloat)diameter{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(diameter, diameter), NO, 0.0);
    
    // 取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画圆,裁剪
    CGContextAddArc(ctx,diameter/2.0, diameter/2.0, diameter/2.0, 0, 2*M_PI, 0);
    CGContextClip(ctx);
    
    //保证绘制到上下文中的部分是图片的中间区域
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    CGFloat margin = 0;
    if (height > width) {
        margin = height - width;
    }else{
        margin = width - height;
    }
    margin = margin/2.0;
    
    if (height > width) {
        [self drawInRect:CGRectMake(0, - margin / height  * diameter, diameter, diameter * height / width)];
    }else{
        [self drawInRect:CGRectMake(- margin / width * diameter, 0, diameter * width / height, diameter)];
    }
    
    UIImage *NewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    return NewImage;
}

// 画带边框的圆形头像
-(UIImage *) roundIconWithDiameter:(CGFloat)diameter borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor borderAlpha:(CGFloat)borderAlpha{
    
    CGRect rect = CGRectMake(0, 0, diameter, diameter);
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // 取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat bgRadius = diameter/2.0;
    CGFloat iconRadius = diameter/2.0 - borderWidth;
    
    //画大圆,作为边框
    if (borderColor != nil) {
        [borderColor set];
    }else{
        [[UIColor clearColor] set];
    }
    CGContextAddArc(ctx,bgRadius, bgRadius, bgRadius, 0, 2*M_PI, 0);
    CGContextSetAlpha(ctx, borderAlpha);
    CGContextFillPath(ctx);
    
    //画小圆,用小圆裁剪
    CGContextAddArc(ctx,bgRadius, bgRadius, iconRadius, 0, 2*M_PI, 0);
    CGContextClip(ctx);
    
    //小圆直径
    CGFloat smallDiameter = diameter - 2 * borderWidth;
    
    CGFloat scale = smallDiameter / MIN(self.size.height, self.size.width);
    //按照margin比例伸缩图片
    UIImage *image = [self imageWithScale:scale];
    
    CGFloat height = image.size.height;
    CGFloat width = image.size.width;
    
    CGFloat margin = 0;
    if (height > width) {
        margin = height - width;
    }else{
        margin = width - height;
    }
    margin = margin/2.0;
    
    if (height > width) {
        [image drawInRect:CGRectMake(borderWidth,borderWidth - margin / height * smallDiameter, smallDiameter, smallDiameter * height / width)];
    }else{
        [image drawInRect:CGRectMake(borderWidth - margin / width * smallDiameter, borderWidth, smallDiameter, smallDiameter * height / width)];
    }
    
    //    if (height > width) {
    //        margin = height - width;
    //    }else{
    //        margin = width - height;
    //    }
    //    margin = margin/2.0;
    //    
    //    if (height > width) {
    //        [image drawInRect:CGRectMake(0, - margin / height  * diameter, diameter, diameter * height / width)];
    //    }else{
    //        [image drawInRect:CGRectMake(- margin / width * diameter, 0, diameter, diameter * height / width)];
    //    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage*)imageWithScale:(CGFloat)scale
{
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageWithQRImageView:(UIImage *)QRImage logoImage:(UIImage *)logoImage{
    CGSize size = QRImage.size;
//    CGSize logoBgSize=CGSizeMake(50, 50);
    CGSize logoSize=CGSizeMake(48, 48);
    UIImage *bgImage = [UIImage imageWithColor:[UIColor whiteColor] size:size];
    bgImage = [bgImage imageByRoundCornerRadius:8];
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(QRImage.size, NO, 0.0);
    
    // 取得当前的上下文
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    
    [QRImage drawInRect:(CGRect){CGPointZero,size}];
    [bgImage drawInRect:CGRectMake((size.width - logoSize.width) / 2, (size.height - logoSize.height) / 2, logoSize.width, logoSize.height)];
    [logoImage drawInRect:CGRectMake((size.width - logoSize.width) / 2, (size.height - logoSize.height) / 2, logoSize.width, logoSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageFromView:(UIView *)theView withSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the window's anchor point
    CGContextTranslateCTM(context, size.width/2, size.height/2);
    // Apply the window's transform about the anchor point
    CGContextConcatCTM(context, [theView transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -[theView bounds].size.width * [[theView layer] anchorPoint].x,
                          -[theView bounds].size.height * [[theView layer] anchorPoint].y);
    
    //	[theView.layer renderInContext:context];
    [theView drawViewHierarchyInRect:[theView bounds] afterScreenUpdates:NO];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius {
    return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor {
    return [self imageByRoundCornerRadius:radius
                                  corners:UIRectCornerAllCorners
                              borderWidth:borderWidth
                              borderColor:borderColor
                           borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clipsToBounds{
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height) withContentMode:contentMode clipsToBounds:clipsToBounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 群组头像获取
+ (UIImage *)groupIconWithSide:(CGFloat)side imageNames:(NSArray *)imageNames borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    if (!imageNames) return nil;
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < imageNames.count; i++) {
        images[i] = [UIImage imageNamed:imageNames[i]];
    }
    
    return [UIImage groupIconWithSide:side images:images borderWidth:borderWidth borderColor:borderColor];
}

#if 0
+(void)drawGroupIconWithSide:(CGFloat)side imageUrls:(NSArray *)imageUrls borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor completion:(void (^)(UIImage *))completion{
    if (!imageUrls) return;
    
    NSString *key = [imageUrls componentsJoinedByString:@","];
    
    __block UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    //缓存中有,直接返回
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(image);
            }
        });
        return;
    }
    
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 0; i < imageUrls.count; i++) {
        NSString *url = imageUrls[i];
        image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
        
        //如果单张图片有缓存
        if (image) {
            [images addObject:image];
            if (i == imageUrls.count - 1) {
                image = [UIImage groupIconWithSide:side images:images borderWidth:borderWidth borderColor:borderColor];
                [[SDImageCache sharedImageCache] storeImage:image forKey:key completion:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(image);
                    }
                });
            }
        }else{
            // 没有缓存,下载图片并缓存
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (image) {
                    [images addObject:image];
                } else {
                    [images addObject:kPlaceholderAvatar];
                }
                
                if (images.count == imageUrls.count) {
                    image = [UIImage groupIconWithSide:side images:images borderWidth:borderWidth borderColor:borderColor];
                    [[SDImageCache sharedImageCache] storeImage:image forKey:key completion:nil];
                    if (completion) {
                        completion(image);
                    }
                }
            }];
        }
    }
    
}
#endif


+ (UIImage *)groupIconWithSide:(CGFloat)side images:(NSArray *)images borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), NO, 0.0);
    
    // 取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (borderColor) {
        [borderColor set];
    }else{
        [[UIColor clearColor] set];
    }
    CGFloat radius;             //大圆半径
    CGFloat smallRadius;        //图片圆半径
    CGFloat margin;             //大圆到边界距离
    CGPoint first;              //第一个圆的圆心
    CGFloat angle;
    
    if (!images || images.count == 0) {
        return nil;
    }
    
    if (images.count == 1){
        return [images.firstObject  roundIconWithDiameter:side];
    }
    
    if (images.count == 2) {
        radius = 0.31*side;     //半径,当与正方形边的比例为0.31的时候,画出来的样式比较合适
        smallRadius = radius - borderWidth; //图片圆半径
        
        // 画大圆
        CGContextAddArc(ctx, radius , radius, radius, 0, 2*M_PI, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, radius, radius, smallRadius, 0, 2*M_PI, 0);
        CGContextClip(ctx);
        [images.firstObject drawInRect:CGRectMake(radius - smallRadius, radius - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, side - radius , side - radius, radius, 0, 2*M_PI, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, side - radius, side - radius, smallRadius, 0, 2*M_PI, 0);
        CGContextClip(ctx);
        [images[1] drawInRect:CGRectMake(side - radius - smallRadius, side - radius - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
    }
    
    if (images.count == 3) {
        radius = 0.26 * side;    //半径,当与正方形边的比例为0.26的时候,画出来的样式比较合适
        smallRadius = radius - borderWidth; //图片圆半径
        CGFloat CtoC = radius;   //矩形中心到三个角距离
        angle = M_PI/3.0;        //正三角形夹角
        
        CGFloat x = CtoC*cos(angle/2.0);          //第一个圆与另外两个相差的x值
        CGFloat y = CtoC + CtoC*sin(angle/2.0);   //第一个圆与另外两个相差的y值
        margin = (side - (2*radius + y))/2.0;     //大圆到上下边的距离
        first = CGPointMake(side/2.0, radius + margin);
        
        // 画大圆
        CGContextAddArc(ctx, first.x , first.y, radius, 0, 2*M_PI, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x, first.y, smallRadius, 0, 2*M_PI, 0);
        CGContextClip(ctx);
        [images.firstObject drawInRect:CGRectMake(first.x - smallRadius, first.y - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, first.x + x, first.y + y, radius, 0, 2*M_PI, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x + x, first.y + y, smallRadius, 0, 2*M_PI, 0);
        CGContextClip(ctx);
        [images[1] drawInRect:CGRectMake(first.x + x - smallRadius, margin + borderWidth + y, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, first.x - x, first.y + y, radius, 0, 2*M_PI, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x - x, first.y + y, smallRadius, 0, 2*M_PI, 0);
        CGContextClip(ctx);
        [images[2] drawInRect:CGRectMake(first.x - smallRadius -x, margin + borderWidth + y, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 让第一个圆遮住最后一个圆一部分,画出扇形
        CGContextAddArc(ctx, first.x , first.y, radius, M_PI_2, M_PI_2 + M_PI/3.0, 0);
        CGContextFillPath(ctx);
        
        // 在扇形里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x, first.y, smallRadius, M_PI_2, M_PI_2 + M_PI/3.0, 0);
        CGContextAddLineToPoint(ctx, first.x, first.y);
        CGContextClosePath(ctx);
        CGContextClip(ctx);
        [images.firstObject drawInRect:CGRectMake(first.x - smallRadius, first.y - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
    }
    
    
    if (images.count == 4) {
        margin = 0.02 * side;
        radius = 0.26 * side;    //半径
        CGFloat sectorAngle =asin(((side - 2*(margin+radius))/2)/radius); //两圆交点与圆心组成的扇形的半径的一半
        smallRadius = radius - borderWidth; //图片圆半径
        CGFloat CtoB = radius + margin; //圆心到边缘的距离
        
        // 画大圆
        CGContextAddArc(ctx, CtoB, CtoB, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, CtoB, CtoB, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images.firstObject drawInRect:CGRectMake(CtoB - smallRadius, CtoB - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, side-CtoB, CtoB, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, side-CtoB, CtoB, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images[1] drawInRect:CGRectMake(side - CtoB - smallRadius, CtoB - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, side - CtoB, side - CtoB, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, side - CtoB, side - CtoB, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images[2] drawInRect:CGRectMake(side - CtoB - smallRadius, side - CtoB - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, CtoB, side - CtoB, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, CtoB, side - CtoB, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images[3] drawInRect:CGRectMake(CtoB - smallRadius, side - CtoB - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        
        // 让第一个圆遮住最后一个圆一部分,画出扇形
        CGContextAddArc(ctx, CtoB, CtoB, radius, sectorAngle, M_PI - sectorAngle, 0);
        CGContextFillPath(ctx);
        
        // 在扇形里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, CtoB,  CtoB, smallRadius, sectorAngle, M_PI - sectorAngle, 0);
        CGContextAddLineToPoint(ctx, CtoB, CtoB);
        CGContextClosePath(ctx);
        CGContextClip(ctx);
        [images.firstObject drawInRect:CGRectMake(CtoB - smallRadius, CtoB - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
    }
    
    if (images.count >= 5) {
        radius = 0.21 * side;     //半径
        smallRadius = radius - borderWidth;
        CGFloat CtoC = 0.3*side;  //正方形中心到圆心距离
        angle = 2*M_PI/5.0;       //相邻圆心到矩形中心的两条线组成的夹角
        margin = (side - (cos(angle/2.0)*CtoC + CtoC + 2*radius))/2.0; //上方与下方边距
        first = CGPointMake(side/2.0, radius+margin);
        
        CGFloat x1 = sin(angle)*CtoC;               //第一个圆与第二个第五个x值得差
        CGFloat y1 = CtoC- cos(angle)*CtoC;         //第一个圆与第二个第五个y值得差
        CGFloat x2 = sin(angle/2.0)*CtoC;           //第一个圆与第三个第四个x值得差
        CGFloat y2 = CtoC + cos(angle/2.0)*CtoC;    //第一个圆与第三个第四个y值得差
        
        // 画大圆
        CGContextAddArc(ctx, first.x, first.y, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x, first.y, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images.firstObject drawInRect:CGRectMake(first.x - smallRadius, first.y - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, first.x + x1, first.y + y1, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x  + x1, first.y  + y1, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images[1] drawInRect:CGRectMake(first.x  + x1 - smallRadius, first.y  + y1 - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, first.x + x2, first.y + y2, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x  + x2, first.y  + y2, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images[2] drawInRect:CGRectMake(first.x  + x2 - smallRadius, first.y  + y2 - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, first.x - x2, first.y + y2, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x  - x2, first.y  + y2, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images[3] drawInRect:CGRectMake(first.x  - x2 - smallRadius, first.y  + y2 - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 画大圆
        CGContextAddArc(ctx, first.x - x1, first.y + y1, radius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx);
        
        // 在小圆里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x  - x1, first.y  + y1, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(ctx);
        [images[4] drawInRect:CGRectMake(first.x  - x1 - smallRadius, first.y  + y1 - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
        
        // 让第一个圆遮住最后一个圆一部分,画出扇形
        CGFloat sectorAngle = 2*acos((sin(angle/2.0)*CtoC)/radius); //两圆交点与圆心组成扇形的夹角
        CGContextAddArc(ctx, first.x, first.y, radius, M_PI-angle/2.0-sectorAngle/2.0, M_PI-angle/2.0+sectorAngle/2.0, 0);
        CGContextFillPath(ctx);
        
        // 在扇形里画图片
        CGContextSaveGState(ctx);
        CGContextAddArc(ctx, first.x, first.y, smallRadius, M_PI-angle/2.0-sectorAngle/2.0, M_PI-angle/2.0+sectorAngle/2.0, 0);
        CGContextAddLineToPoint(ctx, first.x, first.y);
        CGContextClosePath(ctx);
        CGContextClip(ctx);
        [images.firstObject drawInRect:CGRectMake(first.x - smallRadius, first.y - smallRadius, 2*smallRadius, 2*smallRadius)];
        CGContextRestoreGState(ctx);
    }
    
    // 取图
    UIImage *gropIcon = UIGraphicsGetImageFromCurrentImageContext();
    
    
    //压缩
    NSData *data = UIImageJPEGRepresentation(gropIcon, 0.3);
//    NSData * imageData1 = UIImagePNGRepresentation(img);//无损
    DDDLog(@"%s %ld",__FUNCTION__,(unsigned long)data.length);
    gropIcon = [UIImage imageWithData:data];
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return gropIcon;
}

@end
