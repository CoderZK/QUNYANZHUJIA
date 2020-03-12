//
//  QYZJMineZhuYeHeadVIew.m
//  QYZJAPP
//
//  Created by zk on 2019/11/22.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineZhuYeHeadVIew.h"

@interface QYZJMineZhuYeHeadVIew()
@property(nonatomic,strong)UIButton *backBt,*shareBt,*headBt,*leftBt,*centerBt,*rightBt;
@property(nonatomic,strong)UILabel *titelLB,*nickNameLB,*scoreLB,*vipLB,*typeLB1,*typeLB2,*typeLB3,*typeLB4;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIView *whiteOneV,*whiteTwoView;
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3,*LB4,*LB5,*LB6;;
@end

@implementation QYZJMineZhuYeHeadVIew
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100+sstatusHeight)];
        self.imgV.image =[UIImage imageNamed:@"39"];
        [self addSubview:self.imgV];
        
        self.backBt = [[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2, 40, 40)];
        self.backBt.tag = 0;
        [self.backBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.backBt setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self addSubview:self.backBt];
        
        
        self.titelLB = [[UILabel alloc] initWithFrame:CGRectMake(100, sstatusHeight +2, ScreenW - 200,  40)];
        self.titelLB.textColor = WhiteColor;
        self.titelLB.font = kFont(18);
        self.titelLB.text = @"个人主页";
        self.titelLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titelLB];
        
        self.shareBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, sstatusHeight + 2, 40, 40)];
        self.shareBt.tag = 1;
        [self.shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.shareBt setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self addSubview:self.shareBt];
        
        self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgV.frame), ScreenW, 40)];
        self.whiteOneV.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteOneV];
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.imgV.frame) - 35 , 70, 70)];
        self.headBt.layer.cornerRadius = 35;
        self.headBt.clipsToBounds = YES;
        self.headBt.tag = 2;
        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headBt];
        self.headBt.backgroundColor = [UIColor redColor];
        
        self.editBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 85, 10, 70, 20)];
        self.clipsToBounds  = YES;
        [self.editBt setTitle:@"关注" forState:UIControlStateNormal];
        [self.editBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.editBt.layer.cornerRadius = 3;
        [self.editBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
        self.editBt.titleLabel.font = kFont(14);
        [self.whiteOneV addSubview:self.editBt];
        self.editBt.tag = 3;
        [self.editBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headBt.frame) + 10, ScreenW, 85)];
        self.nickNameLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 30, 20)];
        self.nickNameLB.font = [UIFont boldSystemFontOfSize:14];
        [self.whiteOneV addSubview:self.nickNameLB];
        
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 75, ScreenW, 10)];
        backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.whiteOneV addSubview:backV];
        

        
        self.scoreLB =  [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 30, 20)];
        self.scoreLB.font = [UIFont boldSystemFontOfSize:14];
        [self.whiteOneV addSubview:self.scoreLB];
        
        self.vipLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 30, 20)];
        self.vipLB.layer.borderColor = OrangeColor.CGColor;
        self.vipLB.layer.borderWidth = 1;
        self.vipLB.font = kFont(13);
        self.vipLB.textColor = OrangeColor;
        self.vipLB.textAlignment = NSTextAlignmentCenter;
        [self.whiteOneV addSubview:self.vipLB];
        self.vipLB.tag = 100;
        
        
        self.typeLB1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 30, 20)];
        self.typeLB1.layer.borderColor = OrangeColor.CGColor;
        self.typeLB1.layer.borderWidth = 1;
        self.typeLB1.font = kFont(13);
        self.typeLB1.textColor = OrangeColor;
        self.typeLB1.textAlignment = NSTextAlignmentCenter;
        [self.whiteOneV addSubview:self.typeLB1];
        
        self.typeLB2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 30, 20)];
        self.typeLB2.layer.borderColor = OrangeColor.CGColor;
        self.typeLB2.layer.borderWidth = 1;
        self.typeLB2.font = kFont(13);
        self.typeLB2.textColor = OrangeColor;
        self.typeLB2.textAlignment = NSTextAlignmentCenter;
        [self.whiteOneV addSubview:self.typeLB2];
        
        
        self.typeLB3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 30, 20)];
        self.typeLB3.layer.borderColor = OrangeColor.CGColor;
        self.typeLB3.layer.borderWidth = 1;
        self.typeLB3.font = kFont(13);
        self.typeLB3.textColor = OrangeColor;
        self.typeLB3.textAlignment = NSTextAlignmentCenter;
        [self.whiteOneV addSubview:self.typeLB3];
        
        
        self.typeLB4 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 30, 20)];
        self.typeLB4.layer.borderColor = OrangeColor.CGColor;
        self.typeLB4.layer.borderWidth = 1;
        self.typeLB4.font = kFont(13);
        self.typeLB4.textColor = OrangeColor;
        self.typeLB4.textAlignment = NSTextAlignmentCenter;
        [self.whiteOneV addSubview:self.typeLB4];
        self.typeLB1.tag = 101;
        self.typeLB2.tag = 102;
        self.typeLB3.tag = 103;
        self.typeLB4.tag = 104;
        
        [self addSubview:self.whiteOneV];
        
        
        self.headHeight = CGRectGetMaxY(self.whiteOneV.frame);
        
        
        self.LB1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 20, 20)];
        self.LB1.font = kFont(14);
        [self.whiteOneV addSubview:self.LB1];
        
        self.LB3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 20, 20)];
        self.LB3.font = kFont(14);
        [self.whiteOneV addSubview:self.LB3];
        
        self.LB5 = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 20, 20)];
        self.LB5.font = kFont(14);
        [self.whiteOneV addSubview:self.LB5];
        
        self.LB2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 40, 20)];
        self.LB2.font = kFont(14);
        self.LB2.textColor = CharacterColor180;
        self.LB2.text = @"问答";
        [self.whiteOneV addSubview:self.LB2];
        
        
        self.LB4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 40, 20)];
        self.LB4.font = kFont(14);
        self.LB4.textColor = CharacterColor180;
        self.LB4.text = @"粉丝";
        [self.whiteOneV addSubview:self.LB4];
        
        
        self.LB6 = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 40, 20)];
        self.LB6.font = kFont(14);
        self.LB6.textColor = CharacterColor180;
        self.LB6.text = @"预约";
        [self.whiteOneV addSubview:self.LB6];
        
    }
    return self;
}

