//
//  QYZJMineTiXianCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/16.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineTiXianCell.h"

@implementation QYZJMineTiXianCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moneyTwoLB.textColor = BlueColor;
    
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
    self.titleLB.text = model.logNote;
    self.timeLB.text = model.addtime;
    self.moneyLB.text = [NSString stringWithFormat:@"-%0.2f",model.money];
    if ([model.status isEqualToString:@"2"]){
        self.statusLB.text = @"成功";
        self.statusLB.textColor = BlueColor;
    }else {
        self.statusLB.text = @"失败";
        self.statusLB.textColor = CharacterBlack112;
    }
    
    if (self.type == 0) {
        self.moneyTwoLB.hidden = YES;
        
    }else if (self.type == 1){
        self.statusLB.text = model.addtime;
        self.statusLB.textColor = CharacterBlack112;
        self.moneyTwoLB.hidden = NO;
        self.moneyTwoLB.text = [NSString stringWithFormat:@"-%0.2f",model.money];
    }else {
        self.statusLB.text = model.addtime;
        self.statusLB.textColor = CharacterBlack112;
        self.moneyTwoLB.hidden = NO;
        self.moneyTwoLB.textColor = OrangeColor;
        self.moneyTwoLB.text = [NSString stringWithFormat:@"+%0.2f",model.money];
        
    }
    
    
}

@end
