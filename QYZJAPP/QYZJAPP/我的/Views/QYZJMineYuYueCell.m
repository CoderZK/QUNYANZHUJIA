//
//  QYZJMineYuYueCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineYuYueCell.h"

@implementation QYZJMineYuYueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJMoneyModel *)model {
    _model = model;
    self.titleLB.text = model.b_recomend_name;
    
    self.LB1.text = [NSString stringWithFormat:@"%@m²",model.area];
    self.LB2.text = model.type_name;
    self.addressLb.text = model.address;
    self.contentLB.text = model.demand_context;
    
    NSInteger status = [model.status integerValue];
    NSString * str1 = @"";
    NSString * str2 =@"审核成功";
    if (status == 0) {
        str1 = @"待抢单";
        str2 = @"未审核";
    }else if (status == 1) {
        str1 = @"签单中";
    }else if (status == 2) {
        str1 = @"签单结束";
    }else if (status == 3) {
        str1 = @"反馈有效";
    }else if (status == 4) {
        str1 = @"反馈无效";
    }else if (status == 5) {
        str1 = @"已签单";
    }else if (status == 6) {
        str1 = @"未签单";
    }else if (status == 7) {
        str1 = @"待交付";
    }else if (status == 8) {
        str1 = @"创建清单";
    }else if (status == 9) {
        str1 = @"施工中";
    }else if (status == 10) {
        str1 = @"验收通过";
    }else if (status == 11) {
        str1 = @"已评价";
    }
    self.tyepLB1.text = str1;
    self.typeLB2.text = str2;
    
}

@end
