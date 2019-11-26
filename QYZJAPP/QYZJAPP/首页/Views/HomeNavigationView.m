//
//  HomeNavigationView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HomeNavigationView.h"

@interface HomeNavigationView()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titlLB;
@property(nonatomic,strong)UIButton *buttonLeft;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,strong)UIButton *searchBt;
@end


@implementation HomeNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        self.titlLB = [[UILabel alloc] init];
        [self addSubview:self.titlLB];
        self.titlLB.font = kFont(15);;
        [self.titlLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.height.equalTo(@30);
            make.centerY.equalTo(self.mas_centerY);;
        }];
        self.titlLB.text = @"定位中";
        
        self.buttonLeft = [[UIButton alloc] init];
        [self.buttonLeft setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
        [self addSubview:self.buttonLeft];
        [self.buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@35);
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.titlLB.mas_right).offset(15);
        }];
        
        [[self.buttonLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@{@"key":@"city"}];
            }
        }];
        
        
        self.rightView = [[UIView alloc] init];
        [self addSubview:self.rightView];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            //            make.width.equalTo(@200);
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.buttonLeft.mas_right).offset(30);
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

            }
        }];
        
        
        
        self.TF = [[UITextField alloc] init];
        self.TF.font = kFont(14);
        self.TF.placeholder = @"搜索";
        [self.rightView addSubview:self.TF];
        
        [self.TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(self.rightView.mas_centerY);
            make.left.equalTo(self.rightView.mas_left).offset(20);
            make.right.equalTo(self.searchBt.mas_left).offset(-8);
        }];
        self.TF.delegate = self;

//        UIButton * button = [[UIButton alloc] init];
//        button.backgroundColor = [UIColor redColor];
//        [self.TF addSubview:button];
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.right.top.equalTo(self.TF);;
//        }];
//
//
//        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            if (self.delegateSignal) {
//
//                [self.delegateSignal sendNext:@{@"key":@"search",@"text":self.TF.text}];
//
//            }
//        }];
        
        
    }
    return self;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegateSignal) {

        [self.delegateSignal sendNext:@{@"key":@"search",@"text":self.TF.text}];

    }
    return NO;
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    theView.layer.cornerRadius = 10;
    //    theView.clipsToBounds = YES;
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 3;
    
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titlLB.text = titleStr;
}

///// 添加单边阴影效果
//- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
//    theView.layer.shadowColor = theColor.CGColor;
//    theView.layer.shadowOffset = CGSizeMake(0,0);
//    theView.layer.shadowOpacity = 0.5;
//    theView.layer.shadowRadius = 5;
//    // 单边阴影 顶边
//    float shadowPathWidth = theView.layer.shadowRadius;
//    CGRect shadowRect = CGRectMake(0, 0-shadowPathWidth/2.0, theView.bounds.size.width, shadowPathWidth);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
//    theView.layer.shadowPath = path.CGPath;
//
//}

@end
