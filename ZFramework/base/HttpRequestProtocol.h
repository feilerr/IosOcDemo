//
//  HttpRequestProtocol.h
//  ZFramework
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LifeCycle.h"

typedef enum : NSUInteger {
    GET,
    POST,
    UPLOADIMAGE
} HttpRequestType;

@protocol HttpRequestProtocol <LifeCycle>

@property (nonatomic, weak)id launcher;//发起请求的对象
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSDictionary *extParams;
@property (nonatomic) HttpRequestType httpRequestType;
@property (nonatomic, strong) id resultData;

@optional
@property (nonatomic,assign) BOOL needLoading;//是否需要显示loading对象
@property (nonatomic,assign) BOOL isSuccessResult;//是否成功返回数据

- (BOOL)prepareRequest;
- (void)requestProcess;
- (void)successResult:(id<HttpRequestProtocol>)httpRequest;
- (void)failureResult;
- (void)errorResult;

@end


@protocol HttpRequestHelper <LifeCycle>

@property (nonatomic, strong) NSMutableArray *requestList;

- (void)addRequest:(id<HttpRequestProtocol>)request;
- (void)removeRequest:(id<HttpRequestProtocol>)request;


@end