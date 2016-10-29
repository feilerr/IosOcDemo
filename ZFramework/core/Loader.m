//
//  LoaderProtocol.m
//  StudentLoan
//
//  Created by zhou on 16/3/9.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "Loader.h"
#import "PublicEvent.h"

@implementation Loader

- (id)loadFromName:(NSString *)className{
    Class clazz = NSClassFromString(className);
    id obj = [[clazz alloc]init];
    return obj;
}

- (id)loadFromName:(NSString *)className params:(NSDictionary *)dic{
    Class clazz = NSClassFromString(className);
    id obj = [[clazz alloc]init];
    [Loader setPropertyValue:dic target:obj];
    return obj;
}

+ (void)setPropertyValue:(NSDictionary *)params target:(id)obj{
    if (params != nil) {
        NSArray *array = params.allKeys;
        for (int i = 0; i < array.count; i++) {
            NSString *key = [array objectAtIndex:i];
            id propertyValue = [params valueForKey:key];
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [obj setValue:propertyValue forKey:key];
            }
        }
    }
}

- (void)loadEvent:(id)obj event:(NSString *)eventName{
    PublicEvent *publicEvent = [[PublicEvent alloc]initWithName:eventName];
    [publicEvent EventInvoke:obj];
}

- (void)loadEvent:(id)obj event:(NSString *)eventName param:(NSArray *)params{
    PublicEvent *publicEvent = [[PublicEvent alloc]initWithName:eventName];
    publicEvent.params = params;
    [publicEvent EventInvoke:obj];
}

- (id)loadEventForObject:(id)obj event:(NSString *)eventName param:(NSArray *)params{
    PublicEvent *publicEvent = [[PublicEvent alloc]initWithName:eventName];
    publicEvent.params = params;
    return [publicEvent EventInvokeForObject:obj];
}

- (BOOL)loadEventForBool:(id)obj event:(NSString *)eventName param:(NSArray *)params{
    PublicEvent *publicEvent = [[PublicEvent alloc]initWithName:eventName];
    publicEvent.params = params;
    return [publicEvent EventInvokeForBool:obj];
}

- (int)loadEventForInt:(id)obj event:(NSString *)eventName param:(NSArray *)params{
    PublicEvent *publicEvent = [[PublicEvent alloc]initWithName:eventName];
    publicEvent.params = params;
    return [publicEvent EventInvokeForInt:obj];
}

- (CGFloat)loadEventForFloat:(id)obj event:(NSString *)eventName param:(NSArray *)params{
    PublicEvent *publicEvent = [[PublicEvent alloc]initWithName:eventName];
    publicEvent.params = params;
    return [publicEvent EventInvokeForInt:obj];
}

@end
