//
//  QYZJQIngDanPingJiaCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQIngDanPingJiaCell.h"

@implementation QYZJQIngDanPingJiaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    NSArray * arr = @[@"",@"满意",@"一般",@"不满意"];
    self.statusLB.text = arr[model.evaluateLevel];
    self.contentLB.text = model.evaluateCon;
    
}

@end
