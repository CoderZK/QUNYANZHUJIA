//
//  QYZJConstructionListCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJConstructionListCell.h"

@interface QYZJConstructionListCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *titleLB,*contentLB,*timeLB,*moneyLB;
@property(nonatomic,strong)UIButton *statusBt,*editBt;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *whiteV;
@end


@implementation QYZJConstructionListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW-20-150, 20)];
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        
        self.editBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 7.5, 25, 25)];
        [self.editBt setImage:[UIImage imageNamed:@"36"] forState:UIControlStateNormal];
        self.editBt.tag = 100;
        [self.editBt addTarget:self action:@selector(editOrStatusAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.editBt];
        
        self.moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 150, 10, 140, 20)];
        self.moneyLB.font = [UIFont boldSystemFontOfSize:14];
        self.moneyLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.moneyLB];
        
        self.statusBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 150, 40, 140, 20)];
        self.statusBt.tag = 101;
        [self.statusBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.statusBt.titleLabel.font = kFont(14);
        [self addSubview:self.statusBt];
        [self.statusBt addTarget:self action:@selector(editOrStatusAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, ScreenW - 20 - 150, 20)];
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        
        
        self.timeLB =[[UILabel alloc] initWithFrame:CGRectMake(10, 60, ScreenW - 20, 20)];
        
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterBlack112;
        [self addSubview:self.timeLB];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 50, ScreenW-20, 1)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[QYZJConstructionListNeiCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];

        
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(@0.6);
        }];

        
        
    }
    return self;
}


//
- (void)editOrStatusAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didclickQYZJConstructionListCell:withIndex:isNeiClick:NeiRow:isClickNeiCell:)]) {
        [self.delegate didclickQYZJConstructionListCell:self  withIndex:button.tag-100 isNeiClick:NO NeiRow:0 isClickNeiCell:NO];
    }
}

- (void)setIs_service:(BOOL)is_service {
    _is_service = is_service;
}

