//
//  LifeCycle.h
//  StudentLoan
//
//  Created by zhou on 16/4/25.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol  LifeCycle<NSObject>

@property (nonatomic) BOOL isRunning;//一般这种状态代表请求挂起

@optional
- (void)start;
- (void)stop;

@end
