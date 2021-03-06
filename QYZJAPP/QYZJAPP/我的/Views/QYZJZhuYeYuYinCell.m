//
//  QYZJZhuYeYuYinCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/22.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJZhuYeYuYinCell.h"

@interface QYZJZhuYeYuYinCell()
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@property (weak, nonatomic) IBOutlet UILabel *numberLB;

@end

@implementation QYZJZhuYeYuYinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headBt.layer.cornerRadius = 25;
    self.headBt.clipsToBounds = YES;
    self.syBt.layer.cornerRadius = 12.5;
    self.syBt.clipsToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.q_head_img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"963"]];
    self.titleLB.text = model.q_nick_name;
    self.contentLB.text = model.title;
    self.numberLB.text = [NSString stringWithFormat:@"%ld人旁听",(long)model.sit_on_num];
    
    if (model.is_pay) {
          [self.syBt setTitle:[NSString stringWithFormat:@"￥%0.2f元旁听",model.sit_price] forState:UIControlStateNormal];
      }else {
         if (model.isPlaying) {
                 [self.syBt setTitle:@"正在播放..." forState:UIControlStateNormal];
             }else {
                 [self.syBt setTitle:@"点击播放" forState:UIControlStateNormal];
             }
      }
    
    

}





@end
