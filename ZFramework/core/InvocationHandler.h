//
//  InvocationHandler.h
//  StudentLoan
//
//  Created by zhou on 16/4/11.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "ProcessProtocol.h"

@protocol  InvocationHandlerProtocol<NSObject>

- (void)proxyInvoke;

@end


@interface InvocationHandler : NSObject<InvocationHandlerProtocol>{
    id invokeObject;
}

@property (nonatomic, nullable) id<ProcessProtocol> delegate;
@property (nonatomic, nullable) SEL interfaceMethod;

- (nullable instancetype)initWithTarget:(nullable id)target;

@end


