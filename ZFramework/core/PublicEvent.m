//
//  PublicEvent.m
//  ZFramework
//
//  Created by zhou on 16/1/13.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "PublicEvent.h"
#import <objc/runtime.h>

@interface PublicEvent ()

@property (nonatomic,strong) NSString *eventName;

@end

@implementation PublicEvent

-(instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        self.eventName = name;
        self.params = [NSArray array];
    }
    return self;
}

SEL PESelectorWithName(const char *name) {
    NSUInteger nameLength = strlen(name);
    char selector[nameLength + 1];
    memcpy(selector, name, nameLength);
    selector[nameLength] = '\0';
    return sel_registerName(selector);
}

-(void)EventInvoke:(id)target{
    const char *n = [_eventName UTF8String];
    SEL selector = PESelectorWithName(n);
    if ([target respondsToSelector:selector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        for (int i=2; i<(_params.count+2); i++) {
            id param = [_params objectAtIndex:(i-2)];
            [invocation setArgument:&param atIndex:i];
        }
        [invocation invoke];
    }else{
        NSLog(@"%@方法没有实现",_eventName);
    }
}

- (id)EventInvokeForObject:(id)target{
    const char *n = [_eventName UTF8String];
    SEL selector = PESelectorWithName(n);
    id result = nil;
    if ([target respondsToSelector:selector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        for (int i=2; i<(_params.count+2); i++) {
            id param = [_params objectAtIndex:(i-2)];
            [invocation setArgument:&param atIndex:i];
        }
        [invocation invoke];
        id __unsafe_unretained tempResultSet;
        [invocation getReturnValue:&tempResultSet];
        result = tempResultSet;
    }else{
        NSLog(@"%@方法没有实现",_eventName);
    }
    return result;
}

- (BOOL)EventInvokeForBool:(id)target{
    const char *n = [_eventName UTF8String];
    SEL selector = PESelectorWithName(n);
    BOOL result = YES;
    if ([target respondsToSelector:selector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        for (int i=2; i<(_params.count+2); i++) {
            id param = [_params objectAtIndex:(i-2)];
            [invocation setArgument:&param atIndex:i];
        }
        [invocation invoke];
        [invocation getReturnValue:&result];
    }else{
        NSLog(@"%@方法没有实现",_eventName);
    }
    return result;
}

- (int)EventInvokeForInt:(id)target{
    const char *n = [_eventName UTF8String];
    SEL selector = PESelectorWithName(n);
    int result = 0;
    if ([target respondsToSelector:selector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        for (int i=2; i<(_params.count+2); i++) {
            id param = [_params objectAtIndex:(i-2)];
            [invocation setArgument:&param atIndex:i];
        }
        [invocation invoke];
        [invocation getReturnValue:&result];
    }else{
        NSLog(@"%@方法没有实现",_eventName);
    }
    return result;
}

- (CGFloat)EventInvokeForFloat:(id)target{
    const char *n = [_eventName UTF8String];
    SEL selector = PESelectorWithName(n);
    CGFloat result = 0.;
    if ([target respondsToSelector:selector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        for (int i=2; i<(_params.count+2); i++) {
            id param = [_params objectAtIndex:(i-2)];
            [invocation setArgument:&param atIndex:i];
        }
        [invocation invoke];
        [invocation getReturnValue:&result];
    }else{
        NSLog(@"%@方法没有实现",_eventName);
    }
    return result;
}

+ (void)guiding:(NSObject *)obj from:(SEL)before to:(SEL)after {
    
    Class class = [obj class];
    SEL originalSelector = before;
    SEL currentSelector = after;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method currentMethod = class_getInstanceMethod(class, currentSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(currentMethod), method_getTypeEncoding(currentMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, currentSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, currentMethod);
    }
}

@end
