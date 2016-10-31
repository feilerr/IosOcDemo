//
//  TabBarViewController.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewComponent.h"
#import "CommonTheme.h"

@interface TabBarViewController (){
    QLTabBarItem *item1,*item2,*item3,*item4;
}

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    item1 = [[QLTabBarItem alloc]init];
    item1.title = @"首页";
    [item1 setImage:[[UIImage imageNamed:@"navi11"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setSelectedImage:[[UIImage imageNamed:@"navi1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIViewController *ctrl1 = [DefaultLoader loadFromName:@"HomeViewController"];
    ctrl1.tabBarItem = item1;

    item2 = [[QLTabBarItem alloc]init];
    item2.title = @"交流";
    [item2 setImage:[[UIImage imageNamed:@"navi22"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setSelectedImage:[[UIImage imageNamed:@"navi2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIViewController *ctrl2 = [DefaultLoader loadFromName:@"CommuneViewController"];
    ctrl2.tabBarItem = item2;
    
    item3 = [[QLTabBarItem alloc]init];
    item3.title = @"发布";
    [item3 setImage:[[UIImage imageNamed:@"navi33"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item3 setSelectedImage:[[UIImage imageNamed:@"navi3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIViewController *ctrl3 = [DefaultLoader loadFromName:@"PublishViewController"];
    ctrl3.tabBarItem = item3;
    
    item4 = [[QLTabBarItem alloc]init];
    item4.title = @"用户";
    [item4 setImage:[[UIImage imageNamed:@"navi44"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item4 setSelectedImage:[[UIImage imageNamed:@"navi4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIViewController *ctrl4 = [DefaultLoader loadFromName:@"UserViewController"];
    ctrl4.tabBarItem = item4;
    tabbarItems = @[item1,item2,item3,item4];
    controllerItems = @[ctrl1,ctrl2,ctrl3,ctrl4];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:166/255.0 green:162/255. blue:157/255. alpha:1.0],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:12.0],NSFontAttributeName,nil];
    NSDictionary *dic_select = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:64/255.0 green:64/255. blue:64/255. alpha:1.0],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:12.0],NSFontAttributeName,nil];
    NSMutableArray *naviList = [[NSMutableArray alloc]init];
    for (int i = 0; i<tabbarItems.count; i++) {
        [((UITabBarItem *)[tabbarItems objectAtIndex:i]) setTitleTextAttributes:dic forState:UIControlStateNormal];
        [((UITabBarItem *)[tabbarItems objectAtIndex:i]) setTitleTextAttributes:dic_select forState:UIControlStateSelected];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[controllerItems objectAtIndex:i]];
        [CommonTheme loadNavigationTheme:navi];
        [naviList addObject:navi];
    }
    self.viewControllers = naviList;
    
    [item1 saveImage];
    item1.showMark = YES;
    [item1 refresh:@"4"];
    [item2 saveImage];
    [item2 refresh:@""];
    [item3 saveImage];
    [item3 refresh:@""];
    [item4 saveImage];
    [item4 refresh:@""];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
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
