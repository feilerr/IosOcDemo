//
//  CommuneViewController.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "CommuneViewController.h"

@interface CommuneViewController ()

@end

@implementation CommuneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交流";
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 25)];
    [btn setImage:[UIImage imageNamed:@"ic_switch_camera"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)rightBarButtonClick:(id)sender{
    BaseView *baseView = (BaseView *)self.view;
    [baseView refresh];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BaseView *baseView = (BaseView *)self.view;
    [baseView viewWillAppear];
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
