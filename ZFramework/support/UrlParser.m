//
//  UrlParser.m
//  StudentLoan
//
//  Created by zhou on 16/5/23.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "UrlParser.h"
#import "PublicEvent.h"

@implementation UrlParser

@synthesize controller;

+ (NSDictionary *)dicWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (BOOL)parseUrl:(NSString *)url{
    NSRange r1 = [url rangeOfString:@":"];
    NSString *appName = [url substringToIndex:r1.location];
    if (![appName isEqualToString:@"uzone"]) {
        return NO;
    }
    NSRange r2 = [url rangeOfString:@"//"];
    NSRange r3 = [url rangeOfString:@"?"];
    NSUInteger classNameLeng = r3.location-r2.location-r2.length;
    self.className = [url substringWithRange:NSMakeRange(r2.location+r2.length, classNameLeng)];
    
    NSString *url_params = [url substringFromIndex:(r3.location+r3.length)];
    NSArray *params = [url_params componentsSeparatedByString:@"&"];
    if (params == nil) {
        params = [NSArray arrayWithObjects:url_params, nil];
    }
    self.urlData = [[NSMutableDictionary alloc]init];
    for (int i=0 ; i<params.count; i++) {
        NSString *p = [params objectAtIndex:i];
        NSArray *keyAndValue = [p componentsSeparatedByString:@"="];
        NSString *key = [keyAndValue objectAtIndex:0];
        NSString *value = [keyAndValue objectAtIndex:1];
        if ([key isEqualToString:@"data"]) {
            value = [self URLDecodedString:value];
            value = [NSString stringWithCString:[value cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
            NSDictionary *data = [UrlParser dicWithJsonString:value];
            [self.urlData setValue:data forKey:key];
        }else{
            [self.urlData setValue:value forKey:key];
        }
    }
    [self urlInvoke];
    return YES;
}

-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

- (void)urlInvoke{
    NSString *first = [[self.className substringToIndex:1] uppercaseString];
    NSString *last = [self.className substringFromIndex:1];
    id<UrlParserProtocol> object = [DefaultLoader loadFromName:[NSString stringWithFormat:@"%@%@",first,last] params:[self.urlData objectForKey:@"data"]];
    if (object != nil) {
        [object setController:self.controller];
        PublicEvent *event = [[PublicEvent alloc]initWithName:[self.urlData objectForKey:@"methodName"]];
        [event EventInvoke:object];
    }
}

@end
