//
//  ProcessController.h
//  StudentLoan
//
//  Created by zhou on 16/3/16.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProcessProtocol <NSObject>

@optional
@property (nonatomic, weak)id processParam;

@optional
- (void)preProcessor;
- (void)postProcessor;

@end