//
//  LaJi.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "LaJi.h"

@implementation LaJi

   //网络视频路径
//   NSString *webVideoPath = @"http:\/\/tb-video.bdstatic.com\/tieba-smallvideo-transcode\/20985849_722f981a5ce0fc6d2a5a4f40cb0327a5_3.mp4";
//   NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
      //NSURL *webVideoUrl = [NSURL fileURLWithPath:webVideoPath];
//  AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
//  //步骤3：使用AVPlayer创建AVPlayerViewController，并跳转播放界面
//  AVPlayerViewController *avPlayerVC =[[AVPlayerViewController alloc] init];
//  avPlayerVC.player = avPlayer;
//  [self presentViewController:avPlayerVC animated:YES completion:nil];

//    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
//    //步骤3：使用AVPlayer创建AVPlayerViewController，并跳转播放界面
//    AVPlayerViewController *avPlayerVC =[[AVPlayerViewController alloc] init];
//    avPlayerVC.player = avPlayer;
//
//    //步骤4：设置播放器视图大小
//    avPlayerVC.view.frame = CGRectMake(25, 0, 320, 300);
//    //特别注意:AVPlayerViewController不能作为局部变量被释放，否则无法播放成功
//    //解决1.AVPlayerViewController作为属性
//    //解决2:使用addChildViewController，AVPlayerViewController作为子视图控制器
////    [self addChildViewController:avPlayerVC];
////    [self.view addSubview:avPlayerVC.view];

//
//
//      NSString *webVideoPath1 = @"http:\/\/tb-video.bdstatic.com\/tieba-video\/7_517c8948b166655ad5cfb563cc7fbd8e.mp4";
//       NSURL *webVideoUrl1 = [NSURL URLWithString:webVideoPath1];
//    //  AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
//    //  //步骤3：使用AVPlayer创建AVPlayerViewController，并跳转播放界面
//    //  AVPlayerViewController *avPlayerVC =[[AVPlayerViewController alloc] init];
//    //  avPlayerVC.player = avPlayer;
//    //  [self presentViewController:avPlayerVC animated:YES completion:nil];
//
//        AVPlayer *avPlayer1 = [[AVPlayer alloc] initWithURL:webVideoUrl1];
//        //步骤3：使用AVPlayer创建AVPlayerViewController，并跳转播放界面
//        AVPlayerViewController *avPlayerVC1 =[[AVPlayerViewController alloc] init];
//        avPlayerVC1.player = avPlayer1;
//        //步骤4：设置播放器视图大小
//        avPlayerVC1.view.frame = CGRectMake(25, 350, 320, 300);
//        //特别注意:AVPlayerViewController不能作为局部变量被释放，否则无法播放成功
//        //解决1.AVPlayerViewController作为属性
//        //解决2:使用addChildViewController，AVPlayerViewController作为子视图控制器
//        [self addChildViewController:avPlayerVC1];
//        [self.view addSubview:avPlayerVC1.view];



// UITextField * TF = [[UITextField alloc] init];
//    TF.frame = CGRectMake(100, 100, 100, 40);
//    TF.backgroundColor = [UIColor redColor];
//    [self.view addSubview:TF];
//    [[[TF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
//
//        if (value.length > 8 && value.length <16 && [NSString checkStingContainLetterAndNumberWithString:value]) {
//            return YES;
//        }else {
//            self.passwordStr = nil;
//            return NO;
//
//        }
//
//    }] subscribeNext:^(NSString * _Nullable x) {
//        self.passwordStr = x;
//        NSLog(@"----\n%@",x);
//
//
//    }];
//
//    UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//    button.backgroundColor =[UIColor redColor];
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//        if (self.passwordStr == nil){
//            [SVProgressHUD show];
//        }else {
//           [SVProgressHUD showWithStatus:@"123456"];
//        }
//
//    }];
//
//    UIButton * button1 =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//      button1.backgroundColor =[UIColor greenColor];
//      [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//
//
//      }];
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];

@end
