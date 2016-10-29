//
//  HomeView.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

- (void)loadDefault{
    [super loadDefault];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, self.frame.size.width-40, 45)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self.controller action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

@end
