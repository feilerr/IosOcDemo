//
//  Refreshable.h
//  StudentLoan
//
//  Created by zhou on 16/5/9.
//  Copyright © 2016年 SHQL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Refreshable <NSObject>

@optional
- (void)refresh;
- (void)refresh:(NSString *)str;

@end
