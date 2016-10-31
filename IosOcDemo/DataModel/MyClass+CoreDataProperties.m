//
//  MyClass+CoreDataProperties.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "MyClass+CoreDataProperties.h"

@implementation MyClass (CoreDataProperties)

+ (NSFetchRequest<MyClass *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MyClass"];
}

@dynamic name;
@dynamic students;
@dynamic teacher;

@end
