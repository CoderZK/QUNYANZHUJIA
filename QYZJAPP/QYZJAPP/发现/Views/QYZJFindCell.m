//
//  QYZJFindCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFindCell.h"

@interface QYZJFindCell()
@property(nonatomic,strong)UIButton *headBt,*zanBt,*pingLunBt,*jinDaBt,*collectBt,*deleteCollectBt;
@property(nonatomic,strong)UILabel *contentLB,*timeLB,*nameLB;
@property(nonatomic,strong)UIView * ViewOne,*viewTwo,*viewThree,*viewFour;

@end


@implementation QYZJFindCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        self.headBt.layer.cornerRadius = 25;
        self.headBt.clipsToBounds = YES;
        self.headBt.backgroundColor = [UIColor redColor];
        [self addSubview:self.headBt];
        self.headBt.tag = 0;
        [self.headBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.font = kFont(15);
        [self addSubview:self.nameLB];
        [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headBt.mas_right).offset(15);
            make.height.equalTo(@20);
            make.width.equalTo(@150);
            make.centerY.equalTo(self.headBt.mas_centerY);
        }];
        self.jinDaBt = [[UIButton alloc] init];
        [self.jinDaBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.jinDaBt.titleLabel.font = kFont(14);
        [self.jinDaBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
        self.jinDaBt.layer.cornerRadius = 3;
        self.jinDaBt.clipsToBounds = YES;
        [self.jinDaBt setTitle:@"进店" forState:UIControlStateNormal];
        self.jinDaBt.titleLabel.font = kFont(14);
        [self addSubview:self.jinDaBt];
        [self.jinDaBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.headBt.mas_centerY);
            make.height.equalTo(@35);
            make.width.equalTo(@70);
            make.right.equalTo(self).offset(-15);
            
        }];
        self.jinDaBt.tag = 1;
        [self.jinDaBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
        self.contentLB = [[UILabel alloc] init];
        self.contentLB.font = kFont(14);
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.headBt.mas_bottom).offset(15);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@10);
        }];
        
        self.ViewOne = [[UIView alloc] init];
        [self addSubview:self.ViewOne];
        [self.ViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.contentLB.mas_bottom).offset(0);
            make.height.equalTo(@10);
        }];
        
        self.viewTwo = [[UIView alloc] init];
        [self addSubview:self.viewTwo];
        [self.viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.ViewOne.mas_bottom);
            make.height.equalTo(@10);
        }];
        
        self.viewThree = [[UIView alloc] init];
        [self addSubview:self.viewThree];
        [self.viewThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.viewTwo.mas_bottom).offset(10);
            make.height.equalTo(@40);
        }];
        
        
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 20, 0.6)];
        lineV.backgroundColor = lineBackColor;
        [self.viewThree addSubview:lineV];
        
        self.timeLB = [[UILabel alloc] init];
        self.timeLB.font = kFont(14);
        self.timeLB.text = @"42天前";
        self.timeLB.textColor = CharacterBlack112;
        [self.viewThree addSubview:self.timeLB];
        [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.viewThree.mas_left);
            make.centerY.equalTo(self.viewThree.mas_centerY);
            make.width.equalTo(@150);
            make.height.equalTo(@20);
        }];
        
        self.collectBt = [[UIButton alloc] init];
        [self.collectBt setImage:[UIImage imageNamed:@"xing2"] forState:UIControlStateNormal];
        self.collectBt.titleLabel.font = kFont(14);
        [self.viewThree addSubview:self.collectBt];
        [self.collectBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.collectBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.viewThree);
            make.height.equalTo(@35);
            make.width.equalTo(@35);
            make.centerY.equalTo(self.viewThree.mas_centerY);
        }];
        self.collectBt.tag = 2;
        [self.collectBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.deleteCollectBt = [[UIButton alloc] init];
        [self.deleteCollectBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.deleteCollectBt.layer.cornerRadius = 3;
        self.deleteCollectBt.clipsToBounds = YES;
        self.deleteCollectBt.layer.borderColor = OrangeColor.CGColor;
        self.deleteCollectBt.layer.borderWidth = 1;
        [self.deleteCollectBt setTitle:@"取消收藏" forState:UIControlStateNormal];
        self.deleteCollectBt.titleLabel.font = kFont(14);
        [self.viewThree addSubview:self.deleteCollectBt];
//        [self.deleteCollectBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.deleteCollectBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.viewThree);
            make.height.equalTo(@25);
            make.width.equalTo(@80);
            make.centerY.equalTo(self.viewThree.mas_centerY);
        }];
        self.deleteCollectBt.tag = 5;
        self.deleteCollectBt.hidden = YES;
        [self.deleteCollectBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.pingLunBt = [[UIButton alloc] init];
        [self.pingLunBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
        [self.pingLunBt setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        self.pingLunBt.titleLabel.font = kFont(14);
        [self.pingLunBt setTitle:@"666" forState:UIControlStateNormal];
        [self.viewThree addSubview:self.pingLunBt];
        [self.pingLunBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.pingLunBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.collectBt.mas_left).offset(-15);
            make.height.equalTo(@25);
            make.width.equalTo(@75);
            make.centerY.equalTo(self.viewThree.mas_centerY);
        }];
        self.pingLunBt.userInteractionEnabled = NO;
        
        self.pingLunBt.tag = 3;
        [self.pingLunBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
        self.zanBt = [[UIButton alloc] init];
        [self.zanBt setTitleColor:CharacterBlack112 forState:UIControlStateNormal];
        [self.zanBt setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [self.zanBt setTitle:@"2365" forState:UIControlStateNormal];
        [self.zanBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        self.zanBt.titleLabel.font = kFont(14);
        [self.viewThree addSubview:self.zanBt];
        [self.zanBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.pingLunBt.mas_left).offset(-20);
            make.height.equalTo(@35);
            make.width.equalTo(@80);
            make.centerY.equalTo(self.viewThree.mas_centerY);
        }];
        self.zanBt.tag = 4;
        [self.zanBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
        self.viewFour = [[UIView alloc] init];
        [self addSubview:self.viewFour];
        [self.viewFour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.viewThree.mas_bottom).offset(0);
            make.height.equalTo(@0);
        }];
        self.viewFour.clipsToBounds = YES;
        
        for (int i  = 0 ; i < 3; i++) {
            UILabel * lb  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 20, 20)];
            lb.tag = i+1000;
            [self.viewFour addSubview:lb];
            
        }
        
        
        UIView *gayV = [[UIView alloc] init];
        gayV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:gayV];
        [gayV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.viewFour.mas_bottom).offset(0);
            make.height.equalTo(@10);
            make.bottom.equalTo(self);
        }];
        
    }
    return self;
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 1) {
        self.zanBt.hidden = self.pingLunBt.hidden = self.collectBt.hidden = self.headBt.hidden = self.nameLB.hidden = self.jinDaBt.hidden = self.collectBt.hidden =  YES;
        self.deleteCollectBt.hidden = NO;
        [self.contentLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
        }];
        [self.viewThree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
    }else if (type == 2) {
        self.zanBt.hidden = self.pingLunBt.hidden = self.collectBt.hidden = YES;
        self.deleteCollectBt.hidden = NO;
        [self.deleteCollectBt setTitle:@"删除" forState:UIControlStateNormal];
    }
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.headImg]]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"963"]];
    self.nameLB.text = model.nickName;
    self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor]];
    CGFloat contentH =  [model.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 20];
    [self.contentLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(contentH));
    }];
    [self setPicWithideos:model.videos andPictArr:model.pictures];
    [self setGoodsListwitArr:model.goodsList];
    
    if (self.type == 0 && [model.refShopId intValue] > 0) {
        self.jinDaBt.hidden = NO;
    }else {
        self.jinDaBt.hidden = YES;
    }
    
    self.timeLB.text = model.timeNow;
    [self.zanBt setTitle:[NSString stringWithFormat:@"%ld",model.goodsNum] forState:UIControlStateNormal];
    if (model.isGood) {
        [self.zanBt setImage:[UIImage imageNamed:@"17"] forState:UIControlStateNormal];
    }else {
        [self.zanBt setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    }
    [self.pingLunBt setTitle:[NSString stringWithFormat:@"%ld",model.commentNum] forState:UIControlStateNormal];
    if (model.isCollect) {
        [self.collectBt setImage:[UIImage imageNamed:@"xing1"] forState:UIControlStateNormal];
    }else {
        [self.collectBt setImage:[UIImage imageNamed:@"xing2"] forState:UIControlStateNormal];
    }

   
    if (self.type == 2) {
        [self.viewFour mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];

        self.viewFour.clipsToBounds = YES;
        [self.viewThree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
    }else {
         [self setPingLunWithArr:model.commentList];
    }
    
    //    model.cellHeight = CGRectGetMaxY(self.viewFour.frame) + 10;
    
}



//设置评论
- (void)setPingLunWithArr:(NSMutableArray<QYZJFindModel *>*)commentList {
    
    
    
    if (commentList.count == 0) {
        [self.viewFour mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else {
        //        UILabel * lb1 = (UILabel *)[self.viewFour viewWithTag:1000];
        //        UILabel * lb2 = (UILabel *)[self.viewFour viewWithTag:1001];
        //        UILabel * lb3 = (UILabel *)[self.viewFour viewWithTag:1002];
        
        CGFloat th = 10;
        
        for (int i = 0 ; i<3; i++) {
            UILabel * lb1 = (UILabel *)[self.viewFour viewWithTag:1000+i];
            if (i < commentList.count) {
                QYZJFindModel * model = commentList[i];
                if ([model.commentId intValue] > 0) {
                    NSString * str = [NSString stringWithFormat:@"%@回复%@ : %@",model.nickName,model.toNickName,model.commentContent];
                    NSRange range1 = NSMakeRange(0, model.nickName.length);
                    NSRange range2 = NSMakeRange(model.nickName.length + 2, model.toNickName.length);
                    lb1.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor] textColorOne:OrangeColor textColorTwo:OrangeColor nsrangeOne:range1 nsRangeTwo:range2];
                    CGFloat h  = [str getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW-20];
                    lb1.mj_h = h;
                    lb1.mj_y = th;
                    th = th + h + 10;
                }else {
                    NSString * str = [NSString stringWithFormat:@"%@ : %@",model.nickName,model.commentContent];
                    lb1.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor] textColorTwo:OrangeColor nsrange:NSMakeRange(0,model.nickName.length)];
                    CGFloat h  = [str getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW-20];
                    lb1.mj_h = h;
                    lb1.mj_y = th;
                    th = th + h + 10;
                }
                lb1.hidden = NO;
                if (i+1 == commentList.count) {
                    CGFloat fh = CGRectGetMaxY(lb1.frame)+10;
                    [self.viewFour mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(@(fh));
                    }];
                }
            }else {
                lb1.hidden = YES;
            }
        }
        
        //        if (commentList.count == 1) {
        //            lb1.hidden = NO;
        //            lb2.hidden = lb3.hidden = YES;
        //        }else if (commentList.count == 2) {
        //            lb1.hidden = lb2.hidden = NO;
        //            lb3.hidden = YES;
        //        }else {
        //            lb1.hidden =lb2.hidden = lb3.hidden = NO;
        //        }
        
        
    }
    
    
}

