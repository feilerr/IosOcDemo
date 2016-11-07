//
//  PublishView.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/31.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "PublishView.h"
#import <Masonry/Masonry.h>
#import "CategoryItem.h"
#import "CategorySubItem.h"

@implementation PublishView

- (void)loadDefault{
    [super loadDefault];
    backColor = 0xececec;
    self.backgroundColor = HEXCOLOR(backColor);
    leftTableWidth = 80.f;
    
    [self addLeftView];
    [self addRightView];
}

- (void)refresh{
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:_leftTableCurRow inSection:0];
    [_leftTable selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)addLeftView{
    _leftTable = [[UITableView alloc] init];
    _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTable.showsVerticalScrollIndicator = NO;
    _leftTable.backgroundColor = HEXCOLOR(backColor);
    [_leftTable registerClass:[PublishTableCell class] forCellReuseIdentifier:[PublishTableCell description]];
    [self addSubview:_leftTable];
    [_leftTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(leftTableWidth);
        make.height.equalTo(self);
    }];
    _leftTable.dataSource = self;
    _leftTable.delegate = self;
    _leftTableCurRow = 0;
    
    category = @[@"推荐分类",@"家用电器",@"电脑办公",@"潮流女装",@"家居家纺",@"鞋靴箱包",@"居家生活",@"运动户外",@"手机数码",@"医疗保健",@"食品生鲜",@"奢品礼品",@"个护化妆",@"钟表珠宝",@"玩具乐器",@"母婴童装",@"汽车用品",@"宠物农资",@"品牌男装",@"内衣配饰",@"家具建材",@"图书音像",@"酒水饮料",@"计生情趣",@"京东金融",@"生活旅行"];
}

- (void)addRightView{
    //创建一个layout布局类
    publishLayout = [[PublishFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    publishLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    publishLayout.minimumLineSpacing = 5;
    //设置每个item的大小为100*100
    CGFloat width = (self.frame.size.width-106.)/3.;
    publishLayout.itemSize = CGSizeMake(width, width);
    
    //创建collectionView 通过一个布局策略layout来创建
    _rightView= [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:publishLayout];
    [self addSubview:_rightView];
    _rightView.backgroundColor = HEXCOLOR(backColor);
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(_leftTable.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self);
        make.height.equalTo(self).with.offset(-50);
    }];
    //代理设置
    _rightView.delegate=self;
    _rightView.dataSource=self;
    _rightView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //注册item类型 这里使用系统的类型
    [_rightView registerClass:[PublishCollectionCell class] forCellWithReuseIdentifier:[PublishCollectionCell description]];
    [_rightView registerClass:[PublishHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[PublishHeadReusableView description]];
    publishLayout.sectionWidth = self.frame.size.width-leftTableWidth-20;
    publishLayout.sectionHeight = self.frame.size.width-106.+publishLayout.minimumLineSpacing*2;
    [self loadRightViewData];
}

- (void)loadRightViewData{
    categoryData = [[NSMutableDictionary alloc]init];
    for (int i=0; i<category.count; i++) {
        NSMutableArray *list = [[NSMutableArray alloc]init];
        for (int j=0; j<2; j++) {
            CategoryItem *item = [[CategoryItem alloc]init];
            if (j==0) {
                item.name = @"常用操作";
            }else{
                item.name = @"专业推荐";
            }
            for (int t=0; t<9; t++) {
                CategorySubItem *subitem = [[CategorySubItem alloc]init];
                switch (i) {
                    case 0:
                        subitem.name = @"平板电脑";
                        break;
                    case 1:
                        subitem.name = @"平板电视";
                        break;
                    case 2:
                        subitem.name = @"联想电脑";
                        break;
                    case 3:
                        subitem.name = @"精品女装";
                        break;
                    case 4:
                        subitem.name = @"床上用品";
                        break;
                    case 5:
                        subitem.name = @"皮鞋";
                        break;
                    case 6:
                        subitem.name = @"雨伞雨具";
                        break;
                    case 7:
                        subitem.name = @"跑步鞋";
                        break;
                    case 8:
                        subitem.name = @"苹果手机";
                        break;
                    case 9:
                        subitem.name = @"中西药品";
                        break;
                    default:
                        subitem.name = @"推荐商品";
                        break;
                }
                
                subitem.imageName = [NSString stringWithFormat:@"ad%d%d%d.jpg",i,i,i];
                [item.items addObject:subitem];
            }
            [list addObject:item];
        }
        NSString *cate = [category objectAtIndex:i];
        [categoryData setObject:list forKey:cate];
    }
}

#pragma mark UITableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return category.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[PublishTableCell description]];
    if (cell == nil) {
        cell = [[PublishTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PublishTableCell description]];
    }
    cell.textLabel.text = [category objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    _leftTableCurRow = (int)indexPath.row;
    publishLayout.sectionWidth = self.frame.size.width-leftTableWidth-20;
    publishLayout.sectionHeight = self.frame.size.width-106.+publishLayout.minimumLineSpacing*2;
    [_rightView reloadData];
}

#pragma mark UICollectionView 代理方法
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PublishCollectionCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:[PublishCollectionCell description] forIndexPath:indexPath];
    NSMutableArray *list = [categoryData objectForKey:[category objectAtIndex:_leftTableCurRow]];
    CategoryItem *item = (CategoryItem *)[list objectAtIndex:indexPath.section];
    CategorySubItem *subitem = (CategorySubItem *)[item.items objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:subitem.imageName];
    cell.nameLabel.text = subitem.name;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0,0, 10);
}

//必须调用该方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return CGSizeMake(collectionView.frame.size.width-10, 125);
    }
    return CGSizeMake(collectionView.frame.size.width-10, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PublishHeadReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:[PublishHeadReusableView description] forIndexPath:indexPath];
    if (indexPath.section == 0) {
        headerView.adView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad%d.jpg" ,_leftTableCurRow]];
        headerView.adView.frame = CGRectMake(0, 15, CGRectGetWidth(collectionView.frame)-10, 80);
        headerView.sectionTitle.frame = CGRectMake(0, CGRectGetMaxY(headerView.adView.frame), 120, 30);
    }else{
        headerView.adView.frame = CGRectZero;
       headerView.sectionTitle.frame = CGRectMake(0, 0, 120, 30);
    }
    NSMutableArray *list = [categoryData objectForKey:[category objectAtIndex:_leftTableCurRow]];
    CategoryItem *item = (CategoryItem *)[list objectAtIndex:indexPath.section];
    headerView.sectionTitle.text = item.name;
    return headerView;
}

@end
