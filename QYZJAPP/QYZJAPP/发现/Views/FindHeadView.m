//
//  FindHeadView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "FindHeadView.h"

@interface FindHeadView()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,strong)UIButton *searchBt;
@property(nonatomic,strong)UIView *orangeV;
@end

@implementation FindHeadView

- (UIView *)orangeV {
    if (_orangeV == nil) {
        _orangeV = [[UIView alloc] initWithFrame:CGRectMake(0, 70+35, 40, 2)];
        _orangeV.backgroundColor = OrangeColor;
        [self addSubview:_orangeV];
    }
    return _orangeV;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.rightView = [[UIView alloc] init];
        [self addSubview:self.rightView];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(20);
        }];
        
        self.rightView.backgroundColor = [UIColor whiteColor];
        [self addShadowToView:self.rightView withColor:[UIColor blackColor]];
        
        self.searchBt = [[UIButton alloc] init];
        [self.searchBt setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [self.rightView addSubview:self.searchBt];
        [self.searchBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@30);
            make.centerY.equalTo(self.rightView.mas_centerY);
            make.right.equalTo(self.rightView.mas_right).offset(-10);
            
        }];
        
        [[self.searchBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@{@"key":@"search",@"text":self.TF.text}];
                [self.TF resignFirstResponder];
            }
        }];
        
        self.TF = [[UITextField alloc] init];
        self.TF.font = kFont(14);
        self.TF.placeholder = @"搜索";
        [self.rightView addSubview:self.TF];
        self.TF.returnKeyType = UIReturnKeySend;
        self.TF.delegate = self;
        
        [self.TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(self.rightView.mas_centerY);
            make.left.equalTo(self.rightView.mas_left).offset(20);
            make.right.equalTo(self.searchBt.mas_left).offset(-8);
        }];
        
        
        [self addButtons];
    }
    return self;
}

- (void)addButtons {
    
    NSArray * arr = @[@"广场",@"名家",@"头条",@"旁听"];
    CGFloat space = 20;
    CGFloat width = 40;
    for (int i = 0 ; i<arr.count;i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + (width+space)*i, 70, width, 35);
        
        [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100+i;
        if (i == 0) {
            self.orangeV.centerX = button.centerX;
        }
        [self addSubview:button];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegateSignal && self.isPresentVC) {
        
        [self.delegateSignal sendNext:@{@"key":@"search",@"text":self.TF.text}];
        return NO;
    }
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@{@"key":@"search",@"text":self.TF.text}];
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    if (textField.text.length == 0) {
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:@{@"key":@"search",@"text":self.TF.text}];
        }
    }
}

- (void)clickAction:(UIButton *)button {
    [self.TF resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        self.orangeV.centerX = button.centerX;
    }];
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@{@"key":@"bottom",@"text":@(button.tag - 100)}];
    }
    
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    theView.layer.cornerRadius = 20;
    //    theView.clipsToBounds = YES;
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 3;
    
}


@end