- (void)setModel:(QYZJWorkModel *)model {
    _model = model;
    
    CGFloat ww = [model.stageName getWidhtWithFontSize:14 withBlood:YES];
    if (ww > ScreenW - 20 - 150 - 30) {
        ww = ScreenW - 20 - 150 - 30;
    }
    
    self.titleLB.attributedText = [model.stageName getMutableAttributeStringWithFont:14 withBlood:YES lineSpace:3 textColor:[UIColor blackColor]];
    self.titleLB.mj_h = [model.stageName getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ww];
    if (self.timeLB.mj_h < 20) {
        self.timeLB.mj_h = 20;
    }
    self.titleLB.mj_w = ww;
    self.editBt.mj_x = ww+15;
    
    self.moneyLB.text = [NSString stringWithFormat:@"￥%0.0f",model.price];
    
    if (self.type == 1) {
        self.moneyLB.hidden = YES;
    }else {
        self.moneyLB.hidden = NO;
    }
    
    self.contentLB.attributedText = [model.des getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack112];
    self.contentLB.mj_h = [model.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-20 -150];
    if (self.contentLB.mj_h < 20) {
        self.contentLB.mj_h = 20;
    }
    self.timeLB.text = model.time;
    self.contentLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 10;
    self.timeLB.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10;
    self.tableView.mj_y = CGRectGetMaxY(self.timeLB.frame);
    self.tableView.clipsToBounds = YES;
  
    if (model.selfStage.count==0) {
        self.tableView.mj_h = 0;
        model.cellHeight = CGRectGetMaxY(self.timeLB.frame) + 10;
    }else {
        
        [self.tableView reloadData];
        
        CGFloat tvH = 0;
        for (QYZJWorkModel * modelNei  in model.selfStage) {
            CGFloat titelH = [modelNei.stageName getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW - 40] <20?20:[modelNei.stageName getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW - 40];
            CGFloat contentH = 0;
            if (self.type == 1) {
                titelH = 0;
                contentH = [modelNei.con getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40] < 20?20:[modelNei.con getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40];
            }else {
                contentH = [modelNei.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40] < 20?20:[modelNei.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40];
            }
            tvH = tvH + (titelH + contentH + 20 + 20) ;
        }
        tvH = tvH +  self.model.selfStage.count * 8 ;
        self.tableView.mj_h = tvH ;
        model.cellHeight = CGRectGetMaxY(self.timeLB.frame) + 10 + tvH;
    }
   
    if (self.type == 1) {
        if (!self.is_service) {
                   //服务方
                   NSInteger st = [model.status intValue];
                   BOOL isLayer = NO;
                   NSString * str = @"";
                    if (st == 1) {
                      str = @"待确认";
                      isLayer = YES;
                  }else if (st == 2){
                      str = @"报修中";
                  }else if (st == 3){
                      str = @"待客户验收";
                  }else if (st == 4){
                      str = @"验收通过";
                  }else if (st == 5){
                      str = @"待整改";
                  }else if (st == 6){
                      str = @"整改中";
                  }else if (st == 7) {
                      str = @"整改完成";
                  }else if (st ==8) {
                      str = @"审核未通过";
                  }
                  
                   
                   CGFloat w = [str getWidhtWithFontSize:14];
                   self.statusBt.mj_w = w;
                   self.statusBt.mj_x = ScreenW - (w+8) - 10;
                   self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
                   self.statusBt.layer.borderWidth = 1.0;
                   self.statusBt.userInteractionEnabled = isLayer;
                   [self.statusBt setTitle:str forState:UIControlStateNormal];
                   self.editBt.hidden = !isLayer;
                   
               }else {
                   //用户
                   self.editBt.hidden = YES;
                   NSInteger st = [model.status intValue];
                   BOOL isLayer = NO;
                   NSString * str = @"";
                   if (st == 1) {
                       str = @"待服务方确认";
                   }else if (st == 2){
                       str = @"报修中";
                   }else if (st == 3){
                       str = @"待验收";
                   }else if (st == 4){
                       str = @"验收通过";
                   }else if (st == 5){
                       str = @"待服务方整改";
                   }else if (st == 6){
                       str = @"整改中";
                   }else if (st == 7){
                       str = @"整改完成";
                   }else if (st == 8) {
                       str = @"审核未通过";
                   }
                   CGFloat w = [str getWidhtWithFontSize:14];
                   self.statusBt.mj_w = w;
                   self.statusBt.mj_x = ScreenW - (w) - 10;
                   self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
                   self.statusBt.layer.borderWidth = 1.0;
                   self.statusBt.userInteractionEnabled = isLayer;
                   [self.statusBt setTitle:str forState:UIControlStateNormal];
                   
               }
    }else {
        
        if (!self.is_service) {
            //服务方
            NSInteger st = [model.status intValue];
            if (st == 1 || st == 3 || st == 5) {
                self.editBt.hidden = NO;
            }else {
                self.editBt.hidden  = YES;
            }
            BOOL isLayer = NO;
            NSString * str = @"";
            if (st == 1) {
                str = @"提交阶段验收";
                isLayer = YES;
            }else if (st == 2){
                str = @"验收中";
            }else if (st == 3){
                str = @"待整改";
            }else if (st == 4){
                str = @"验收通过";
            }else if (st == 5){
                str = @"整改中";
            }else if (st == 6){
                str = @"整改完成";
            }
            if (isLayer) {
                CGFloat w = [str getWidhtWithFontSize:14];
                self.statusBt.mj_w = w +  8;
                self.statusBt.mj_x = ScreenW - (w+8) - 10;
                self.statusBt.layer.cornerRadius = 3;
                self.statusBt.layer.borderColor = OrangeColor.CGColor;
                self.statusBt.layer.borderWidth = 1.0;
            }else {
                CGFloat w = [str getWidhtWithFontSize:14];
                self.statusBt.mj_w = w;
                self.statusBt.mj_x = ScreenW - (w) - 10;
                self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
                self.statusBt.layer.borderWidth = 1.0;
            }
            self.statusBt.userInteractionEnabled = isLayer;
            [self.statusBt setTitle:str forState:UIControlStateNormal];
            self.editBt.hidden = !isLayer;
            
        }else {
            //用户
            NSInteger st = [model.status intValue];
            self.editBt.hidden = YES;
            BOOL isLayer = NO;
           NSString * str = @"";
           if (st == 1) {
               str = @"施工中";
           }else if (st == 2){
               str = @"验收此阶段";
               isLayer = YES;
           }else if (st == 3){
               str = @"整改中";
           }else if (st == 4){
               str = @"已验收";
           }else if (st == 5){
               str = @"整改中";
           }else if (st == 6){
               str = @"整改完成";
           }else if (st == 7){
               str = @"评价";
               isLayer = YES;
           }
            if (isLayer) {
                CGFloat w = [str getWidhtWithFontSize:14];
                self.statusBt.mj_w = w +  8;
                self.statusBt.mj_x = ScreenW - (w+8) - 10;
                self.statusBt.layer.cornerRadius = 3;
                self.statusBt.layer.borderColor = OrangeColor.CGColor;
                self.statusBt.layer.borderWidth = 1.0;
            }else {
                CGFloat w = [str getWidhtWithFontSize:14];
                self.statusBt.mj_w = w;
                self.statusBt.mj_x = ScreenW - (w) - 10;
                self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
                self.statusBt.layer.borderWidth = 1.0;
            }
            self.statusBt.userInteractionEnabled = isLayer;
            [self.statusBt setTitle:str forState:UIControlStateNormal];
            
        }
        
        
    }
    
    
    
    
}

