//
//  QYZJHomeFiveCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeFiveCell.h"

@interface QYZJHomeFiveCell()
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *scoreLB;
@property (weak, nonatomic) IBOutlet UILabel *baoLB;
@property (weak, nonatomic) IBOutlet UILabel *vipLB;
@property (weak, nonatomic) IBOutlet UILabel *requestLB;
@property (weak, nonatomic) IBOutlet UILabel *answerLB;
@property (weak, nonatomic) IBOutlet UILabel *fansLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB1;
@property (weak, nonatomic) IBOutlet UILabel *tyepLB2;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baoCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vipCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeOneCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeTwoCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vipLeftCons;


@end

@implementation QYZJHomeFiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.baoLB.text = @"保";
    self.vipLB.text = @"VIP";
    self.requestLB.text = @"可提问";
    
    CGFloat space = 10;
    
    self.baoCon.constant = [@"保" getWidhtWithFontSize:14] + space;
    self.vipCons.constant = [@"VIP" getWidhtWithFontSize:14] + space;
    self.answerCons.constant = [@"可提问" getWidhtWithFontSize:14] + space;
    
    
    self.baoLB.layer.borderWidth = self.vipLB.layer.borderWidth = self.requestLB.layer.borderWidth = 1.0;
    self.baoLB.clipsToBounds = self.vipLB.clipsToBounds = self.requestLB.clipsToBounds = YES;
    self.baoLB.layer.cornerRadius = self.vipLB.layer.cornerRadius = self.requestLB.layer.cornerRadius = 3;
    self.baoLB.textColor = OrangeColor;
    self.baoLB.layer.borderColor = OrangeColor.CGColor;
    
    self.vipLB.textColor = YellowColor;
    self.vipLB.layer.borderColor = YellowColor.CGColor;
    
    self.requestLB.textColor = BlueColor;
    self.requestLB.layer.borderColor = BlueColor.CGColor;

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
