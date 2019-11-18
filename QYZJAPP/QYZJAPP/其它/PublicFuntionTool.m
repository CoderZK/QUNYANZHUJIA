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


@end