//设置商品
- (void)setGoodsListwitArr:(NSMutableArray<QYZJFindModel *>*)goodArr {
    [self.viewTwo.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (goodArr.count == 0) {
        [self.viewTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else {
        CGFloat hh = 70;
        CGFloat space = 10;
        CGFloat totalH = (space + hh) * goodArr.count;
        [self.viewTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(totalH));
        }];
        
        for (int i = 0 ; i < goodArr.count; i++) {
            UIButton * googBt = [[UIButton alloc] initWithFrame:CGRectMake(0, space+(hh+space)*i, ScreenW - 20, hh)];
            googBt.layer.cornerRadius = 5;
            googBt.clipsToBounds = YES;
            googBt.backgroundColor = [UIColor groupTableViewBackgroundColor];
            googBt.tag = i+100;
            [googBt addTarget:self action:@selector(goodBtAction:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
            imgV.layer.cornerRadius = 5;
            imgV.clipsToBounds = YES;
            [imgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:goodArr[i].pic]] placeholderImage:[UIImage imageNamed:@"789"]];
            [googBt addSubview:imgV];
            
            UILabel * titleLB = [[UILabel alloc] initWithFrame:CGRectMake(70 , 10,  ScreenW - 20 -80, 20)];
            titleLB.font = kFont(13);
            titleLB.text =goodArr[i].name;
            [googBt addSubview:titleLB];
            
            UILabel * moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(70 , 10+27,  ScreenW - 20 - 80, 20)];
            moneyLB.font = kFont(13);
            moneyLB.textColor = OrangeColor;
            moneyLB.text =[NSString stringWithFormat:@"￥%0.2f",goodArr[i].price];
            [googBt addSubview:moneyLB];
            
            [self.viewTwo addSubview:googBt];
        }
        
        
        
    }
}

