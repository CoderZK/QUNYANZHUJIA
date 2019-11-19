//
//  QYZJRecommendFootV.m
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRecommendFootV.h"

@interface QYZJRecommendFootV()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *codeBt;
@property(nonatomic,strong)UITextField *codeTF;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger number;
@end

@implementation QYZJRecommendFootV

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        
        self.backgroundColor = RGB(245, 245, 245);
        UIView * whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        UIButton * buttonOne = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 50)];
        [buttonOne setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
        [buttonOne setTitle:@"添加单子" forState:UIControlStateNormal];
        buttonOne.titleLabel.font = kFont(14);
        buttonOne.tag = 101;
        [buttonOne addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [buttonOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonOne setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [buttonOne setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [self addSubview:whiteV];
        whiteV.backgroundColor = WhiteColor;
        [whiteV addSubview:buttonOne];
        
        UIView * whiteTwoV = [[UIView alloc] initWithFrame:CGRectMake(0, 60, ScreenW, 50)];
        
        UILabel * leftLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
        leftLB.font = kFont(15);
        leftLB.textColor = CharacterBlackColor;
        leftLB.text = @"验证码";
        [whiteTwoV addSubview:leftLB];
        
        UITextField * TF = [[UITextField alloc] initWithFrame:CGRectMake(100 , 10, ScreenW - 130  - 100 - 20, 30)];
        TF.textAlignment = NSTextAlignmentLeft;
        TF.placeholder = @"请输入验证码";
        TF.textColor = CharacterBlack112;
        TF.font = kFont(14);
        TF.keyboardType = UIKeyboardTypeNumberPad;
        TF.delegate = self;
        [whiteTwoV addSubview:TF];
        
        
        UIButton * buttonTwo = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 130, 0, 120, 50)];
        [buttonTwo setTitle:@"发送验证码" forState:UIControlStateNormal];
        buttonTwo.titleLabel.font = kFont(14);
        [buttonTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonTwo setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        buttonTwo.tag = 100;
        [buttonTwo addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        self.codeBt = buttonTwo;
        [self addSubview:whiteTwoV];
        whiteTwoV.backgroundColor = WhiteColor;
        [whiteTwoV addSubview:buttonTwo];

        
    }
    return self;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.codeStr = textField.text;
}

- (IBAction)action:(UIButton *)button {
    
    if (button.tag == 100) {
        //发送验证码
        [self sendCode];
    }else if (button.tag == 101) {
        if (self.clickRecommendFootVBlock != nil) {
            self.clickRecommendFootVBlock();
        }
    }
}

- (void)sendCode {
    
    //    if (self.phoneTF.text.length == 0) {
    //        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
    //        return;
    //    }
    //    if (self.phoneTF.text.length != 11) {
    //        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
    //        return;
    //    }
    //    NSMutableDictionary * dataDict = @{@"phone":self.phoneTF.text,@"type":@"1"}.mutableCopy;
    //    dataDict[@"deviceId"] = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    //    [zkRequestTool networkingPOST:[HHYURLDefineTool sendValidCodeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
    //        if ([responseObject[@"code"] intValue]== 0) {
    //            [self timeAction];
    //        }else {
    //            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
    //        }
    //
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //
    //
    //
    //    }];
    
}

- (void)timeAction {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.codeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.codeBt setTitle:[NSString stringWithFormat:@"%lds后重发",_number] forState:UIControlStateNormal];
    }else {
        [self.codeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.codeBt.userInteractionEnabled = YES;
    }
    
    
}



@end
