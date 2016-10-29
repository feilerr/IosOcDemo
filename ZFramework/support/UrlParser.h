//
//  UrlParser.h
//  StudentLoan
//
//  Created by zhou on 16/5/23.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefaultLoader.h"

@protocol UrlParserProtocol <NSObject>

@property (nonatomic, weak) UIViewController *controller;

@end

@interface UrlParser : NSObject<UrlParserProtocol>

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSMutableDictionary *urlData;


- (BOOL)parseUrl:(NSString *)url;
+ (NSDictionary *)dicWithJsonString:(NSString *)jsonString;

@end
