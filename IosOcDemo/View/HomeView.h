//
//  HomeView.h
//  IosOcDemo
//
//  Created by Zhou on 2016/10/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

typedef NSString *(^AddNum)(int a,int b);

@interface HomeView : BaseView

- (NSString *)getComputer:(AddNum)addNum;

@end
