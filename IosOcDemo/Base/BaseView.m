//
//  BaseView.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

@synthesize controller;

- (void)loadDefault{
    self.frame = self.controller.view.frame;
    self.controller.view = self;
    
}

@end
