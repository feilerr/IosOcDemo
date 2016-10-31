//
//  CollegeManager.h
//  IosOcDemo
//  coredata的管理类
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyClass+CoreDataClass.h"
#import "Student+CoreDataClass.h"
#import "Teacher+CoreDataClass.h"
#import "Course+CoreDataClass.h"

@interface CollectManager : NSObject

+ (CollectManager*)sharedManager;
- (void)save;
- (void)deleteEntity:(NSManagedObject*)obj;
- (void)initData;
- (void)search:(NSString *)entityName;
- (void)sort;
@end