//设置图片
- (void)setPicWithideos:(NSArray *)videArr andPictArr:(NSArray *)pictArr {
    [self.ViewOne.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 40)/3;
    CGFloat hh = ww * 3/4;
    CGFloat space = 10;
    NSMutableArray * arr = @[].mutableCopy;
    if (videArr.count > 0) {
        for (NSString *str in videArr) {
            [arr addObject:[PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:str] size:CGSizeMake(ww, hh)]];
        }
    }
    if (pictArr.count>0) {
        [arr addObjectsFromArray:pictArr];
    }
    if (arr.count==0) {
        [self.ViewOne mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
    }else {
        
        NSInteger number = arr.count / 3 + (arr.count % 3>0?1:0);
        CGFloat imgH = number * (hh + 10);
        [self.ViewOne mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(imgH));
            
        }];
        
        for (int i = 0; i<arr.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ww + 10)* (i%3), space +( hh + space) * (i/3), ww, hh)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.ViewOne addSubview:imageView];
            if (i <videArr.count ) {
                //有视频
                imageView.image = arr[i];
                UIButton * button = [[UIButton alloc]init];
                button.frame = CGRectMake(ww/2 - 25, hh/2-25, 50, 50);
                [button setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
                [imageView addSubview:button];
                button.alpha = 0.8;
                button.userInteractionEnabled = NO;
            }else {
                //无视频
                [imageView sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:arr[i]]]  placeholderImage:[UIImage imageNamed:@"789"]];
                
            }
            
            
        }
        
        
    }
}


//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    
    if (tag <self.model.videos.count ) {
        //有视频
        
        [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.model.videos[tag]] isBenDiPath:NO];
        
    }else {
        //无视频
        NSArray * arr = self.model.pictures;
        NSMutableArray * picArr = @[].mutableCopy;
        for (NSString * str  in arr) {
            [picArr addObject:[NSString stringWithFormat:@"%@",str]];
        }
        [[zkPhotoShowVC alloc] initWithArray:picArr index:tag -self.model.videos.count];
    }
    
    
}

#pragma makr ------------- 点击商店  -------------
- (void)goodBtAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickFindCell:index:)]) {
        [self.delegate didClickFindCell:self index:button.tag];
    }
}

//点击首页cell  
- (void)didClickFindCell:(QYZJFindCell *)cell index:(NSInteger)index {
    
    
    
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



