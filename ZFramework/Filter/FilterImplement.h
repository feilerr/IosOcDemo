//
//  FilterImplement.h
//  ZFramework
//
//  Created by zhou on 16/1/13.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FilterProtocol.h"

@interface FilterImplement : NSObject<FilterProtocol>

@property (nonatomic, strong) NSMutableArray *filterList;//过滤器集合
//消息处理器
@property (nonatomic, strong) id<MessageProtocol> messageSource;

- (id)addFilter:(id<FilterProtocol>)filter;
- (void)clean;
- (void)removeFilter:(id<FilterProtocol>)filter;

@end
