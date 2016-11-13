//
//  PlayVideoView.m
//  IosOcDemo
//
//  Created by Zhou on 2016/11/9.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "PlayVideoView.h"
#import "PlayVideoViewController.h"

@implementation PlayVideoView

- (void)loadDefault{
    [super loadDefault];
    
    self.asset = ((PlayVideoViewController *)self.controller).asset;
    self.playerView = [[PlayView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.width)];
    self.playerView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
    [self addSubview:_playerView];
    self.playerView.center = CGPointMake(self.frame.size.width/2., self.frame.size.height/2.-60);
    
    self.overlayView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:self.overlayView];
    self.transportView = [[PlayTransportView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-200, self.frame.size.width, 60)];
    [self.overlayView addSubview:_transportView];
    [self.transportView loadDefault];
    
    self.autoplayContent = YES;
    self.transportView.playButton.hidden = YES;
    self.navigationBar.topItem.title = self.controller.title;
    [self prepareToPlay];
    [self.transportView.playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.transportView.pauseButton addTarget:self action:@selector(pauseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(togglePlaybackControls:)];
    [self.overlayView addGestureRecognizer:_tap];
    
    [self.transportView.scrubberSlider addTarget:self action:@selector(scrubbingDidStart:) forControlEvents:UIControlEventTouchDown];
    [self.transportView.scrubberSlider addTarget:self action:@selector(scrubbing:) forControlEvents:UIControlEventTouchDragInside];
    [self.transportView.scrubberSlider addTarget:self action:@selector(scrubbingDidEnd:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDeallocate {
    if (self.itemEndObserver) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.itemEndObserver
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:self.player.currentItem];
        self.itemEndObserver = nil;
    }
}

#pragma mark - Prepare AVPlayerItem for playback

- (void)prepareToPlay {
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    
    [self.playerItem addObserver:self forKeyPath:STATUS_KEYPATH options:0 context:&PlayerItemStatusContext];
    
    [self addItemEndObserverForPlayerItem:self.playerItem];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = self.player;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &PlayerItemStatusContext) {
        if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [self.playerItem removeObserver:self forKeyPath:STATUS_KEYPATH context:&PlayerItemStatusContext];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self addPlayerItemTimeObserver];
                
                if (self.autoplayContent) {
                    [self.player play];
                    self.transportView.pauseButton.hidden = NO;
                    self.transportView.playButton.hidden = YES;
                } else {
                    [self pauseButtonTapped:nil];
                }
            });
        }
    }
}

- (void)addPlayerItemTimeObserver {
    __weak id weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(REFRESH_INTERVAL, NSEC_PER_SEC)
                                                                  queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
                                                                      // Update UI state
                                                                      [weakSelf syncScrubberView];
                                                                  }];
}

- (void)addItemEndObserverForPlayerItem:(AVPlayerItem *)playerItem {
    __weak id weakSelf = self;
    self.itemEndObserver = [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification
                                                                             object:playerItem
                                                                              queue:[NSOperationQueue mainQueue]
                                                                         usingBlock:^(NSNotification *notification) {
                                                                             // The the transport button state appropriately
                                                                             // and set player to time zero.
                                                                             [weakSelf pauseButtonTapped:nil];
                                                                             [[weakSelf player] seekToTime:kCMTimeZero];
                                                                         }];
}

- (void)syncScrubberView {
    if ([self.playerItem hasValidDuration]) {
        
        double currentTime = CMTimeGetSeconds([self.player currentTime]);
        double duration = CMTimeGetSeconds(self.playerItem.duration);
        
        self.transportView.scrubberSlider.minimumValue = 0;
        self.transportView.scrubberSlider.maximumValue = duration;
        
        if (!self.scrubbing) {
            self.transportView.scrubberSlider.value = currentTime;
        }
        
        [self updateScrubberLabelsWithDuration:duration andCurrentTime:currentTime];
    } else {
        self.transportView.currentTimeLabel.text = @"-- : --";
    }
}

- (void)updateScrubberLabelsWithDuration:(double)duration andCurrentTime:(double)currentTime {
    NSInteger currentSeconds = ceilf(currentTime);
    double remainingTime = duration - currentTime;
    self.transportView.currentTimeLabel.text = [self formatSeconds:currentSeconds];
    self.transportView.scrubbingTimeLabel.text = [self formatSeconds:currentSeconds];
    self.transportView.remainingTimeLabel.text = [self formatSeconds:remainingTime];
}

- (NSString *)formatSeconds:(NSInteger)value {
    NSInteger seconds = value % 60;
    NSInteger minutes = value / 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

- (void)scrubbingDidStart:(id)sender {
    self.transportView.currentTimeLabel.text = @"-- : --";
    self.transportView.remainingTimeLabel.text = @"-- : --";
    self.lastPlaybackRate = self.player.rate;
    self.scrubbing = YES;
    [self.player pause];
    if (self.timeObserver ) {
        [self.player removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
}

- (void)scrubbing:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [self.player seekToTime:CMTimeMakeWithSeconds([slider value], NSEC_PER_SEC)];
    NSInteger currentSeconds = ceilf([slider value]);
    self.transportView.scrubbingTimeLabel.text = [self formatSeconds:currentSeconds];
}

- (void)scrubbingDidEnd:(id)sender {
    self.scrubbing = NO;
    [self addPlayerItemTimeObserver];
    if (self.lastPlaybackRate > 0.0f) {
        [self.player play];
    }
}

- (void)closePlayer:(id)sender {
    [self.player setRate:0.0f];
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)playButtonTapped:(id)sender {
    [self.player play];
    self.transportView.playButton.hidden = YES;
    self.transportView.pauseButton.hidden = NO;
}

- (void)pauseButtonTapped:(id)sender {
    [self.player pause];
    self.transportView.playButton.hidden = NO;
    self.transportView.pauseButton.hidden = YES;
}

#pragma mark - Gesture Handling
- (void)togglePlaybackControls:(id)sender {
    CGFloat newAlpha = self.overlayView.alpha == 1.0 ? 0.0f : 1.0f;
    [UIView animateWithDuration:0.3 animations:^{
        self.overlayView.alpha = newAlpha;
        if (newAlpha == 0) {
            [self.overlayView removeGestureRecognizer:_tap];
            [self.playerView addGestureRecognizer:_tap];
        }else{
            [self.playerView removeGestureRecognizer:_tap];
            [self.overlayView addGestureRecognizer:_tap];
        }
    }];
}

@end
