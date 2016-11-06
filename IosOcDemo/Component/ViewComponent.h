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

@interface PublishTableCell : UITableViewCell

@end

@interface PublishTableCellBackView : UIView

@end

#pragma mark UICollectionView相关类
@interface PublishCollectionCell:UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@interface PublishLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, copy) UIColor *backgroundColor;
@end

@interface PublishHeadReusableView : UICollectionReusableView
@property (nonatomic, strong) UIImageView *adView;
@property (nonatomic, strong) UILabel *sectionTitle;
@end

@interface PublishDecorationReusableView : UICollectionReusableView

@end

@interface PublishFlowLayout : UICollectionViewFlowLayout{

}

@property (nonatomic, assign) CGFloat sectionWidth;
@property (nonatomic, assign) CGFloat sectionHeight;


@end
