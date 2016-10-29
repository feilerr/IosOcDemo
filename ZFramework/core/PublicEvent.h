//
//  PublicEvent.h
//  ZFramework
//
//  Created by zhou on 16/1/13.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PublicEvent : NSObject

@property (nonatomic,copy) NSArray *params;//参数字符，按顺序加入
@property (nonatomic,copy) id resultData;

/**
 ** name 事件名称
 **/
- (instancetype)initWithName:(NSString *)name;
- (void)EventInvoke:(id)target;
- (id)EventInvokeForObject:(id)target;
- (BOOL)EventInvokeForBool:(id)target;
- (int)EventInvokeForInt:(id)target;
- (CGFloat)EventInvokeForFloat:(id)target;
/**
 ** 替换对象obj的方法before为after
 **/
+ (void)guiding:(NSObject *)obj from:(SEL)before to:(SEL)after;
@end
