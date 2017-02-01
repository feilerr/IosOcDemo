//
//  FileOperate.h
//  IosOcDemo
//
//  Created by Zhou on 2017/1/30.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperate : NSObject

/**
 *  获得Documents 目录
 */
+ (NSString *)getDocumentDirectory;

/**
 *  在Documents 下创建目录
 */
+ (BOOL)createDocumentDirectory:(NSString *)name;

/**
 *  在Documents 下创建文件
 */
+ (BOOL)createDocumentFile:(NSString *)fileName dir:(NSString *)directory content:(NSString *)content;

@end
