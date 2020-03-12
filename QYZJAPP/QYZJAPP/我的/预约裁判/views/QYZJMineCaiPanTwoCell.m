//
//  QYZJMineCaiPanTwoCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineCaiPanTwoCell.h"

@implementation QYZJMineCaiPanTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 35;
    self.headBt.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.head_img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"963"]];
    self.titelLB.text = model.nick_name;
    self.contentLB.text = model.telphone;
    
    self.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",model.price];
}

@end
