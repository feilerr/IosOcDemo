//
//  LoaderProtocol.h
//  StudentLoan
//
//  Created by zhou on 16/3/9.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LoaderProtocol <NSObject>

/**
 ** className 传递类名
 **/
- (id)loadFromName:(NSString *)className;

/**
 ** dic 传递属性对象
 **/
- (id)loadFromName:(NSString *)className params:(NSDictionary *)dic;


/**
 ** obj 启动事件的对象;eventName，事件名称
 **/
- (void)loadEvent:(id)obj event:(NSString *)eventName;

/**
 ** obj 启动事件的对象;eventName，事件名称;params,按事件参数名顺序传入；无返回值
 **/
- (void)loadEvent:(id)obj event:(NSString *)eventName param:(NSArray *)params;

- (id)loadEventForObject:(id)obj event:(NSString *)eventName param:(NSArray *)params;
- (BOOL)loadEventForBool:(id)obj event:(NSString *)eventName param:(NSArray *)params;
- (int)loadEventForInt:(id)obj event:(NSString *)eventName param:(NSArray *)params;
- (CGFloat)loadEventForFloat:(id)obj event:(NSString *)eventName param:(NSArray *)params;

@end


@interface Loader : NSObject<LoaderProtocol>

/**
 ** params 传递属性对象 target 属性的接收者
 **/
+ (void)setPropertyValue:(NSDictionary *)params target:(id)obj;

@end