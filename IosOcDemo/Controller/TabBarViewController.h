//
//  TabBarViewController.h
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface TabBarViewController : UITabBarController<UITabBarControllerDelegate>{
    NSArray *tabbarItems;
    NSArray *controllerItems;
}

@end
