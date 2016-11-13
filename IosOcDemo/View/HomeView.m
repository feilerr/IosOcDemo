//
//  HomeView.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

- (void)loadDefault{
    [super loadDefault];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, self.frame.size.width-40, 45)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
}

- (void)toLogin:(id)sender{
    NSString *s = [self getComputer:^(int a,int b){
        return [NSString stringWithFormat:@"%d",(a+b)];
    }];
    NSLog(@"两数之和：%@",s);
}

- (NSString *)getComputer:(AddNum)addNum{
    NSString *t = addNum(3,9);
    NSString * s = [NSString stringWithFormat:@"s"];
    return t;
}

@end
