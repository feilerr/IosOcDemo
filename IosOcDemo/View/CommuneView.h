//
//  CommuneView.h
//  IosOcDemo
//
//  Created by Zhou on 2016/11/8.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseView.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
#import "PlayVideoView.h"

@interface CommuneView : BaseView<AVCaptureFileOutputRecordingDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>{
    CALayer *outputLayer;
}

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureMovieFileOutput *captureOutput;
@property (nonatomic, weak) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) UIButton *recordBtn;
@property (nonatomic, strong) UIImageView *realVideoView;

@end
