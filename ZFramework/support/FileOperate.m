//
//  FileOperate.m
//  IosOcDemo
//
//  Created by Zhou on 2017/1/30.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "FileOperate.h"

@implementation FileOperate

#pragma mark 获得Documents 目录
+ (NSString *)getDocumentDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (BOOL)createDocumentDirectory:(NSString *)name{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [FileOperate getDocumentDirectory];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:name];
    BOOL result = NO;
    if (![fileManager fileExistsAtPath:myDirectory]) {
        result = [fileManager createDirectoryAtPath:myDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return result;
}

+ (BOOL)createDocumentFile:(NSString *)fileName dir:(NSString *)directory content:(NSString *)content{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = YES;
    if (![fileManager fileExistsAtPath:directory]) {
        isExist = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    if (!isExist) {
        NSLog(@"目录不存在");
    }
    NSString *path = [directory stringByAppendingPathComponent:fileName];
    BOOL result = [fileManager createFileAtPath:path contents:[content  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    return result;
}

@end