- (void)clickAction:(UIButton *)button {
    
    if (self.clickZhuYeHeadBlock != nil) {
        self.clickZhuYeHeadBlock(button.tag,button);
    }
}

- (void)setDataModel:(QYZJUserModel *)dataModel {
    _dataModel = dataModel;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:dataModel.head_img]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"963"]];
    self.nickNameLB.text = dataModel.nick_name;
    self.nickNameLB.mj_w = [dataModel.nick_name getWidhtWithFontSize:15];
    self.scoreLB.mj_x = CGRectGetMaxX(self.nickNameLB.frame) + 10;
    self.scoreLB.text = [NSString stringWithFormat:@"%0.1f分",dataModel.score];
    self.scoreLB.mj_w = [self.scoreLB.text getWidhtWithFontSize:15];
    
    if (dataModel.is_follow) {
        [self.editBt setTitle:@"已关注" forState:UIControlStateNormal];
    }else {
        [self.editBt setTitle:@"关注" forState:UIControlStateNormal];
    }
    CGFloat mx = CGRectGetMaxX(self.scoreLB.frame) + 15;;
    self.vipLB.mj_x= CGRectGetMaxX(self.scoreLB.frame) + 15;
    if (dataModel.is_vip) {
        self.vipLB.text = @"vip";
        self.vipLB.mj_w = [@"vip" getWidhtWithFontSize:13] + 6;
        mx = CGRectGetMaxX(self.vipLB.frame) + 4;
        
        NSMutableArray * arr = [dataModel.label componentsSeparatedByString:@","].mutableCopy;;
        [arr insertObject:dataModel.role_name atIndex:0];
        for (int i = 0 ; i < 4 ; i++) {
            UILabel * lb = (UILabel *)[self.whiteOneV viewWithTag:101+i];
            if (i<arr.count) {
                lb.hidden = NO;
                lb.mj_x = mx;
                lb.text = arr[i];
                lb.mj_w = [arr[i] getWidhtWithFontSize:13] + 6;
                mx = CGRectGetMaxX(lb.frame) + 4;
            }else {
                lb.hidden = YES;
            }
            
        }
        
    }else {
        NSMutableArray * arr = [dataModel.label componentsSeparatedByString:@","].mutableCopy;;
        [arr insertObject:dataModel.role_name atIndex:0];
        for (int i = 0 ; i < 5 ; i++) {
            UILabel * lb = (UILabel *)[self.whiteOneV viewWithTag:100+i];
            if (i<arr.count) {
                lb.hidden = NO;
                lb.mj_x = mx;
                lb.text = arr[i];
                lb.mj_w = [arr[i] getWidhtWithFontSize:13] + 6;
                mx = CGRectGetMaxX(lb.frame) + 4;
            }else {
                lb.hidden = YES;
            }
            
        }
    }
    
    self.LB1.text= [NSString stringWithFormat:@"%ld",dataModel.answer_num];
    self.LB1.mj_w = [self.LB1.text getWidhtWithFontSize:14];
    self.LB2.mj_x = CGRectGetMaxX(self.LB1.frame) + 5;
    self.LB3.mj_x= CGRectGetMaxX(self.LB2.frame) + 5;
    self.LB3.text= [NSString stringWithFormat:@"%ld",dataModel.fans_num];
    self.LB3.mj_w = [self.LB3.text getWidhtWithFontSize:14];
    self.LB4.mj_x = CGRectGetMaxX(self.LB3.frame) + 5;
    self.LB5.mj_x= CGRectGetMaxX(self.LB4.frame) + 5;
    self.LB5.text= [NSString stringWithFormat:@"%ld",dataModel.appoint_num];
    self.LB5.mj_w = [self.LB5.text getWidhtWithFontSize:14];
    self.LB6.mj_x = CGRectGetMaxX(self.LB5.frame) + 5;

}

@end
