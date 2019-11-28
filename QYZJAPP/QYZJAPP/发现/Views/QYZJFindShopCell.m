//
//  QYZJFindShopCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindShopCell.h"

@implementation QYZJFindShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataArray:(NSArray<QYZJFindModel *> *)dataArray {
    _dataArray = dataArray;
    QYZJFindModel * modelLeft = dataArray[0];
    QYZJFindModel * modelRight = nil;
    if (dataArray.count == 2) {
        modelRight = dataArray[1];
        self.rightImgV.hidden = self.rightMoneyLB.hidden = self.rightTitleLB.hidden = NO;
        [self.rightImgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:modelRight.pic]]  placeholderImage:[UIImage imageNamed:@"369"]];
        self.rightTitleLB.text = modelRight.name;
        self.rightMoneyLB.text = [NSString stringWithFormat:@"￥%0.2f",modelRight.price];
        if (modelRight.isSelect) {
            self.rightGouImgV.image = [UIImage imageNamed:@"31"];
        }else {
            self.rightGouImgV.image = [UIImage imageNamed:@"30"];
        }
    }else {
        self.rightImgV.hidden = self.rightMoneyLB.hidden = self.rightTitleLB.hidden = YES;
    }
     [self.leftImgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:modelLeft.pic]]  placeholderImage:[UIImage imageNamed:@"369"]];
     self.leftTitleLB.text = modelLeft.name;
    
     self.leftMoneyLB.text = [NSString stringWithFormat:@"￥%0.2f",modelLeft.price];
    if (modelLeft.isSelect) {
        self.leftGouImgV.image = [UIImage imageNamed:@"31"];
    }else {
        self.leftGouImgV.image = [UIImage imageNamed:@"30"];
    }
    
    
}

- (IBAction)selectAction:(UIButton *)sender {
    QYZJFindModel * model = self.dataArray[sender.tag];
    model.isSelect = !model.isSelect;
    if (sender.tag == 0) {
        if (model.isSelect) {
               self.leftGouImgV.image = [UIImage imageNamed:@"31"];
           }else {
               self.leftGouImgV.image = [UIImage imageNamed:@"30"];
           }
    }else {
       if (model.isSelect) {
            self.rightGouImgV.image = [UIImage imageNamed:@"31"];
        }else {
            self.rightGouImgV.image = [UIImage imageNamed:@"30"];
        }
    }
}



@end
