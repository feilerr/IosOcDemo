//
//  ViewComponent.m
//  IosOcDemo
//
//  Created by Zhou on 2016/10/30.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "ViewComponent.h"

#pragma mark 自定义TabBar
@implementation QLTabBarItem

- (void)loadDefault{
    _showMark = false;
}

- (void)saveImage{
    saveSelectedImage = self.selectedImage;
    saveImage = self.image;
}

- (void)refresh:(NSString *)str{
    countStr = str;
    if (_showMark) {
        self.selectedImage = [self drawMark:self.selectedImage mark:str];
        self.image = [self drawMark:self.image mark:str];
    }else{
        self.selectedImage = [self drawImage:saveSelectedImage];
        self.image = [self drawImage:saveImage];
    }
    
    [self setImage:[self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self setSelectedImage:[self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (UIImage *)drawMark:(UIImage *)image mark:(NSString *)str{
    CGSize sz = [image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height), NO, 0);
    [image drawInRect:CGRectMake(9,7,26,26)];
    QLImage *circle = [[QLImage alloc]init];
    circle.message = str;
    CGFloat circleRadius = 6.;
    [circle drawInRect:CGRectMake(33, 7, circleRadius, circleRadius)];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

- (UIImage *)drawImage:(UIImage *)image{
    CGSize sz = [image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height), NO, 0);
    [image drawInRect:CGRectMake(9,7,26,26)];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}


@end

#pragma mark 修改Image
@implementation QLImage

- (void)drawInRect:(CGRect)rect{
    [super drawInRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextFillPath(ctx);
    if (self.message.length>0) {
        if (self.message.length == 1) {
            [self drawLabel:ctx frame:CGRectMake(16, 1, rect.size.width, rect.size.height) txt:self.message];
        }else{
            [self drawLabel:ctx frame:CGRectMake(15, 1, rect.size.width, rect.size.height) txt:self.message];
        }
    }
}

- (void)drawLabel:(CGContextRef)ctx frame:(CGRect)rect txt:(NSString *)title{
    NSAttributedString *attriString = [self getAttributedString:title];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    if (frame) {
        CGContextSaveGState(ctx);
        CGContextTranslateCTM(ctx, 0, rect.origin.y);
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -(rect.origin.y + rect.size.height));
        CTFrameDraw(frame, ctx);
        CGContextRestoreGState(ctx);
        CFRelease(frame);
    }
    CFRelease(path);
    CFRelease(framesetter);
}

-(NSMutableAttributedString *)getAttributedString:(NSString *)title{
    NSString *str=title;
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    [attriString addAttribute:(id)kCTParagraphStyleAttributeName value:(id)paragrapStyle range:NSMakeRange(0, str.length)];
    CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica"), 8., NULL);
    [attriString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1.0 green:1.0 blue:1. alpha:1.0]} range:NSMakeRange(0, str.length)];
    
    [attriString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, str.length)];
    return attriString;
}

@end

#pragma mark PublishTableCell
@implementation PublishTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:12.];
        self.backgroundColor = HEXCOLOR(0xFFFFFF);
        PublishTableCellBackView *backView = [[PublishTableCellBackView alloc]initWithFrame:self.frame];
        backView.backgroundColor = HEXCOLOR(0xececec);
        self.selectedBackgroundView = backView;
        self.textLabel.highlightedTextColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx,0., 0., 0.,1.0);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextBeginPath(ctx);
    CGContextSetLineWidth(ctx, 0.1);
    CGContextMoveToPoint(ctx, 0, self.frame.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width-0.1, self.frame.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width-0.1, 0);
     CGContextStrokePath(ctx);
}

@end

@implementation PublishTableCellBackView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx,0.5, 0.5, 0.5,1.);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextBeginPath(ctx);
    CGContextSetLineWidth(ctx, 0.1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}

@end

#pragma mark 自定义CollectionView
@implementation PublishCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, frame.size.width-40, frame.size.height-40)];
        [self addSubview:_imageView];
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), frame.size.width, 20)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textColor = HEXCOLOR(0x303030);
        _nameLabel.font = [UIFont systemFontOfSize:12.];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
    }
    return self;
}

@end

@implementation PublishLayoutAttributes


@end

@implementation PublishHeadReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _adView = [[UIImageView alloc]init];
        [self addSubview:_adView];
        self.sectionTitle = [[UILabel alloc]init];
        [self addSubview:self.sectionTitle];
        self.sectionTitle.font = [UIFont boldSystemFontOfSize:12.];
        self.sectionTitle.textColor = HEXCOLOR(0x101010);
        self.sectionTitle.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    
}

@end

@implementation PublishDecorationReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

@implementation PublishFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0.;
    [self registerClass:[PublishDecorationReusableView class] forDecorationViewOfKind:[PublishDecorationReusableView description]];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [NSMutableArray array];
    for (int y=0; y<2; y++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:2 inSection:y];
        [attributes addObject:[self layoutAttributesForDecorationViewOfKind:[PublishDecorationReusableView description] atIndexPath:indexPath]];
    }
    for (int y=0; y<2; y++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:2 inSection:y];
        [attributes addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath]];
    }
    for (NSInteger i=0 ; i < 2; i++) {
        for (NSInteger t=0; t<9; t++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:t inSection:i];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    return attributes;
}

