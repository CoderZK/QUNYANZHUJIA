//
//  QYZJQianDanOneCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQianDanOneCell.h"

@implementation QYZJQianDanOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.qianDanBt.layer.cornerRadius = 32.5;
    self.qianDanBt.clipsToBounds = YES;
    self.gouTongBt.layer.cornerRadius = 12.5;
    self.gouTongBt.clipsToBounds = YES;
    self.statusLB.layer.cornerRadius = 2;
    self.statusLB.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(QYZJFindModel *)model {
    
    // 状态 0:发布待抢单 1:抢单中 2:抢单结束 3:反馈有效 4:反馈无效 5:已签单 6:未签单 7:发起交付 8:创建施工清单 9:施工中 10:验收通过 11:已评价(完结)
    
    _model = model;
    self.titleLB.text = model.b_recomend_name;
    self.typeLB1.text = [NSString stringWithFormat:@"%@m²",model.area];
    self.typeLB2.text = model.type_name;
    self.contentLB.text = model.b_recomend_address;

    if ( [model.status intValue] == 0 ||  [model.status intValue] == 1) {
         [self.qianDanBt setTitle:@"抢单" forState:UIControlStateNormal];
         [self.qianDanBt setBackgroundColor:OrangeColor];
         self.qianDanBt.userInteractionEnabled = YES;
     }else {
        [self.qianDanBt setTitle:@"已结束" forState:UIControlStateNormal];
        [self.qianDanBt setBackgroundColor:RGB(180, 180, 180)];
        self.qianDanBt.userInteractionEnabled = NO;
     }

    self.timeLB.text = model.add_time;
    
    BOOL isOrangeCoclor = YES;
    
    if ([model.user_status intValue] == 0) {
        self.statusLB.text = @"失效";
    }else if ([model.user_status intValue] == 1) {
        self.statusLB.text = @"未支付";
        
    }else if ([model.user_status intValue] == 2) {
        self.statusLB.text = @"待反馈";
        isOrangeCoclor = YES;
    }else if ([model.user_status intValue] == 3) {
        self.statusLB.text = @"反馈有效";
        isOrangeCoclor = NO;
        
    }else if ([model.user_status intValue] ==4) {
        self.statusLB.text = @"反馈无效";
        isOrangeCoclor = NO;
        
    }else if ([model.user_status intValue] == 5) {
        self.statusLB.text = @"已签单";
        isOrangeCoclor = YES;
        
    }else if ([model.user_status intValue] == 6) {
        self.statusLB.text = @"未签单";
        isOrangeCoclor = YES;
        
    }else if ([model.user_status intValue] == 7) {
        self.statusLB.text = @"支付佣金";
        isOrangeCoclor = YES;
        
    }else if ([model.user_status intValue] == 8) {
        self.statusLB.text = @"已完善";
        isOrangeCoclor = YES;
    }else if ([model.user_status intValue] == 9) {
        self.statusLB.text = @"已关闭";
    }else if ([model.user_status intValue] == 10) {
        self.statusLB.text = @"交付中";
        isOrangeCoclor = YES;
    }else {
        self.statusLB.text = @"已完成";
        isOrangeCoclor = NO;
    }
    if (isOrangeCoclor) {
        self.statusLB.layer.borderColor = OrangeColor.CGColor;
        self.statusLB.layer.borderWidth = 1.0;
        self.statusLB.textColor = OrangeColor;
    }else {
        self.statusLB.layer.borderColor = CharacterColor180.CGColor;
        self.statusLB.layer.borderWidth = 1.0;
        self.statusLB.textColor = CharacterColor180;
    }
 
    if (model.media_url.length > 0) {
        self.gouTongBt.hidden = self.moneyLB.hidden = NO;
        
        self.moneyLB.text = [NSString stringWithFormat:@"￥%@元听",@"1"];
    }else {
        self.gouTongBt.hidden = self.moneyLB.hidden = YES;
    }

    if (model.appeal_status.length == 0) {
        self.appealLB.hidden = YES;
    }else {
        self.appealLB.hidden = NO;
        if ([model.appeal_status isEqualToString:@"0"]) {
            self.appealLB.text = @"申诉中";
        }else if ([model.appeal_status isEqualToString:@"1"]) {
            self.appealLB.text = @"申诉成功";
        }else {
            self.appealLB.text = @"申诉失败";
        }
    }
    
    
    
    
}

@end
