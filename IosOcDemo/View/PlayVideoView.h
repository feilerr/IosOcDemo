//
//  PlayVideoView.h
//  IosOcDemo
//
//  Created by Zhou on 2016/11/9.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "BaseView.h"
#import "AVPlayerItem+THVideoPlayerAdditions.h"

#define STATUS_KEYPATH @"status"
#define REFRESH_INTERVAL 0.5f

// Define this constant for the key-value observation context.
static const NSString *PlayerItemStatusContext;

@interface PlayVideoView : BaseView<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) PlayView *playerView;
@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) PlayTransportView *transportView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, weak) AVAsset *asset;

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) id timeObserver;
@property (nonatomic, strong) id itemEndObserver;
@property (nonatomic, assign) BOOL scrubbing;
@property (nonatomic, assign) float lastPlaybackRate;
@property (nonatomic, assign) BOOL autoplayContent;

- (void)togglePlaybackControls:(id)sender;
- (void)playButtonTapped:(id)sender;
- (void)pauseButtonTapped:(id)sender;
- (void)closePlayer:(id)sender;
- (void)scrubbingDidStart:(id)sender;
- (void)scrubbing:(id)sender;
- (void)scrubbingDidEnd:(id)sender;

@end
