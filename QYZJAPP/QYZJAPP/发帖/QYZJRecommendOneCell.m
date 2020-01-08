//
//  QYZJRecommendOneCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRecommendOneCell.h"

@implementation QYZJRecommendOneCell


- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titleLB.text = model.b_recomend_name;
    self.typeLB1.text = [NSString stringWithFormat:@"%@m²",model.area];

    self.typeLB2.text = model.type_name;
    self.typeLB3.text = @"签单比例";
    if ([model.commission_type isEqualToString:@"0"]) {
        self.typeLB3.text = @"定额返佣";
    }
    self.contentLB.text = model.b_recomend_address;
    self.timeLB.text = model.add_time;
    if (model.audit_status == 0) {
        self.statusLB.text = @"未审核";
    }else if (model.audit_status == 1) {
        self.statusLB.text = @"审核成功";
    }else {
        self.statusLB.text = @"审核失败";
    }
    
    self.qianDanLB.hidden = NO;
    NSInteger aa = [model.status intValue];

    if (aa == 0) {
        self.qianDanLB.text = @"待抢单";
    }else if (aa == 1) {
        self.qianDanLB.text = @"抢单中";
        
    }else if (aa == 2) {
        self.qianDanLB.text = @"抢单结束";
      
    }else if (aa == 3) {
        self.qianDanLB.text = @"有效信息";
       
        
    }else if (aa ==4) {
        self.qianDanLB.text = @"无效信息";
    
        
    }else if (aa == 5) {
        self.qianDanLB.text = @"已签单";
 
        
    }else if (aa == 6) {
        self.qianDanLB.text = @"签单失败";
      
        
    }else if (aa == 7) {
        self.qianDanLB.text = @"交付中";
 
        
    }else if (aa == 8) {
        self.qianDanLB.text = @"交付完成";
        
    }else if (aa == 9) {
        self.qianDanLB.hidden = YES;
    }else if (aa == 10) {
        self.qianDanLB.text = @"验收通过";
    }else {
        self.qianDanLB.text = @"已完成";
        
    }
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.qianDanLB.layer.cornerRadius = 3;
    self.qianDanLB.clipsToBounds = YES;
    self.qianDanLB.layer.borderColor = OrangeColor.CGColor;
    self.qianDanLB.layer.borderWidth = 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
