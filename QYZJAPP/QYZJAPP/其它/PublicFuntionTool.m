//
//  PublicFuntionTool.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "PublicFuntionTool.h"
#import <AVKit/AVKit.h>
@implementation PublicFuntionTool
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

@end