#pragma mark collectView Head布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes* att = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    if (indexPath.section == 0) {
        att.frame=CGRectMake(0, self.sectionHeight*indexPath.section,self.sectionWidth , 125);
    }else{
        att.frame=CGRectMake(0, 125+self.sectionHeight*indexPath.section, self.sectionWidth, 30);
    }
    return att;
}

#pragma mark collectView Decoration布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes* att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    if (indexPath.section == 0) {
        att.frame=CGRectMake(0, 125,self.sectionWidth , self.sectionHeight);
    }else{
        att.frame=CGRectMake(0, 125+self.sectionHeight*indexPath.section+30, self.sectionWidth, self.sectionHeight);
    }
    att.zIndex=-1;
    return att;
}

@end

#pragma mark 播放组件
@implementation PlayView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end

@implementation PlayTransportView

- (void)loadDefault{
    UIImageView *backview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backview.image = [UIImage imageNamed:@"tp_transport_base"];
    backview.userInteractionEnabled = YES;
    [self addSubview:backview];
    
    _playButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 19, 21)];
    [_playButton setImage:[UIImage imageNamed:@"tp_play_button"] forState:UIControlStateNormal];
    [backview addSubview:_playButton];
    
    _pauseButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 19, 21)];
    [_pauseButton setImage:[UIImage imageNamed:@"tp_pause_button"] forState:UIControlStateNormal];
    [backview addSubview:_pauseButton];
    _pauseButton.hidden = YES;
    
    _currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_playButton.frame), CGRectGetMinY(_playButton.frame), 60, CGRectGetHeight(_playButton.frame) )];
    [backview addSubview:_currentTimeLabel];
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.font = [UIFont boldSystemFontOfSize:12.];
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    _scrubberSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_currentTimeLabel.frame), CGRectGetMinY(_playButton.frame), 160, CGRectGetHeight(_playButton.frame))];
    [backview addSubview:_scrubberSlider];
    
    _remainingTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_scrubberSlider.frame), CGRectGetMinY(_playButton.frame), 60, CGRectGetHeight(_playButton.frame) )];
    [backview addSubview:_remainingTimeLabel];
    _remainingTimeLabel.textColor = [UIColor whiteColor];
    _remainingTimeLabel.font = [UIFont boldSystemFontOfSize:12.];
    _remainingTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.scrubberSlider.value = 0.0f;
    
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 10.0f;
    self.layer.shadowColor = [UIColor colorWithWhite:0.200 alpha:1.000].CGColor;
    
    UIEdgeInsets trackImageInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    
    UIImage *thumbNormalImage = [UIImage imageNamed:@"tp_scrubber_knob"];
    UIImage *thumbHighlightedImage = [UIImage imageNamed:@"tp_scrubber_knob_highlighted"];
    UIImage *maxTrackImage = [[UIImage imageNamed:@"tp_track_flex"] resizableImageWithCapInsets:trackImageInsets];
    UIImage *minTrackImage = [[UIImage imageNamed:@"tp_track_highlight_flex"] resizableImageWithCapInsets:trackImageInsets];
    
    // Customize slider appearance
    [self.scrubberSlider setMaximumTrackImage:maxTrackImage forState:UIControlStateNormal];
    [self.scrubberSlider setMinimumTrackImage:minTrackImage forState:UIControlStateNormal];
    [self.scrubberSlider setThumbImage:thumbNormalImage forState:UIControlStateNormal];
    [self.scrubberSlider setThumbImage:thumbHighlightedImage forState:UIControlStateHighlighted];
    
    self.infoView.hidden = YES;
    
    [self.infoView sizeToFit];
    self.infoViewOffset = CGRectGetWidth(self.infoView.frame) / 2;
    CGRect trackRect = [self.scrubberSlider trackRectForBounds:self.scrubberSlider.bounds];
    self.sliderOffset = self.scrubberSlider.frame.origin.x + trackRect.origin.x + 10;
    
    // Set up actions
    [self.scrubberSlider addTarget:self action:@selector(showPopupUI) forControlEvents:UIControlEventValueChanged];
    [self.scrubberSlider addTarget:self action:@selector(hidePopupUI) forControlEvents:UIControlEventTouchUpInside];
    [self.scrubberSlider addTarget:self action:@selector(unhidePopupUI) forControlEvents:UIControlEventTouchDown];
}

- (void)showPopupUI {
    self.infoView.hidden = NO;
    CGRect trackRect = [self.scrubberSlider trackRectForBounds:self.scrubberSlider.bounds];
    CGRect thumbRect = [self.scrubberSlider thumbRectForBounds:self.scrubberSlider.bounds trackRect:trackRect value:self.scrubberSlider.value];
    
    CGRect rect = self.infoView.frame;
    // The +1 is a fudge factor due to the scrubber knob being larger than normal
    rect.origin.x = (self.sliderOffset + thumbRect.origin.x + 1) - self.infoViewOffset;
    self.infoView.frame = rect;
}

- (void)unhidePopupUI {
    self.infoView.hidden = NO;
    self.infoView.alpha = 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        self.infoView.alpha = 1.0f;
    }                completion:^(BOOL complete) {
    }];
}

- (void)hidePopupUI {
    [UIView animateWithDuration:0.3f animations:^{
        self.infoView.alpha = 0.0f;
    }                completion:^(BOOL complete) {
        self.infoView.alpha = 1.0f;
        self.infoView.hidden = YES;
    }];
}

@end
