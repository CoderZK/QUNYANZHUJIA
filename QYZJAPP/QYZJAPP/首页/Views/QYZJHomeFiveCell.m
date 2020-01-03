//
//  QYZJHomeFiveCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomeFiveCell.h"

@interface QYZJHomeFiveCell()

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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baoLeftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vpLeftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerLeftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleNameCons;


@end

@implementation QYZJHomeFiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.baoLB.text = @"保";
    self.vipLB.text = @"VIP";
    self.requestLB.text = @"可提问";
    
    self.headBt.layer.cornerRadius = 35
    ;
    self.headBt.clipsToBounds = YES;
    
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

    self.imgV.hidden = YES;
    self.headBtMxCons.constant = 15;
    
}
- (void)setType:(NSInteger)type {
    _type = type;
    
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL: [NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.head_img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"963"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.nick_name;
//    self.titleNameCons.constant =
    self.scoreLB.text = [NSString stringWithFormat:@"%0.2f分",[model.score floatValue]];
    
    CGFloat space = 10;

    if (model.is_bond) {
       self.baoCon.constant = [@"保" getWidhtWithFontSize:14] + space;
    }else {
        self.baoCon.constant = 0;
        self.baoLeftCons.constant = 0;
    }
    if (model.is_vip) {
        self.vipCons.constant = [@"VIP" getWidhtWithFontSize:14] + space;
        self.vpLeftCons.constant = 10;
    }else {
        self.vipCons.constant = 0;
        self.vpLeftCons.constant = 0;
    }
    if (model.is_question) {
        self.answerCons.constant = [@"可提问" getWidhtWithFontSize:14] + space;
        self.answerLeftCons.constant = 10;
    }else {
       self.answerCons.constant = 0;
       self.answerLeftCons.constant = 0;
    }
    
    self.fansLB.text = [NSString stringWithFormat:@"%ld",model.fans_num]; ;
    self.answerLB.text = [NSString stringWithFormat:@"%ld",model.answer_num];
    
    NSString * str = model.role_name;
    NSArray * arr = @[];
    self.tyepLB2.hidden = self.typeLB1.hidden = YES;
    if (str.length == 0) {
        
    }else{
        arr = [str componentsSeparatedByString:@","];
    
        if ( arr.count > 0) {
            self.typeLB1.text = arr[0];
            self.typeOneCons.constant = [arr[0] getWidhtWithFontSize:14]+10;
            self.typeLB1.hidden = NO;
            
        }
//        if (arr.count > 1) {
//            self.typeLB1.text = arr[0];
//            self.typeOneCons.constant = [arr[0] getWidhtWithFontSize:14]+10;
//
//            self.tyepLB2.text = arr[0];
//            self.typeTwoCons.constant = [arr[1] getWidhtWithFontSize:14]+10;
//            self.tyepLB2.hidden = self.typeLB1.hidden = NO;
//        }
    }

    if (model.question_price>0 && model.appoint_price > 0) {
        self.moneyLB.text = [NSString stringWithFormat:@"提问:￥%0.2f  预约:￥%0.2f",model.question_price,model.appoint_price];
    }else if (model.question_price > 0 && model.appoint_price == 0) {
          self.moneyLB.text = [NSString stringWithFormat:@"提问:￥%0.2f",model.question_price];
    }else if (model.question_price == 0 && model.appoint_price > 0) {
        self.moneyLB.text = [NSString stringWithFormat:@"预约:￥%0.2f",model.appoint_price];
    }
    
//    [self layoutIfNeeded];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
