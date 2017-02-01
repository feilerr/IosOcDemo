//
//  HomeView.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "HomeView.h"
#import <objc/runtime.h>

@implementation HomeView

- (void)loadDefault{
    [super loadDefault];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, self.frame.size.width-40, 45)];
//    btn.backgroundColor = [UIColor blueColor];
//    [btn addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn setFrame:CGRectMake(50, 50, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)click:(UIButton *)sender
{
    NSString *message = @"你是谁";
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"我要传值·" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.delegate = self;
    [alert show];
    
    objc_setAssociatedObject(alert, @"msgstr", message,OBJC_ASSOCIATION_ASSIGN);
    //把alert和message字符串关联起来，作为alertview的一部分，关键词就是msgstr，之后可以使用objc_getAssociatedObject从alertview中获取到所关联的对象，便可以访问message或者btn了
    
    //    即实现了关联传值
    objc_setAssociatedObject(alert, @"btn property",sender,OBJC_ASSOCIATION_ASSIGN);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    //通过 objc_getAssociatedObject获取关联对象
    NSString  *messageString =objc_getAssociatedObject(alertView, @"msgstr");
    
    
    UIButton *sender = objc_getAssociatedObject(alertView, @"btn property");
    NSLog(@"%ld",buttonIndex);
    NSLog(@"%@",messageString);
    NSLog(@"%@",[[sender titleLabel] text]);
    
    
    //使用函数objc_removeAssociatedObjects可以断开所有关联。通常情况下不建议使用这个函数，因为他会断开所有关联。只有在需要把对象恢复到“原始状态”的时候才会使用这个函数。
}

- (void)toLogin:(id)sender{

}


@end
