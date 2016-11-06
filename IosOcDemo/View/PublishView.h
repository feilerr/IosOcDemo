//
//  PublishView.h
//  IosOcDemo
//
//  Created by Zhou on 2016/10/31.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface PublishView : BaseView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    CGFloat leftTableWidth;
    NSArray *category;
    NSMutableDictionary *categoryData;
    NSInteger backColor;
    PublishFlowLayout * publishLayout ;
}

@property (nonatomic, strong) UITableView *leftTable;
@property (nonatomic, strong) UICollectionView * rightView;
@property (nonatomic, assign) int leftTableCurRow;

@end
