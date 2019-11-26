//
//  QYZJJiaoFuListCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJJiaoFuListCell.h"

@implementation QYZJJiaoFuListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJFindModel *)model {
    
    // 状态 0:发布待抢单 1:抢单中 2:抢单结束 3:反馈有效 4:反馈无效 5:已签单 6:未签单 7:发起交付 8:创建施工清单 9:施工中 10:验收通过 11:已评价(完结)
    
    _model = model;
    self.titleLB.text = model.b_recomend_name;
    self.typeLB1.text = [NSString stringWithFormat:@"%@m2",model.area];
    self.typeLB2.text = model.type_name;
    self.contentLB.text = model.b_recomend_address;
    
    if (model.isSelect) {
        [self.leftBt setBackgroundImage:[UIImage imageNamed:@"xuanze_2"] forState:UIControlStateNormal];
    }else {
        [self.leftBt setBackgroundImage:[UIImage imageNamed:@"xuanze_1"] forState:UIControlStateNormal];
    }
    

   
}



@end
