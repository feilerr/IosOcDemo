//
//  ViewListener.h
//  ZFramework
//
//  Created by zhou on 16/1/13.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DefaultLoader.h"
#import "Refreshable.h"

#define SubViewTag  100

@protocol ViewDefaultProtocol <NSObject,Refreshable>

@optional
- (void)loadDefault;
- (void)viewDeallocate;
@end

@protocol ViewOfControllerProtocol <ViewDefaultProtocol>

@property (nonatomic, weak) UIViewController *controller;

@optional
- (void)viewWillAppear;

@end

@protocol ViewCreateProtocol <ViewDefaultProtocol>

@optional
- (void)createSubView;
- (void)initView;

@end

@protocol TableViewCellProtocol <ViewCreateProtocol>

@end

@protocol CollectionViewProtocol <ViewDefaultProtocol>

@optional
- (void)createView;

@end

@protocol CollectionViewCellProtocol <ViewCreateProtocol>

@end

@protocol TableViewProtocol <ViewCreateProtocol>

@optional
- (void)selectItem:(NSString *)selSection row:(NSString *)selRow;

@required
- (UITableViewCell *)createTableViewCell:(UITableView *)tableView index:(NSIndexPath *)indexPath;
@end


