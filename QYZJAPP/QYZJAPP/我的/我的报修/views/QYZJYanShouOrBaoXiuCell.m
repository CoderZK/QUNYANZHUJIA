//
//  QYZJYanShouOrBaoXiuCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJYanShouOrBaoXiuCell.h"

@implementation QYZJYanShouOrBaoXiuCell

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

- (void)setModel:(QYZJMoneyModel *)model {
    _model = model;
    if (self.type == 1) {
        self.titleLB.text = [NSString stringWithFormat:@"阶段名称: %@",model.stage_name];;
        self.contentLB.text = model.con;
    }else {
        self.contentLB.text =  [NSString stringWithFormat:@"阶段名称: %@",model.stage_name];
        self.yCons.constant = 0;
        self.hCons.constant = 0;
    }
}

@end
