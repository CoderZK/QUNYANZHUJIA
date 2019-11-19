//
//  PublicFuntionTool.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "PublicFuntionTool.h"
#import <AVKit/AVKit.h>
static PublicFuntionTool * tool = nil;
@interface PublicFuntionTool()<AVAudioPlayerDelegate>
@property(nonatomic,strong)AVAudioPlayer *player;

@end

@implementation PublicFuntionTool

+ (PublicFuntionTool *)shareTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[PublicFuntionTool alloc] init];
    });
    return tool;
}

#pragma mark ---- 获取图片第一帧
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}

+ (void)presentVideoVCWithNSString:(NSString *)videoStr isBenDiPath:(BOOL)isBenDi{
    
    //网络视频路径
    NSString *webVideoPath = videoStr;
    NSURL * webVideoUrl = nil;
    if (isBenDi) {
        webVideoUrl = [NSURL fileURLWithPath:webVideoPath];
    }else {
        webVideoUrl = [NSURL URLWithString:webVideoPath];
    }
    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
    //步骤3：使用AVPlayer创建AVPlayerViewController，并跳转播放界面
    AVPlayerViewController *avPlayerVC =[[AVPlayerViewController alloc] init];
    avPlayerVC.player = avPlayer;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:avPlayerVC animated:YES completion:nil];
    
}


- (void)palyMp3WithNSSting:(NSString *)meidaStr isLocality:(BOOL )isLocality {
    if (isLocality) {

    }else {
       
        NSURL * url = [[NSURL alloc] initWithString:meidaStr];
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
        self.player.numberOfLoops = 0;
        self.player.volume =0.8;
        [self.player play];
        self.player.delegate = self;

    }
    
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag

{

    //播放结束时执行的动作
    if (self.findPlayBlock != nil) {
        self.findPlayBlock();
    }

}



 

 

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;

{

    //解码错误执行的动作

}


 

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player;

{

    //处理中断的代码

}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player

{

    [player play];

}



- (UIView *) createFootvWithTitle:(NSString *)title andImgaeName:(NSString *)imgName{

    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 60, ScreenW, 60)];
    if (sstatusHeight > 20) {
        footV.frame = CGRectMake(0, ScreenH - sstatusHeight - 44 - 60 - 34, ScreenW, 60);
    }
    footV.backgroundColor = WhiteColor;
    footV.layer.shadowColor = [UIColor blackColor].CGColor;
      // 设置阴影偏移量
      footV.layer.shadowOffset = CGSizeMake(0,-3);
      // 设置阴影透明度
      footV.layer.shadowOpacity = 0.1;
      // 设置阴影半径
      footV.layer.shadowRadius = 5;
      footV.clipsToBounds = NO;
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 10, ScreenW - 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    if (imgName.length > 0) {
         [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.clipsToBounds = YES;
    [footV addSubview:button];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

    return footV;
}

- (void)clickAction:(UIButton *)button {
    
    if (self.finshClickBlock != nil) {
        self.finshClickBlock(button);
    }
    
}

//转化图片和视频
+ (void)getImageFromPHAsset:(PHAsset *)asset Complete:(void(^)(NSData * data,NSString * str))result {
    __block NSData *data;
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                          options:options
                                                    resultHandler:
         ^(NSData *imageData,
           NSString *dataUTI,
           UIImageOrientation orientation,
           NSDictionary *info) {
             data = [NSData dataWithData:imageData];
         }];
    }
    
    if (result) {
        if (data.length <= 0) {
            result(nil, nil);
        } else {
            result(data, resource.originalFilename);
        }
    }
}

@end
