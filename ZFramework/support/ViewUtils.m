//
//  ViewUtils.m
//  StudentLoan
//
//  Created by zhou on 16/3/9.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "ViewUtils.h"

@implementation ViewUtils

//获取颜色分量
+ (NSArray *)getColor:(UIColor *)color{
    CGFloat red,green,blue,alpha;
    CGColorRef colorRef = [color CGColor];
    int numComponents = (int)CGColorGetNumberOfComponents(colorRef);
    if (numComponents >= 3)
    {
        const CGFloat *tmComponents = CGColorGetComponents(colorRef);
        red = tmComponents[0];
        green = tmComponents[1];
        blue = tmComponents[2];
        alpha = tmComponents[3];
    }
    return [NSArray arrayWithObjects:[NSNumber numberWithFloat:red],[NSNumber numberWithFloat:green],[NSNumber numberWithFloat:blue], nil];
}

@end
