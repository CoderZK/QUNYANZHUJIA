//
//  QYZJMineBaoXiuCellTableViewCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineBaoXiuCellTableViewCell.h"

@implementation QYZJMineBaoXiuCellTableViewCell

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
    self.titleLB.text = model.turnoverStageName;
    self.contentLB.text = model.con;
    self.timeLB.text = model.time;
    
    

    
    
    
}

@end
