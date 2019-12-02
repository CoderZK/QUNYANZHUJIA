//
//  QYZJMineYaoQingCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineYaoQingCell.h"

@implementation QYZJMineYaoQingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headBt.layer.cornerRadius = 35;
    self.headBt.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJFindModel *)model  {
    _model = model;
    self.titleLB.text = model.nick_name;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.head_img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.numberOneLB.text = [NSString stringWithFormat:@"%ld",(long)model.sign_num];
    self.numberTwoLB.text = [NSString stringWithFormat:@"%ld",(long)model.ok_num];
    self.numberThreeLB.text = [NSString stringWithFormat:@"%ld",(long)model.demand_num];
    self.timeLB.text = @"注册时间暂无";
}

@end
