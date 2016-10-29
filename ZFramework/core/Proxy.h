//
//  Proxy.h
//  StudentLoan
//
//  Created by zhou on 16/4/11.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#include "InvocationHandler.h"
#import "Loader.h"

@interface Proxy : NSObject{
    IMP imp;
}

@property (nonatomic,strong) InvocationHandler *invocationHandler;

- (instancetype)initWithProtocol:(Protocol *)protocol handler:(InvocationHandler *)handler;

- (void)removeProxyMethod:(Protocol *)protocol;

@end

/** 使用实例
 //真实的对象，需要实现Subject协议
 RealSubject *real = [[RealSubject alloc]init];
 InvocationHandler *dynamicProxy = [[InvocationHandler alloc]initWithTarget:real];
 dynamicProxy.interfaceMethod = @selector(subject_request);
 dynamicProxy.delegate = self;
 id<Subject> proxySubject = (id<Subject>)[[Proxy alloc] initWithProtocol:@protocol(Subject) handler:dynamicProxy];
 [proxySubject subject_request];
 if ([proxySubject conformsToProtocol:@protocol(Subject)]) {
 NSLog(@"遵循协议");
 }
**/