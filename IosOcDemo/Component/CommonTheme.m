//
//  QLNavigation.m
//  StudentLoan
//
//  Created by zhou on 16/3/3.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "CommonTheme.h"
#import "PublicEvent.h"
#import "DefaultLoader.h"

@implementation CommonTheme

+ (void)loadNavigationTheme:(UINavigationController *)nav{
    UIColor *backColor = HEXCOLOR(0xffffff);
    UIColor *naviBarBgColor = backColor;
    UIColor *titleColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18.],NSFontAttributeName,titleColor,NSForegroundColorAttributeName,naviBarBgColor,NSBackgroundColorAttributeName,nil];
    [nav.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
    nav.navigationBar.barTintColor = backColor;
    nav.navigationBar.translucent = NO;
}


@end
