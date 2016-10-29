//
//  Proxy.m
//  StudentLoan
//
//  Created by zhou on 16/4/11.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "Proxy.h"
#import "PublicEvent.h"

//运行时获得方法的返回值类型
//SEL sel1 = @selector(ApplyBtnClick:);
//Method method = class_getInstanceMethod([self class], sel1);
//char *value = method_copyReturnType(method);
//返回的字符所对应的返回值，"i":int,"v":void,"@":NSString等对象,"c":BOOL,"f":CGFloat

@implementation Proxy

- (instancetype)initWithProtocol:(Protocol *)protocol handler:(InvocationHandler *)handler{
    self = [super init];
    if (self) {
        self.invocationHandler = handler;
        SEL invokeSelector = @selector(proxyMethod);
        Method proxyMethod = class_getInstanceMethod([self class], invokeSelector);
        imp = method_getImplementation(proxyMethod);
        BOOL addMethodSuccess = class_addMethod([self class], handler.interfaceMethod, imp, method_getTypeEncoding(proxyMethod));
        if (addMethodSuccess) {
            class_addProtocol([self class], protocol);
        }else{
            
        }
    }
    return self;
}

- (void)removeProxyMethod:(Protocol *)protocol{
    if (class_conformsToProtocol([self class], protocol)) {
        
    }
}

- (void)proxyMethodCancel{
    NSLog(@"协议方法取消");
}

- (void)proxyMethod{
    [self.invocationHandler proxyInvoke];
}

@end
