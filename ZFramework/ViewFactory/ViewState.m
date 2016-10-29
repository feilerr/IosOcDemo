//
//  ViewState.m
//  StudentLoan
//
//  Created by zhou on 16/3/23.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import "ViewState.h"

/**
    ——————序列化
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:viewState];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:@"GestureBtn"];
    ——————反序列化
    NSData *myEncodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"GestureBtn"];
    viewState = [NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
 **/

@implementation ViewState

- (instancetype)init{
    self = [super init];
    if (self) {
        self.rectList = [[NSMutableArray alloc]init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self){
        self.rectList = [coder decodeObjectForKey:@"rectList"];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.rectList forKey:@"rectList"];
}


@end
