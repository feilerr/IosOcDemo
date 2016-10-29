//
//  HttpRequestHelperImpl.h
//  StudentLoan
//
//  Created by zhou on 16/4/1.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestProtocol.h"
#import "PublicEvent.h"
#import <objc/objc-auto.h>

#define RequestHelper [HttpRequestHelperImpl sharedInstance]

@interface HttpRequestHelperImpl : NSObject<HttpRequestHelper>{
    NSTimer *timer;
    NSTimer *errorShowTimer;
    OSSpinLock requestLock;
}

@property (nonatomic, strong) PublicEvent *pushSelector;//请求前动画事件
@property (nonatomic, strong) PublicEvent *popSelector;//请求后动画事件
@property (nonatomic) BOOL uuid_isValid;
@property (nonatomic) BOOL isErrorShow;//是否显示错误

+ (instancetype)sharedInstance;
- (BOOL)checkErrorShow;

@end
