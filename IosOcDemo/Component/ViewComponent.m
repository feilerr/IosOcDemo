//
//  ViewComponent.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "ViewComponent.h"

#pragma mark 自定义TabBar
@implementation QLTabBarItem

- (void)loadDefault{
    _showMark = false;
}

- (void)saveImage{
    saveSelectedImage = self.selectedImage;
    saveImage = self.image;
}

- (void)refresh:(NSString *)str{
    countStr = str;
    if (_showMark) {
        self.selectedImage = [self drawMark:self.selectedImage mark:str];
        self.image = [self drawMark:self.image mark:str];
    }else{
        self.selectedImage = [self drawImage:saveSelectedImage];
        self.image = [self drawImage:saveImage];
    }
    
    [self setImage:[self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self setSelectedImage:[self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (UIImage *)drawMark:(UIImage *)image mark:(NSString *)str{
    CGSize sz = [image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height), NO, 0);
    [image drawInRect:CGRectMake(9,7,26,26)];
    QLImage *circle = [[QLImage alloc]init];
    circle.message = str;
    CGFloat circleRadius = 6.;
    [circle drawInRect:CGRectMake(33, 7, circleRadius, circleRadius)];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

- (UIImage *)drawImage:(UIImage *)image{
    CGSize sz = [image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height), NO, 0);
    [image drawInRect:CGRectMake(9,7,26,26)];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}


@end

#pragma mark 修改Image
@implementation QLImage

- (void)drawInRect:(CGRect)rect{
    [super drawInRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextFillPath(ctx);
    if (self.message.length>0) {
        if (self.message.length == 1) {
            [self drawLabel:ctx frame:CGRectMake(16, 1, rect.size.width, rect.size.height) txt:self.message];
        }else{
            [self drawLabel:ctx frame:CGRectMake(15, 1, rect.size.width, rect.size.height) txt:self.message];
        }
    }
}

- (void)drawLabel:(CGContextRef)ctx frame:(CGRect)rect txt:(NSString *)title{
    NSAttributedString *attriString = [self getAttributedString:title];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    if (frame) {
        CGContextSaveGState(ctx);
        CGContextTranslateCTM(ctx, 0, rect.origin.y);
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -(rect.origin.y + rect.size.height));
        CTFrameDraw(frame, ctx);
        CGContextRestoreGState(ctx);
        CFRelease(frame);
    }
    CFRelease(path);
    CFRelease(framesetter);
}

-(NSMutableAttributedString *)getAttributedString:(NSString *)title{
    NSString *str=title;
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    [attriString addAttribute:(id)kCTParagraphStyleAttributeName value:(id)paragrapStyle range:NSMakeRange(0, str.length)];
    CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica"), 8., NULL);
    [attriString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1.0 green:1.0 blue:1. alpha:1.0]} range:NSMakeRange(0, str.length)];
    
    [attriString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, str.length)];
    return attriString;
}

@end