- (void)setType:(NSInteger)type {
    _type = type;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 8)];
        view.backgroundColor = WhiteColor;
    }
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return self.model.selfStage.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
    return self.model.selfStage[indexPath.section].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJConstructionListNeiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = self.type;
    cell.is_service = self.is_service;
    cell.model = self.model.selfStage[indexPath.section];
    Weak(weakSelf);
    cell.clcikNeiCellBlock = ^(QYZJConstructionListNeiCell *cellNei, NSInteger index, BOOL isClickCell) {
        NSIndexPath * indexPathNei = [weakSelf.tableView indexPathForCell:cellNei];
        if (weakSelf.delegate != nil && [weakSelf.delegate respondsToSelector:@selector(didclickQYZJConstructionListCell:withIndex:isNeiClick:NeiRow:isClickNeiCell:)]) {
            [weakSelf.delegate didclickQYZJConstructionListCell:weakSelf withIndex:index isNeiClick:YES NeiRow:indexPathNei.section isClickNeiCell:NO];
        }
    };
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didclickQYZJConstructionListCell:withIndex:isNeiClick:NeiRow:isClickNeiCell:)]) {
        [self.delegate didclickQYZJConstructionListCell:self withIndex:0 isNeiClick:YES NeiRow:indexPath.section isClickNeiCell:YES];
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


@interface QYZJConstructionListNeiCell()
@property(nonatomic,strong)UILabel *titleLB,*contentLB,*timeLB;
@property(nonatomic,strong)UIButton *statusBt,*editBt;
@end

@implementation QYZJConstructionListNeiCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
if (self) {
          self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenW-40, 20)];
          self.titleLB.numberOfLines = 0;
          [self addSubview:self.titleLB];
          
          self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, ScreenW - 40, 20)];
          self.contentLB.numberOfLines = 0;
          [self addSubview:self.contentLB];
          
          self.timeLB =[[UILabel alloc] initWithFrame:CGRectMake(10, 60, ScreenW - 40, 20)];

          self.timeLB.font = kFont(13);
          self.timeLB.textColor = CharacterBlack112;
          [self addSubview:self.timeLB];
    
          self.editBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 7.5, 25, 25)];
         [self.editBt setImage:[UIImage imageNamed:@"36"] forState:UIControlStateNormal];
         self.editBt.tag = 100;
         [self.editBt addTarget:self action:@selector(editOrStatusAction:) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:self.editBt];
    
    
         self.statusBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 150, 40, 140, 20)];
         self.statusBt.tag = 101;
         [self.statusBt setTitleColor:OrangeColor forState:UIControlStateNormal];
         self.statusBt.titleLabel.font = kFont(13);
         [self addSubview:self.statusBt];
         [self.statusBt addTarget:self action:@selector(editOrStatusAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
return self;
}

- (void)setIs_service:(BOOL)is_service {
    _is_service = is_service;
}

- (void)setType:(NSInteger)type {
    _type = type;
}

- (void)setModel:(QYZJWorkModel *)model {
    _model = model;
    
    CGFloat ww = [model.stageName getWidhtWithFontSize:14 withBlood:YES];

    if (ww > ScreenW - 40 - 30) {
        ww = ScreenW - 40 - 30;
    }
    
    
    self.titleLB.attributedText = [model.stageName getMutableAttributeStringWithFont:14 withBlood:YES lineSpace:3 textColor:[UIColor blackColor]];
    self.titleLB.mj_h = [model.stageName getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ww];
    
    
    
    self.titleLB.mj_w = ww;
    self.editBt.mj_x = ww+15;
    
    if (self.type == 1) {
        self.editBt.hidden = YES;
        self.contentLB.mj_y = 10;
    }
    
    if (self.timeLB.mj_h < 20) {
        self.timeLB.mj_h = 20;
    }else {
        self.contentLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 5;
    }

    if (self.type == 1) {
        self.contentLB.attributedText = [model.con getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack112];
        self.contentLB.mj_h = [model.con getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40];
        if (self.contentLB.mj_h < 20) {
        self.contentLB.mj_h = 20;
        }
    }else {
        self.contentLB.attributedText = [model.des getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack112];
        self.contentLB.mj_h = [model.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40];
        if (self.contentLB.mj_h < 20) {
            self.contentLB.mj_h = 20;
        }
    }
    
    
    self.timeLB.text = model.time;
    self.timeLB.mj_y = CGRectGetMaxY(self.contentLB.frame) + 5;
    model.cellHeight = CGRectGetMaxY(self.timeLB.frame)+5;

    self.statusBt.mj_y = self.timeLB.mj_y;
    
    if (self.type == 1) {
        if (!self.is_service) {
            //服务方
            NSInteger st = [model.status intValue];
            BOOL isLayer = NO;
            NSString * str = @"";
             if (st == 1) {
                  str = @"待确认";
                  isLayer = YES;
              }else if (st == 2){
                  str = @"报修中";
              }else if (st == 3){
                  str = @"待客户验收";
              }else if (st == 4){
                  str = @"验收通过";
              }else if (st == 5){
                  str = @"待整改";
              }else if (st == 6){
                  str = @"整改中";
              }else if (st == 7) {
                  str = @"整改完成";
              }else if (st ==8) {
                  str = @"审核未通过";
              }
           
            
            CGFloat w = [str getWidhtWithFontSize:14];
            self.statusBt.mj_w = w;
            self.statusBt.mj_x = ScreenW -20- (w) - 5;
            self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
            self.statusBt.layer.borderWidth = 1.0;
            self.statusBt.userInteractionEnabled = isLayer;
            [self.statusBt setTitle:str forState:UIControlStateNormal];
            self.editBt.hidden = !isLayer;
            
        }else {
            //用户
            self.editBt.hidden = YES;
            NSInteger st = [model.status intValue];
            BOOL isLayer = NO;
            NSString * str = @"";
            if (st == 1) {
                str = @"待服务方确认";
            }else if (st == 2){
                str = @"报修中";
            }else if (st == 3){
                str = @"待验收";
            }else if (st == 4){
                str = @"验收通过";
            }else if (st == 5){
                str = @"待服务方整改";
            }else if (st == 6){
                str = @"整改中";
            }else if (st == 7){
                str = @"整改完成";
            }else if (st == 8) {
                str = @"审核未通过";
            }
            CGFloat w = [str getWidhtWithFontSize:14];
            self.statusBt.mj_w = w;
            self.statusBt.mj_x = ScreenW- 20 - (w) - 5;
            self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
            self.statusBt.layer.borderWidth = 1.0;
            self.statusBt.userInteractionEnabled = isLayer;
            [self.statusBt setTitle:str forState:UIControlStateNormal];
            
        }
        
    }else {
        
        if (!self.is_service) {
               //服务方
               NSInteger st = [model.status intValue];
               BOOL isLayer = NO;
               NSString * str = @"";
               if (st == 1) {
                   str = @"提交阶段验收";
                   isLayer = YES;
               }else if (st == 2){
                   str = @"验收中";
               }else if (st == 3){
                   str = @"待整改";
               }else if (st == 4){
                   str = @"验收通过";
               }else if (st == 5){
                   str = @"整改中";
               }else if (st == 6){
                   str = @"整改完成";
               }
               if (isLayer) {
                   CGFloat w = [str getWidhtWithFontSize:14];
                   self.statusBt.mj_w = w +  8;
                   self.statusBt.mj_x = ScreenW-20 - (w+8) - 5;
                   self.statusBt.layer.cornerRadius = 3;
                   self.statusBt.layer.borderColor = OrangeColor.CGColor;
                   self.statusBt.layer.borderWidth = 1.0;
               }else {
                   CGFloat w = [str getWidhtWithFontSize:14];
                   self.statusBt.mj_w = w;
                   self.statusBt.mj_x = ScreenW -20- (w) - 5;
                   self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
                   self.statusBt.layer.borderWidth = 1.0;
               }
               self.statusBt.userInteractionEnabled = isLayer;
               [self.statusBt setTitle:str forState:UIControlStateNormal];
               self.editBt.hidden = !isLayer;
               
           }else {
               //用户
               self.editBt.hidden = YES;
               NSInteger st = [model.status intValue];
               if (st == 1 || st == 3 || st == 5) {
                   self.editBt.hidden = NO;
               }else {
                   self.editBt.hidden  = YES;
               }
               
               BOOL isLayer = NO;
               NSString * str = @"";
               if (st == 1) {
                   str = @"施工中";
               }else if (st == 2){
                   str = @"验收此阶段";
                   isLayer = YES;
               }else if (st == 3){
                   str = @"整改中";
               }else if (st == 4){
                   str = @"已验收";
               }else if (st == 5){
                   str = @"整改中";
               }else if (st == 6){
                   str = @"整改完成";
               }else if (st == 7){
                   str = @"评价";
                   isLayer = YES;
               }
               if (isLayer) {
                   CGFloat w = [str getWidhtWithFontSize:14];
                   self.statusBt.mj_w = w +  8;
                   self.statusBt.mj_x = ScreenW - 20 - (w+8) - 10;
                   self.statusBt.layer.cornerRadius = 3;
                   self.statusBt.layer.borderColor = OrangeColor.CGColor;
                   self.statusBt.layer.borderWidth = 1.0;
               }else {
                   CGFloat w = [str getWidhtWithFontSize:14];
                   self.statusBt.mj_w = w;
                   self.statusBt.mj_x = ScreenW- 20 - (w) - 10;
                   self.statusBt.layer.borderColor = [UIColor clearColor].CGColor;
                   self.statusBt.layer.borderWidth = 1.0;
               }
               self.statusBt.userInteractionEnabled = isLayer;
               [self.statusBt setTitle:str forState:UIControlStateNormal];
               
           }
        
    }
    
   
    
    
}

- (void)editOrStatusAction:(UIButton *)button {
    if (self.clcikNeiCellBlock != nil) {
        self.clcikNeiCellBlock(self, button.tag - 100, NO);
    }
    
    
}



@end
