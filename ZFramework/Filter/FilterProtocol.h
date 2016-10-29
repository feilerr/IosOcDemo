//
//  FilterDelegate.h
//  ZFramework
//
//  Created by zhou on 16/1/13.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageProtocol.h"

@protocol FilterProtocol <NSObject>

@property (nonatomic, weak) NSObject *filterObject;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *tagName;

@optional

- (BOOL)performFilter;

@end
