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

    NSInteger sta = [model.status intValue];
    
    NSString * statusStr = @"";
    
    if (sta) {
        switch (sta) {
            case 1:
            {
                statusStr = @"待确认";
                break;
            }
                case 2:
                {
                    statusStr = @"报修中...";
                    break;
                }
                case 3:
                {
                    statusStr = @"待验收";
                    break;
                }
                case 4:
                {
                    statusStr = @"验收通过";
                    break;
                }
                case 5:
                {
                    statusStr = @"待验收通过";
                    break;
                }case 6:
                {
                    statusStr = @"整改中";
                    break;
                }
                case 7:
                {
                    statusStr = @"整改完成";
                    break;
                }
            default:
                break;
        }
        
        
    }
    
    
}

@end
