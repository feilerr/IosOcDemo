//
//  DefaultLoader.h
//  ZFramework
//
//  Created by Zhou on 15/11/7.
//  Copyright © 2015年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Loader.h"
#import "ProcessProtocol.h"

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define DefaultLoader [ZDefaultLoader sharedInstance]
#define SCREENDENSITY [UIScreen mainScreen].bounds.size.width/320.
#define TextColor [UIColor colorWithRed:68./255. green:68./255. blue:68./255. alpha:1.0]
#define TextSize [UIFont systemFontOfSize:15.]
#define DefaultBlue [UIColor colorWithRed:41./255. green:176./255. blue:244./255. alpha:1.0]

@interface ZDefaultLoader : Loader

@property (nonatomic,strong) id<ProcessProtocol> pushViewControllerProcessor;

+ (ZDefaultLoader *) sharedInstance;
- (void)updateDisplay:(id)obj style:(NSString *)styleName;
- (void)pushViewController:(UIViewController *)presentController target:(NSString *)targetName param:(NSDictionary *)params;
- (void)presentViewController:(UIViewController *)presentController target:(NSString *)targetName param:(NSDictionary *)params;

@end
