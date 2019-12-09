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
//    self.typeLB2.text =

    self.typeLB3.text = @"签单比例";
    if ([model.commission_type isEqualToString:@"0"]) {
        self.typeLB3.text = @"定额返佣";
    }
    self.contentLB.text = model.b_recomend_address;
    self.timeLB.text = model.add_time;
    if (model.audit_status == 0) {
        self.qianDanLB.text = @"未签单";
        self.statusLB.text = @"未审核";
    }else if (model.audit_status == 1) {
        self.qianDanLB.text = @"签单成功";
        self.statusLB.text = @"审核成功";
    }else {
        self.qianDanLB.text = @"签单失败";
        self.statusLB.text = @"审核失败";
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
