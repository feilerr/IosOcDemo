//
//  MessageSource.h
//  ZFramework
//
//  Created by zhou on 16/1/14.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ExecBlock)(NSString *);

typedef enum : NSUInteger {
    M_RIGHT,
    M_ERROR,
    M_WARN
} MessageType;

@protocol MessageProtocol <NSObject>

@property (nonatomic, weak) UIViewController *controller;

@optional
@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic) MessageType messageType;
@property (nonatomic) BOOL hasCloseBtn;

@optional
- (void)showToast:(NSString *)message completion:(void (^)(void))completing;
- (void)show:(NSString *)message;
- (void)showMultiText:(NSArray *)messages;
- (void)showAndClose:(NSString *)message tag:(int)tag;
- (void)show:(NSString *)message yes:(NSString *)yesStr no:(NSString *)noStr tag:(int)tag;
- (void)showBothBtn:(NSString *)message yes:(NSString *)yesStr no:(NSString *)noStr tag:(int)tag;
- (void)showBothBtnWithImage:(NSString *)message yes:(NSString *)yesStr no:(NSString *)noStr tag:(int)tag;

@end

