//
//  QYZJBankListCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJBankListCell.h"

@implementation QYZJBankListCell

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
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr: model.logo]] placeholderImage:[UIImage imageNamed:@"369"]];
    self.titleLB.text = model.name;
    self.numberLB.text = model.bank_account;
}

@end
