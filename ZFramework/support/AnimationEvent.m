//
//  AnimationEvent.m
//  ZFramework
//
//  Created by zhou on 16/2/2.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "AnimationEvent.h"

static CGFloat DURATION = 0.3;

@implementation AnimationEvent

-(void)toRemove:(UIView *)view
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DURATION * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [view removeFromSuperview];
    });
}

@end

@implementation AnimationMove

- (void)Animation:(UIView *)view type:(AnimationEventType)animType{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    CGFloat height = view.frame.size.height;
    switch (animType) {
        case FROMBOTTOM:
            view.frame = CGRectMake(0, window.frame.size.height, window.frame.size.width, height);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:DURATION];
            [view setFrame:CGRectMake(0, window.frame.size.height-height, window.frame.size.width, height)];
            [UIView commitAnimations];
            break;
        case TOBOTTOM:
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:DURATION];
            [view setFrame:CGRectMake(0, window.frame.size.height, window.frame.size.width, height)];
            [UIView commitAnimations];
            [self toRemove:view];
            break;
    }
}



@end
