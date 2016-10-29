//
//  FilterImplement.m
//  ZFramework
//
//  Created by zhou on 16/1/13.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "FilterImplement.h"
#import "MessageProtocol.h"

@implementation FilterImplement

@synthesize filterObject,message,filterList,tagName;

-(instancetype)init{
    self = [super init];
    if (self) {
        self.filterList = [NSMutableArray array];
        self.tagName = @"";
    }
    return self;
}

/**
 * 循环过滤器，过滤器中实现筛选
 **/
-(BOOL)performFilter{
    for (int i = 0; i < self.filterList.count; i++) {
        id<FilterProtocol> filter = [self.filterList objectAtIndex:i];
        BOOL isSuccess = [filter performFilter];
        if (!isSuccess) {
            if (self.messageSource == nil) {
                NSLog(@"请设置好消息处理");
                return NO;
            }
            [self.messageSource show:filter.message];
            return NO;
        }
    }
    return YES;
}

- (id)addFilter:(id<FilterProtocol>)filter{
    if (filter != nil) {
        [self.filterList addObject:filter];
    }
    return self;
}

- (void)removeFilter:(id<FilterProtocol>)filter{
    [self.filterList removeObject:filter];
}

- (void)clean{
    [self.filterList removeAllObjects];
}
@end
