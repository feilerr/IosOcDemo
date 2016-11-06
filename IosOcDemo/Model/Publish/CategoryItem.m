//
//  CategoryItem.m
//  IosOcDemo
//
//  Created by Zhou on 2016/11/6.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "CategoryItem.h"

@implementation CategoryItem

- (instancetype)init{
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
