//
//  QYZJHomePayCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomePayCell.h"

@implementation QYZJHomePayCell

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
    self.titleLB.text = model.custom_nick_name;
    self.contentLB.text = model.custom_telphone;
    self.timeLB.text = model.custom_telphone;
    
    self.typeLB1.text = [NSString stringWithFormat:@"%@m2",model.area];
    self.typeLB2.text = model.type_name;
    
}


@end
