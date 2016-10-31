//
//  ViewComponent.h
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "ViewProtocol.h"

@interface QLTabBarItem : UITabBarItem<ViewCreateProtocol>{
    NSString *countStr;
    UIImage *saveSelectedImage;
    UIImage *saveImage;
}

@property (nonatomic, assign) BOOL showMark;

- (void)saveImage;

@end

@interface QLImage : UIImage<ViewDefaultProtocol>

@property (nonatomic, strong) NSString *message;

@end
