//
//  PublishViewController.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    BaseView *view = (BaseView *)self.view;
    [view refresh];
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
