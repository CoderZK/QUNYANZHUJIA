//
//  QYZJLuYinView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJLuYinView.h"
#define kRecordAudioFile @"myRecord.caf"
static QYZJLuYinView * tool = nil;
@interface QYZJLuYinView()<AVAudioRecorderDelegate>
@property(nonatomic,strong)UIButton *Bt;
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property(nonatomic,strong)NSData *audioData;
@end


@implementation QYZJLuYinView

+ (QYZJLuYinView *)LuYinTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[QYZJLuYinView alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44, ScreenW, ScreenH)];
    });
    return tool;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        
        UIButton * bb = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:bb];
        [bb addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.Bt = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 100)/2, (ScreenH - 100)/2-30, 100, 100)];
        self.Bt.backgroundColor = WhiteColor;
        [self.Bt setTitle:@"按住说话" forState:UIControlStateNormal];
        self.Bt.layer.shadowColor = WhiteColor.CGColor;
        self.Bt.layer.shadowOffset = CGSizeMake(0, 0);
        self.Bt.layer.shadowOpacity = 0.4;
        // 阴影半径，默认3
        self.Bt.layer.shadowRadius = 15;
        self.Bt.layer.cornerRadius = 50;
        [self.Bt setTitleColor:CharacterColor80 forState:UIControlStateNormal];
        self.Bt.titleLabel.font = kFont(14);
        [self addSubview:self.Bt];
        
        //        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longClick:)];
        //
        //        longPress.minimumPressDuration=0.2;
        //
        //        [self.Bt addGestureRecognizer:longPress];
        
        [self.Bt addTarget:self action:@selector(BtnAction:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
        
        
    }
    return self;
}

- (void)BtnAction:(id)sender forEvent:(UIEvent *)event{
    
    UITouchPhase phase =event.allTouches.anyObject.phase;
    if (phase == UITouchPhaseBegan) {
        NSLog(@"\n----%@",@"开始");
        if (![self.audioRecorder isRecording]) {
            [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
            if (self.statusBlock != nil) {
                self.statusBlock(YES,[NSData data]);
            }
        }
    }
    else if(phase == UITouchPhaseEnded){
        NSLog(@"\n----%@",@"结束");
        [self.audioRecorder stop];
        
    }
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }];
    
}

- (void)diss {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



#pragma mark - 私有方法
/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
//-(AVAudioPlayer *)audioPlayer{
//    if (!_audioPlayer) {
//        NSURL *url=[self getSavePath];
//        NSError *error=nil;
//        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//        _audioPlayer.numberOfLoops=0;
//        [_audioPlayer prepareToPlay];
//        if (error) {
//            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
//            return nil;
//        }
//    }
//    return _audioPlayer;
//}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
//-(NSTimer *)timer{
//    if (!_timer) {
//        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
//    }
//    return _timer;
//}

/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    //    [self.audioRecorder updateMeters];//更新测量值
    //    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    //    CGFloat progress=(1.0/160.0)*(power+160.0);
    //  [self.audioPower setProgress:progress];
    
    //    self.timeNumber = self.timeNumber + 0.1;
    //
    //    self.timeLB.text  =  [NSString stringWithFormat:@"%0.2f",self.timeNumber];
    
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];//
    [recordSetting setValue:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];//采样率
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];//声音通道，这里必须为双通道
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];//音频质量
    
    NSString *cafFilePath = recorder.url.path;    //caf文件路径
    NSLog(@"\n录音文件位置%@",cafFilePath);
    
    self.audioData = [NSData dataWithContentsOfFile:cafFilePath];
    
    if (self.statusBlock != nil) {
        self.statusBlock(NO,self.audioData);
    }
    
//        NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        urlStr=[urlStr stringByAppendingPathComponent:@"111.mp3"];
//        NSString *mp3FilePath = urlStr;//存储mp3文件的路径
    
    //    @try {
    //        int read, write;
    //
    //        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
    //        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
    //        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
    //
    //        const int PCM_SIZE = 8192;
    //        const int MP3_SIZE = 8192;
    //        short int pcm_buffer[PCM_SIZE*2];
    //        unsigned char mp3_buffer[MP3_SIZE];
    //
    //        lame_t lame = lame_init();
    //        lame_set_in_samplerate(lame, 11025.0);
    //        lame_set_VBR(lame, vbr_default);
    //        lame_init_params(lame);
    //
    //        do {
    //            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
    //            if (read == 0)
    //                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
    //            else
    //                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
    //
    //            fwrite(mp3_buffer, write, 1, mp3);
    //
    //        } while (read != 0);
    //
    //        lame_close(lame);
    //        fclose(mp3);
    //        fclose(pcm);
    //    }
    //    @catch (NSException *exception) {
    //        NSLog(@"%@",[exception description]);
    //    }
    //    @finally {
    //        NSLog(@"MP3生成成功: %@",mp3FilePath);
    //
    //        NSData *data =[NSData dataWithContentsOfFile:mp3FilePath];
    //        NSLog(@"%ld",data.length);
    //
    //    }
    
    
    
    NSLog(@"录音完成!");
}




@end
