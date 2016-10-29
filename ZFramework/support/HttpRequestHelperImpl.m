//
//  HttpRequestHelperImpl.m
//  StudentLoan
//
//  Created by zhou on 16/4/1.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "HttpRequestHelperImpl.h"

static HttpRequestHelperImpl *helperImpl = nil;

@implementation HttpRequestHelperImpl

@synthesize requestList,isRunning;

-(instancetype)init{
    self = [super init];
    if (self) {
        self.requestList = [[NSMutableArray alloc]init];
        self.uuid_isValid = NO;
        self.isErrorShow = NO;
    }
    return self;
}

+ (instancetype) sharedInstance
{
    static dispatch_once_t onceRequestShared;
    dispatch_once(&onceRequestShared, ^{
        helperImpl = [[self alloc]init];
    });
    return helperImpl;
}

- (void)addRequest:(id<HttpRequestProtocol>)request{
    
    BOOL isloading = NO;
    //发起请求前的准备工作
    if ([request respondsToSelector:@selector(prepareRequest)]) {
        BOOL isSuccess = [request prepareRequest];
        if (!isSuccess) {
            return;
        }
    }
    //如果加载正在运行
    for (id<HttpRequestProtocol> p in self.requestList) {
        if (p.isRunning == YES) {
            isloading = YES;
            break;
        }
    }
    //如果本次请求需要加载视图
    if (isloading == NO && request.needLoading == YES) {
        [request start];
        if (timer != nil) {
            [timer invalidate];
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:15. target:request selector:@selector(stop) userInfo:nil repeats:NO];
    }
    [self.requestList addObject:request];

    const char *label = [[[request class] description] UTF8String];
    dispatch_queue_t queue = dispatch_queue_create(label, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(queue, ^{
        OSSpinLockLock(&(requestLock));
        [request requestProcess];
    });
}

- (void)removeRequest:(id<HttpRequestProtocol>)request{
    OSSpinLockUnlock(&(requestLock));
    [self.requestList removeObject:request];
    BOOL hasRequest = NO;
    for (id<HttpRequestProtocol> p in self.requestList) {
        if (p.isRunning == YES) {
            hasRequest = YES;
            break;
        }
    }
    if (!hasRequest) {
        [request stop];
    }
}

- (BOOL)checkErrorShow{
    if (self.isErrorShow) {
        return YES;
    }else{
        self.isErrorShow = YES;
        if (errorShowTimer != nil) {
            [errorShowTimer invalidate];
        }
        errorShowTimer = [NSTimer scheduledTimerWithTimeInterval:10. target:self selector:@selector(resetErrorShow) userInfo:nil repeats:NO];
        return NO;
    }
}

- (void)resetErrorShow{
    self.isErrorShow =  NO;
}

@end
