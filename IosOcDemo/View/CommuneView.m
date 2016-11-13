//
//  CommuneView.m
//  IosOcDemo
//
//  Created by Zhou on 2016/11/8.
//  Copyright © 2016年 Zhou. All rights reserved.
//

#import "CommuneView.h"
#import "PlayVideoViewController.h"

#define VIDEO_FILE @"test.mov"

@implementation CommuneView

- (void)loadDefault{
    [super loadDefault];
    [self initVideoDevice];
}

- (void)initVideoDevice{
    NSError *error;
    _captureSession = [[AVCaptureSession alloc]init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    AVCaptureDevice *videoDevice = [self getCameraWithPosition:AVCaptureDevicePositionFront];
    if (videoDevice) {
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        if ([_captureSession canAddInput:deviceInput]) {
            [_captureSession addInput:deviceInput];
            _videoInput = deviceInput;
        }
    }
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    if (audioDevice) {
        AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
        if (audioDeviceInput) {
            [_captureSession addInput:audioDeviceInput];
        }
    }
    
    AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    [stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
    if ([self.captureSession canAddOutput:stillImageOutput]) {
        [self.captureSession addOutput:stillImageOutput];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.previewLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-50);
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        CALayer *rootLayer =  [self layer];
        [rootLayer setMasksToBounds:YES];
        [rootLayer insertSublayer:self.previewLayer atIndex:0];
        
        outputLayer = [CALayer layer];
        outputLayer.frame = CGRectMake(0, 40, 128, 85);
        outputLayer.borderWidth = 4;
        outputLayer.borderColor = HEXCOLOR(0xf6e0c9).CGColor;
        outputLayer.cornerRadius = 4;
        outputLayer.masksToBounds = YES;
        outputLayer.backgroundColor = [UIColor redColor].CGColor;
        outputLayer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
        [rootLayer insertSublayer:outputLayer atIndex:1];
    });
    
    _recordBtn = [[UIButton alloc]init];
    [self addSubview:_recordBtn];
    [_recordBtn addTarget:self action:@selector(recordVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_recordBtn setImage:[UIImage imageNamed:@"record.png"] forState:UIControlStateNormal];
    [_recordBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_right).with.offset(-60);
        make.top.equalTo(self).with.offset(CGRectGetHeight(self.frame)/8);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [_captureSession startRunning];
}

- (void)viewWillAppear{
    //加入视频输出
    [self RVC];
}

#pragma mark 实时视频输出
- (void)RVC{
    if (self.captureOutput) {
        [self.captureSession removeOutput:self.captureOutput];
        self.captureOutput = nil;
    }
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
    if ([self.captureSession canAddOutput:output]) {
        [self.captureSession addOutput:output];
    }else{
        return;
    }
    dispatch_queue_t queue = dispatch_queue_create("rvc", NULL);
    [output setSampleBufferDelegate:self queue:queue];
    
    output.videoSettings =[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]   forKey:(id)kCVPixelBufferPixelFormatTypeKey];
//    output.minFrameDuration = CMTimeMake(1, 15);
    //activeVideoMinFrameDuration
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    dispatch_sync(dispatch_get_main_queue(), ^{
        outputLayer.contents = (id)image.CGImage;
    });
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}

- (void)recordVideo:(id)sender{
    if ([_recordBtn isSelected]) {
        [_recordBtn setSelected:NO];
        [self.captureOutput stopRecording];
         [_recordBtn setImage:[UIImage imageNamed:@"record.png"] forState:UIControlStateNormal];
    } else {
        [_recordBtn setSelected:YES];
        [_recordBtn setImage:[UIImage imageNamed:@"recording.png"] forState:UIControlStateNormal];
        if (!self.captureOutput) {
            self.captureOutput = [[AVCaptureMovieFileOutput alloc] init];
            [self.captureSession addOutput:self.captureOutput];
        }
        // Delete the old movie file if it exists
        [[NSFileManager defaultManager] removeItemAtURL:[self outputURL] error:nil];
//        [self.captureSession startRunning];
        AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:self.captureOutput.connections];
        
        if ([videoConnection isVideoOrientationSupported]) {
            videoConnection.videoOrientation = [self currentVideoOrientation];
        }
        if ([videoConnection isVideoStabilizationSupported]) {
            videoConnection.enablesVideoStabilizationWhenAvailable = YES;
        }
        [self.captureOutput startRecordingToOutputFileURL:[self outputURL] recordingDelegate:self];
    }
    
    // Disable the toggle button if recording
//    self.recordBtn.enabled = ![_recordBtn isSelected];
}

- (AVCaptureVideoOrientation)currentVideoOrientation {
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft) {
        return AVCaptureVideoOrientationLandscapeRight;
    } else {
        return AVCaptureVideoOrientationLandscapeLeft;
    }
}

- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections {
    for (AVCaptureConnection *connection in connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:mediaType]) {
                return connection;
            }
        }
    }
    return nil;
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    if (!error) {
        [self presentRecording];
    } else {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
}

#pragma mark - Show Last Recording
- (void)presentRecording {
    NSString *tracksKey = @"tracks";
    AVAsset *asset = [AVURLAsset assetWithURL:[self outputURL]];
    [asset loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:^{
        NSError *error;
        AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
        if (status == AVKeyValueStatusLoaded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //播放记录视频
                PlayVideoViewController *controller = [[PlayVideoViewController alloc]init];
                controller.asset = asset;
                [self.controller.navigationController pushViewController:controller animated:YES];
            });
        }
    }];
}

#pragma mark - Recoding Destination URL
- (NSURL *)outputURL {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:VIDEO_FILE];
    return [NSURL fileURLWithPath:filePath];
}

//更新前后置摄像头
- (void)refresh{
    NSError *error;
    AVCaptureDevicePosition position = [[self.videoInput device] position];
    
    AVCaptureDeviceInput *videoInput;
    if (position == AVCaptureDevicePositionBack) {
        videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self getCameraWithPosition:AVCaptureDevicePositionFront] error:&error];
        self.previewLayer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f);
    } else {
        videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self getCameraWithPosition:AVCaptureDevicePositionBack] error:&error];
        self.previewLayer.transform = CATransform3DIdentity;
    }
    
    if (videoInput) {
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:self.videoInput];
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.videoInput = videoInput;
        }
        [self.captureSession commitConfiguration];
    }
}

- (AVCaptureDevice *)getCameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}


@end
