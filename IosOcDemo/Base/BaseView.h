//
//  BaseView.h
//  IosOcDemo
//
//  Created by Zhou on 2016/10/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewProtocol.h"
#import "ViewComponent.h"
#import <Masonry/Masonry.h>

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define DENSITY [UIScreen mainScreen].bounds.size.width/320.

@interface BaseView : UIView<ViewOfControllerProtocol>

@end
