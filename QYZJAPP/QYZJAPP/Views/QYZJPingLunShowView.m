//
//  QYZJPingLunShowView.m
//  QYZJAPP
//
//  Created by zk on 2019/12/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJPingLunShowView.h"

@interface QYZJPingLunShowView()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)UITextField *tf;
@end


@implementation QYZJPingLunShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        
        UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0, 50, frame.size.width, frame.size.height - 50);
        [button1 addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];

        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, -50, ScreenW, 50)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        self.whiteV.layer.shadowColor = [UIColor blackColor].CGColor;
        self.whiteV.layer.shadowOpacity = 0.4;
        self.whiteV.layer.shadowOffset = CGSizeMake(0, 5);
        self.whiteV.layer.shadowRadius = 5;
        
        UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 100, 30)];
        tf.layer.borderColor = CharacterBlack112.CGColor;
        tf.layer.borderWidth = 0.8;
        tf.layer.cornerRadius = 3;
        tf.clipsToBounds = YES;
        tf.returnKeyType = UIReturnKeySend;
        tf.delegate = self;
        self.tf = tf;
        [self.whiteV addSubview:tf];
        
        UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 80, 10, 70, 30)];
        button.titleLabel.font = kFont(14);
        button.layer.cornerRadius = 4;
        button.clipsToBounds = YES;
        [button setTitle:@"提交" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
        [self.whiteV addSubview:button];
        [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        

        
    }
    return self;
}

- (void)action{
    if (self.tf.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
    }
    [self.tf endEditing:YES];
    
    if (self.sendPingLunBlock != nil) {
        self.sendPingLunBlock(self.tf.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self action];
    
    return YES;
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.whiteV.mj_y = sstatusHeight;
    }];
    
}

- (void)diss {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.whiteV.mj_y = - 50;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}




@end
