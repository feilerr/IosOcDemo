//
//  JSViewController.h
//  StudentLoan
//
//  Created by zhou on 16/3/25.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

typedef void(^JSInterface)();

@protocol JSViewProtocol<JSExport>

@required
- (void)configJSInterface:(UIWebView *)jsWebview;

@optional

//无返回无参数js调用
- (void)JSAction;
//带一个参数的
- (void)JSAction:(id)param;
//返回一个字符串
- (NSString *)JSActionForString:(id)param;

@end

