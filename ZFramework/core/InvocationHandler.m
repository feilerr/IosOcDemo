//
//  InvocationHandler.m
//  StudentLoan
//
//  Created by zhou on 16/4/11.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "InvocationHandler.h"

@implementation InvocationHandler

- (instancetype)initWithTarget:(id)target{
    self = [super init];
    if (self) {
        invokeObject = target;
    }
    return self;
}

-(void)proxyInvoke{
    if (self.delegate != nil && [self.delegate conformsToProtocol:@protocol(ProcessProtocol)]==YES) {
        if ([self.delegate respondsToSelector:@selector(preProcessor)] == YES) {
            [self.delegate preProcessor];
        }
    }
    if ([invokeObject respondsToSelector:self.interfaceMethod]){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[invokeObject methodSignatureForSelector:_interfaceMethod]];
        invocation.target = invokeObject;
        invocation.selector = _interfaceMethod;
        [invocation invoke];
    }else{
        NSLog(@"方法没有实现");
    }
    if (self.delegate != nil && [self.delegate conformsToProtocol:@protocol(ProcessProtocol)]==YES) {
        if ([self.delegate respondsToSelector:@selector(postProcessor)] == YES) {
            [self.delegate postProcessor];
        }
    }
}

- (void)preProcessor{
}

- (void)postProcessor{
}

@end
