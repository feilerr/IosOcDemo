//
//  BaseViewController.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "BaseViewController.h"
#import "Loader.h"

@interface BaseViewController (){
    id<ViewOfControllerProtocol> view;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView{
    NSString *className = [[self.class description] stringByReplacingOccurrencesOfString:@"Controller" withString:@""];
    
    Loader *loader = [[Loader alloc]init];
    view = [loader loadFromName:className];
    [view setController:self];
    [view loadDefault];
    if (view == nil){
        NSLog(@"%@view为空",className);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
