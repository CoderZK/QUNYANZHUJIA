//
//  QYZJMineOrderCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineOrderCell.h"

@implementation QYZJMineOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
    
    
    
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titleLB.text = model.shopName;
    self.leftLB.text = model.goods_name;
    self.timeLB.text = model.time;
    [self.leftImgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.goods_pic]] placeholderImage:[UIImage imageNamed:@"369"]];
    self.moneyLB.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
}

@end
