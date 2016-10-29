//
//  AnimationEvent.h
//  ZFramework
//
//  Created by zhou on 16/2/2.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FROMBOTTOM,
    TOBOTTOM,
} AnimationEventType;

typedef void(^StartAnimation)(NSUInteger t);

@protocol AbstractAnimation <NSObject>

@optional
- (void)Animation:(UIView *)view type:(AnimationEventType)animType;

@end

@interface AnimationEvent : NSObject<AbstractAnimation>

-(void)toRemove:(UIView *)view;

@end

@interface AnimationMove : AnimationEvent


@end
