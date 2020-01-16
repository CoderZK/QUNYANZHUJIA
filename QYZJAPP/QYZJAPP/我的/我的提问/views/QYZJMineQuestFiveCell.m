//
//  QYZJMineQuestFiveCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineQuestFiveCell.h"

@implementation QYZJMineQuestFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        [self addSubview:self.imgV];
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 60, 17)];
        self.nameLB.font = kFont(14);
        [self addSubview:self.nameLB];
        
        self.typeLB = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 60, 17)];
        self.typeLB.layer.cornerRadius = 2;
        self.typeLB.layer.borderColor = YellowColor.CGColor;
        self.typeLB.layer.borderWidth = 0.8;
        self.typeLB.font = kFont(12);
        self.typeLB.textColor = YellowColor;
        self.typeLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.typeLB];
        
        self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(55, 37, 150, 25)];
        [self.listBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
        [self.listBt setImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
        [self.listBt setTitle:@"回复语音" forState:UIControlStateNormal];
        self.listBt.titleLabel.font = kFont(14);
        self.listBt.layer.cornerRadius = 12.5;
        self.listBt.clipsToBounds = YES;
        self.listBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.listBt setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        [self.listBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0,  0)];
        [self addSubview:self.listBt];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(55, 72, ScreenW - 65, 20)];
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        
        self.replyBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60, 15, 50, 17)];
        [self.replyBt setTitle:@"回复" forState:UIControlStateNormal];
        [self.replyBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
        self.replyBt.titleLabel.font = kFont(13);
        [self addSubview:self.replyBt];
//        [self.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)setType:(NSInteger)type {
    _type = type;
}
- (void)setIs_answer:(NSInteger)is_answer {
    _is_answer = is_answer;
}
- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.a_head_img]] placeholderImage:[UIImage imageNamed:@"963"]];
    self.nameLB.text = model.a_nick_name;
    self.nameLB.mj_w = [model.a_nick_name getWidhtWithFontSize:14];
    self.typeLB.mj_w = [model.a_role_name getWidhtWithFontSize:12] + 10;
    self.typeLB.text = model.a_role_name;
    if (model.role_name.length == 0) {
        self.typeLB.hidden = YES;
    }else {
        self.typeLB.hidden = NO;
    }
    
    self.typeLB.mj_x = CGRectGetMaxX(self.nameLB.frame) + 10;
    
    if (model.media_url.length == 0) {
        self.listBt.hidden = YES;
        self.contentLB.mj_y = 37;
    }else {
        self.listBt.hidden = NO;
        self.contentLB.mj_y = 72;
    }
    
    NSString * str = model.contents;
    if (self.type == 1) {
        if ([model.type integerValue] == 3 ) {
            if (self.is_answer == 1) {
                //普通用户
                str = [NSString stringWithFormat:@"追问 %@ : %@",model.nick_name,model.contents];
            }else {
                str = [NSString stringWithFormat:@"追问 : %@",model.contents];
            }
        }
    }
    
    CGFloat  h = [str getHeigtWithFontSize:13 lineSpace:3 width:ScreenW - 65];
    if (h<20) {
        h=20;
    }
    self.contentLB.mj_h = h;
    self.contentLB.attributedText = [str getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterColor80];
    CGFloat hhh  = CGRectGetMaxY(self.contentLB.frame) + 15;
    if (hhh < 70) {
        hhh = 70;
    }
    model.cellHeight = hhh;
    if (model.contents.length == 0) {
        model.cellHeight = 75;
        self.contentLB.hidden = YES;
    }else {
        self.contentLB.hidden = NO;
    }
    if (model.is_pay) {
        [self.listBt setTitle:[NSString stringWithFormat:@"￥%0.2f元旁听",model.sit_price] forState:UIControlStateNormal];
    }else {
       if (model.isPlaying) {
               [self.listBt setTitle:@"正在播放..." forState:UIControlStateNormal];
           }else {
               [self.listBt setTitle:@"点击播放" forState:UIControlStateNormal];
           }
    }
    
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
