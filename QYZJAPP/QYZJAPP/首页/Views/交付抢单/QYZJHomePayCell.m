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

- (void)setType:(NSInteger)type {
    _type = type;
 
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titleLB.text = model.custom_nick_name;
    self.contentLB.text = model.b_recomend_address;
    self.timeLB.text = model.custom_telphone;
    
    self.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",model.allPrice];
    self.typeLB1.text = [NSString stringWithFormat:@"%@m²",model.area];
    self.typeLB2.text = model.type_name;
    self.qianDanLB.textColor = OrangeColor;
    NSString * str = @"";
    if (model.is_service) {
        switch ([model.user_status intValue]) {
            case 1:
            {
                str = @"待交付";
                break;
            }
            case 2:
            {
                str = @"待客户确认";
                break;
            }
            case 3:
            {
                str = @"待客户支付";
                break;
            }
            case 4:
            {
                str = @"施工中";
                break;
            }
            case 5:
            {
                str = @"待验收";
                break;
            }
            case 6:
            {
                str = @"待客户支付尾款";
                break;
            }
            case 7:
            {
                str = @"待客户评价";
                break;
            }
            case 8:
            {
                str = @"交付完成";
                self.qianDanLB.textColor = GreenColor;
                break;
            }
                
            default:
                break;
        }
    }else {
       switch ([model.user_status intValue]) {
            case 1:
            {
                str = @"待交付";
                break;
            }
            case 2:
            {
                str = @"待确认";
                break;
            }
            case 3:
            {
                str = @"待支付";
                break;
            }
            case 4:
            {
                str = @"施工中";
                break;
            }
            case 5:
            {
                str = @"待验收";
                break;
            }
            case 6:
            {
                str = @"待客户支付尾款";
                break;
            }
            case 7:
            {
                str = @"待评价";
                break;
            }
            case 8:
            {
                str = @"交付完成";
                self.qianDanLB.textColor = GreenColor;
                break;
            }
                
            default:
                break;
        }
    }
    
    self.qianDanLB.text = str;
    
    if (self.type == 1 ) {
        if ([model.user_status intValue] == 3 || [model.user_status intValue] == 1) {
            self.statusCons.constant = 15;
            self.moneyLB.hidden = YES;
        }else {
            self.statusCons.constant = 92;
            self.moneyLB.hidden = NO;
        }
    }
    
    
    
}


@end
