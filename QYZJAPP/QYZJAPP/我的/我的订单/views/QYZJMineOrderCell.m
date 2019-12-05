//
//  QYZJMineOrderCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/15.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineOrderCell.h"

@implementation QYZJMineOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleRightLB.hidden  = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
    
    
    
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titleLB.text = model.shopName;
    self.leftLB.text = model.goods_name;
    self.timeLB.text = model.time;
    [self.leftImgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.goods_pic]] placeholderImage:[UIImage imageNamed:@"369"]];
    self.moneyLB.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    self.statusBt.layer.cornerRadius = 3;
    self.statusBt.clipsToBounds = YES;
    self.statusBt.layer.borderColor = OrangeColor.CGColor;
    self.statusBt.layer.borderWidth = 0;
    //NO 卖家 Yes 卖家
    NSInteger hh = [model.status integerValue];
    NSString * ss = @"";
    if (model.isSale) {
        switch (hh) {
            case 0:
            {
                ss = @"待支付";
                break;
            }
                case 1:
                {
                    ss = @"发货";
                    self.statusBt.layer.borderColor = OrangeColor.CGColor;
                    self.statusBt.layer.borderWidth = 1;
                    break;
                }
                case 2:
                {
                    ss = @"待买家收货";
                    break;
                }
                case 3:
                {
                    ss = @"待评价";
                    break;
                }
            default:
                break;
        }
        
        
    }else {
        
        switch (hh) {
                  case 0:
                  {
                      ss = @"待支付";
                      break;
                  }
                      case 1:
                      {
                          ss = @"待卖家发货";
                          
                          break;
                      }
                      case 2:
                      {
                          ss = @"收货";
                          self.statusBt.layer.borderColor = OrangeColor.CGColor;
                          self.statusBt.layer.borderWidth = 1;
                          break;
                      }
                      case 3:
                      {
                          ss = @"待评价";
                          break;
                      }
                  default:
                      break;
              }
              
        
    }
    
    [self.statusBt setTitle:ss forState:UIControlStateNormal];
    
}

@end
