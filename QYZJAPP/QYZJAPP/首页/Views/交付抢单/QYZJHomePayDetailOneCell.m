//
//  QYZJHomePayDetailOneCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomePayDetailOneCell.h"

@implementation QYZJHomePayDetailOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setType:(NSInteger)type {
    _type = type;
}

- (void)setModel:(QYZJWorkModel *)model {
    _model = model;
    if (self.type == 0) {
        self.LB1.text = @"首付";
    }else {
        self.LB1.text = @"尾款";
    }
    if ([model.status intValue] == 0) {
        self.LB2.text = @"未支付";
    }else {
        self.LB2.text = @"已支付";
    }
    
    self.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",model.payMoney];
    NSInteger payType = [model.payType intValue];
    NSString * str = @"";
    if (payType == 0) {
        str = @"支付宝";
    }else if (payType == 1) {
        str = @"微信";
    }else if (payType == 2) {
        str = @"余额";
    }else if (payType == 3) {
        str = @"支付钱包";
    }else if (payType == 4) {
        str = @"支付钱包+提现钱包";
    }else if (payType == 5) {
        str = @"支付钱包+提现钱包+微信";
    }else if (payType == 6) {
        str = @"线下支付";
    }
    self.LB4.text = str;
    self.LB6.text = model.no;
    model.cellHeight = 110;
}

@end
