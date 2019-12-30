//
//  QYZJMineHeadView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineHeadView.h"

@interface QYZJMineHeadView()
@property(nonatomic,strong)UIButton *headBt,*settingBt;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *mesageBt;
@property(nonatomic,strong)UIView *redV;
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3;

@end

@implementation QYZJMineHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        //110
        self.backgroundColor = OrangeColor;
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(25, 50, 60, 60)];
        self.headBt.layer.cornerRadius = 30;
        self.headBt.clipsToBounds = YES;
        self.headBt.layer.borderColor = WhiteColor.CGColor;
        self.headBt.layer.borderWidth = 4;;
        [self addSubview:self.headBt];
        self.headBt.tag = 0;
        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, CGRectGetMinY(self.headBt.frame) + 10, 50, 20)];
        self.titleLB.textColor = WhiteColor;
        self.titleLB.font = kFont(16);
        self.titleLB.text = @"测试";
        [self addSubview:self.titleLB];
        
        
        self.mesageBt = [[UIButton alloc] init];
        self.mesageBt.mj_y = CGRectGetMinY(self.headBt.frame) + 5;
        self.mesageBt.height = 30;
        self.mesageBt.width = 50;
        self.mesageBt.mj_x = CGRectGetMaxX(self.titleLB.frame) + 10;
        [self.mesageBt setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
        [self addSubview:self.mesageBt];
        self.mesageBt.tag = 2;
        [self.mesageBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.redV = [[UIView alloc] initWithFrame:CGRectMake(self.mesageBt.frame.size.width / 2 + 8, 3, 6, 6)];
        self.redV.backgroundColor = [UIColor redColor];
        [self.mesageBt addSubview:self.redV];
        self.redV.layer.cornerRadius = 3;
        self.redV.clipsToBounds = YES;
        
        self.settingBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 10 - 40, sstatusHeight, 40, 40)];
        [self.settingBt setImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];
        [self addSubview:self.settingBt];
        self.settingBt.tag = 1;
        [self.settingBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _LB1 = [[UILabel alloc] init];
        _LB1.textColor = WhiteColor;
        _LB1.text = @"8665";
        _LB1.font = kFont(14);
        _LB1.mj_x = CGRectGetMaxX(self.headBt.frame) + 10;
        _LB1.height = 20;
        _LB1.width = 50;
        _LB1.mj_y = CGRectGetMaxY(self.headBt.frame) - 20;
        _LB1.layer.borderColor = WhiteColor.CGColor;
        _LB1.layer.borderWidth = 1;
        _LB1.layer.cornerRadius = 2;
        _LB1.clipsToBounds = YES;
        
        [self addSubview:_LB1];
        
        _LB2 = [[UILabel alloc] init];
        _LB2.textColor = WhiteColor;
        _LB2.font = kFont(14);
        _LB2.mj_x = CGRectGetMaxX(self.headBt.frame) + 10;
        _LB2.height = 20;
        _LB2.width = 50;
        _LB2.mj_y = CGRectGetMaxY(self.headBt.frame) - 20;
        _LB2.layer.borderColor = WhiteColor.CGColor;
        _LB2.layer.borderWidth = 1;
        _LB2.layer.cornerRadius = 2;
        _LB2.clipsToBounds = YES;
        [self addSubview:_LB2];
        
        _LB3 = [[UILabel alloc] init];
        _LB3.textColor = WhiteColor;
        _LB3.font = kFont(14);
        _LB3.mj_x = CGRectGetMaxX(self.headBt.frame) + 10;
        _LB3.layer.borderColor = WhiteColor.CGColor;
        _LB3.layer.borderWidth = 1;
        _LB3.layer.cornerRadius = 2;
        _LB3.height = 20;
        _LB3.width = 50;
        _LB3.mj_y = CGRectGetMaxY(self.headBt.frame) - 20;
        _LB3.clipsToBounds = YES;
        [self addSubview:_LB3];
        
        _LB1.textAlignment = _LB2.textAlignment = _LB3.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}


- (void)clickAction:(UIButton *)button {
    if (self.clickMineHeadBlock != nil) {
        self.clickMineHeadBlock(button.tag);
    }
}


- (void)setDataModel:(QYZJUserModel *)dataModel {
    _dataModel = dataModel;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:dataModel.head_img]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"963"]];
    self.titleLB.text = dataModel.nick_name;
    self.titleLB.width = [dataModel.nick_name getWidhtWithFontSize:16]+5;
    self.mesageBt.mj_x = CGRectGetMaxX(self.titleLB.frame);
    if (dataModel.isNews) {
        self.redV.hidden = NO;
    }else {
        self.redV.hidden = YES;
    }
    
    
    if (dataModel.is_vip) {
        _LB1.text = @"VIP会员";
        _LB1.hidden = NO;
        _LB1.mj_w = [_LB1.text getWidhtWithFontSize:14] + 10;
    }else {
        _LB1.hidden = YES;
    }
    
    if (dataModel.is_coach) {
        _LB2.text = @"教练";
        _LB2.hidden = NO;
        _LB2.mj_w = [_LB2.text getWidhtWithFontSize:14] + 10;
        if (dataModel.is_vip == NO) {
            _LB2.mj_x = CGRectGetMaxX(self.headBt.frame) + 10;
        }else {
            _LB2.mj_x = CGRectGetMaxX(self.LB1.frame) + 8;
        }
    }else {
        _LB2.hidden = YES;
    }
    
    if (dataModel.role_name.length > 0) {
        _LB3.text = dataModel.role_name;
        _LB3.hidden = NO;
        _LB3.mj_w = [_LB3.text getWidhtWithFontSize:14] + 10;
        if (dataModel.is_vip == YES) {
            
            if (dataModel.is_coach) {
                _LB3.mj_x = CGRectGetMaxX(self.LB2.frame) + 8;
            }else {
                _LB3.mj_x = CGRectGetMaxX(self.LB1.frame) + 8;
            }
        }  else {
            if (dataModel.is_coach) {
                _LB3.mj_x = CGRectGetMaxX(self.LB2.frame) + 8;
            }else {
                _LB3.mj_x = CGRectGetMaxX(self.headBt.frame) + 10;
            }
        }
        
        
    }else {
        _LB3.hidden = YES;
    }
    
    
    
    
    
}


@end
