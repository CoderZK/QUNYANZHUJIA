//
//  QYZJBindPhoneVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJBindPhoneVC.h"

@interface QYZJBindPhoneVC ()
@property (weak, nonatomic) IBOutlet UILabel *yesOrNoLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hCons;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIView *lineV;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;
@property (weak, nonatomic) IBOutlet UITextField *inviteCeodeTF;
@property (weak, nonatomic) IBOutlet UIButton *swicthBt;
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@property (weak, nonatomic) IBOutlet UISwitch *switchOn;

@end

@implementation QYZJBindPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lineV.hidden =  self.imgV1.hidden = self.inviteCeodeTF.hidden = YES;
    self.hCons.constant = 200;
    self.myCons.constant = 20;
    self.swicthBt.selected = self.switchOn.on =YES;
    
    self.navigationItem.title = @"绑定手机";
    
    
}
- (IBAction)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        //发送验证码
        [self sendCode];
    }else if (button.tag == 101) {
        [self registerAction];
    }else if (button.tag == 102) {
        button.selected = !button.selected;
        if (button.selected) {
            
            self.lineV.hidden = self.imgV1.hidden = self.inviteCeodeTF.hidden = YES;
            self.hCons.constant = 200;
            self.myCons.constant = 20;
            self.yesOrNoLB.text = @"是";
            
           
        }else {
            
            self.lineV.hidden = self.imgV1.hidden = self.inviteCeodeTF.hidden = NO;
            self.hCons.constant = 250;
            self.myCons.constant = 70;
            self.yesOrNoLB.text = @"否";
            
        }
        self.switchOn.on = button.selected;
    }
    
}

- (void)sendCode {
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
   
    NSMutableDictionary * dataDict = @{@"phone":self.phoneTF.text,@"type":@"0"}.mutableCopy;
    if (self.switchOn.on) {
       dataDict[@"type"] = @"1";
    }
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_sendmobileURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            [self timeAction];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


- (void)timeAction {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.codeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.codeBt setTitle:[NSString stringWithFormat:@"%lds后重发",(long)_number] forState:UIControlStateNormal];
    }else {
        [self.codeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.codeBt.userInteractionEnabled = YES;
    }
    
    
}

- (void)registerAction{
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (self.passWordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"mobile"] = self.phoneTF.text;
    dataDict[@"code"] = self.inviteCeodeTF.text;
    dataDict[@"mobile_verify"] = self.codeTF.text;
    dataDict[@"password"] = [self.passWordTF.text base64EncodedString];
    dataDict[@"user_id"] = self.ID;
    if (self.switchOn.on == YES) {
        dataDict[@"is_existence"] = @"0";
    }else {
       dataDict[@"is_existence"] = @"1";
    }
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_appBindPhoneURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功成功"];
            
           QYZJUserModel * userModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
            [zkSignleTool shareTool].session_token = userModel.token;
            [zkSignleTool shareTool].session_uid = userModel.ID;
            [zkSignleTool shareTool].nick_name = userModel.nick_name;;
            [zkSignleTool shareTool].telphone = userModel.telphone;
            [zkSignleTool shareTool].isLogin = YES;
            [zkSignleTool shareTool].isBindWebChat = YES;
            if (self.dissBlock != nil) {
                self.dissBlock(YES);
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
