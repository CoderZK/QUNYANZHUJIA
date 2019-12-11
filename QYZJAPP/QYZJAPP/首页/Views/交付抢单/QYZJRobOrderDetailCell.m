//
//  QYZJRobOrderDetailCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRobOrderDetailCell.h"

@implementation QYZJRobOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.gouTongBt.layer.cornerRadius = 12.5;
    self.gouTongBt.clipsToBounds = YES;
    self.leftLB.hidden = YES;
    
}

- (void)setType:(NSInteger)type {
    _type = type;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJWorkModel *)model {
    _model = model;
    self.titelLB.text = @"小燕子";
    if (self.type == 1) {
        self.titelLB.text = model.demand_context;
      
    }
    
    
    
}
- (IBAction)playMp3:(UIButton *)button {
   
    if (self.type == 1) {
         [button setTitle:@"播放中..." forState:UIControlStateNormal];
        [[PublicFuntionTool shareTool] palyMp3WithNSSting:self.model.demand_voice isLocality:NO];
    }else if (self.type == 2){
        if (self.listBtActionBlock != nil) {
            self.listBtActionBlock(button);
        }
    }
    Weak(weakSelf);
    [PublicFuntionTool shareTool].findPlayBlock = ^{
        if (weakSelf.type == 1) {
            [button setTitle:@"语音描述" forState:UIControlStateNormal];
        }else {
            [button setTitle:@"语音描述" forState:UIControlStateNormal];
        }
        
    };
}


@end
