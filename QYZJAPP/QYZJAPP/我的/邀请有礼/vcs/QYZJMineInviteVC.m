//
//  QYZJMineInviteVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineInviteVC.h"
#import "QYZJMineYaoQingTVC.h"
#import <CoreImage/CoreImage.h>
#import "CIImage+Extension.h"
@interface QYZJMineInviteVC ()
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet UILabel *codeLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation QYZJMineInviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"邀请有礼";
    self.leftBt.layer.cornerRadius = self.rightBt.layer.cornerRadius = 3;
    self.leftBt.clipsToBounds = self.rightBt.clipsToBounds = YES;
    
    NSString * string = [NSString stringWithFormat:@"http://mobile.qunyanzhujia.com/register?code=%@&readonly=1",self.invitation_code];;
    self.codeLB.text = self.invitation_code;
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
   [filter setDefaults];
    
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    // 使用KVC的方式给filter赋值

    [filter setValue:data forKeyPath:@"inputMessage"];

    // 3. 生成二维码

    CIImage *image = [filter outputImage];
    UIImage * img = [UIImage creatNonInterpolatedUIImageFormCIImage:image withSize:150];
    self.imgV.image = img;
    
    self.imgV.userInteractionEnabled = YES;
   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
   tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
   [self.imgV addGestureRecognizer:tap];
}

//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    [[zkPhotoShowVC alloc] initWithArray:@[self.imgV.image] index:0];
}


- (IBAction)action:(UIButton *)sender {
    if(sender.tag == 100) {
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.invitation_code];
        [SVProgressHUD showSuccessWithStatus:@"复制成功"];
        
    }else if (sender.tag == 101) {
        QYZJMineYaoQingTVC * vc =[[QYZJMineYaoQingTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)] withUrl:[NSString stringWithFormat:@"http://mobile.qunyanzhujia.com/invite?code=%@",self.invitation_code] shareModel:nil withContentStr:@"欢饮注册使用群燕筑家" andTitle:@""];
    }
    
}



@end
