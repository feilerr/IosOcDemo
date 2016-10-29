//
//  DefaultLoader.m
//  ZFramework
//
//  Created by Zhou on 15/11/7.
//  Copyright © 2015年 zhou. All rights reserved.
//

#import "DefaultLoader.h"
#import "ViewProtocol.h"
#import "PublicEvent.h"

@implementation ZDefaultLoader

static ZDefaultLoader *loaderShare = nil;

+ (ZDefaultLoader *) sharedInstance
{
    static dispatch_once_t onceloaderShared;
    dispatch_once(&onceloaderShared, ^{
        loaderShare=[[self alloc]init];
    });
    return loaderShare;
}

-(instancetype)init{
    self=[super init];
    if (self) {
    }
    return self;
}

- (id)loadFromName:(NSString *)className{
    
    id obj = [super loadFromName:className];
    if ([obj conformsToProtocol:@protocol(ViewCreateProtocol)]) {
        [obj performSelector:@selector(loadDefault) withObject:nil];
    }
    return obj;
}

- (id)loadFromName:(NSString *)className andParams:(NSDictionary *)dic{
    id obj = [super loadFromName:className params:dic];
    return obj;
}

- (void)updateDisplay:(id)obj style:(NSString *)styleName{
    if ([obj conformsToProtocol:@protocol(ViewCreateProtocol)]) {
        PublicEvent *publicEvent = [[PublicEvent alloc]initWithName:styleName];
        [publicEvent EventInvoke:obj];
    }
}

- (void)pushViewController:(UIViewController *)presentController target:(NSString *)targetName param:(NSDictionary *)params{
    if (self.pushViewControllerProcessor != nil) {
        [self.pushViewControllerProcessor preProcessor];
        UIViewController *controller = [DefaultLoader loadFromName:targetName];
        controller.hidesBottomBarWhenPushed = YES;
        [Loader setPropertyValue:params target:controller];
        [presentController.navigationController pushViewController:controller animated:NO];
        [self.pushViewControllerProcessor postProcessor];
    }else{
        UIViewController *controller = [DefaultLoader loadFromName:targetName];
        controller.hidesBottomBarWhenPushed = YES;
        [Loader setPropertyValue:params target:controller];
        [presentController.navigationController pushViewController:controller animated:YES];
    }
}

- (void)presentViewController:(UIViewController *)presentController target:(NSString *)targetName param:(NSDictionary *)params{
    UIViewController *controller = [DefaultLoader loadFromName:targetName];
    UINavigationController *loginNavigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    [presentController presentViewController:loginNavigationController animated:YES completion:nil];
}

@end
