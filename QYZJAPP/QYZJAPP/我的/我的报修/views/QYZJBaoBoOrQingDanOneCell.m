//
//  QYZJBaoBoOrQingDanOneCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJBaoBoOrQingDanOneCell.h"

@interface QYZJBaoBoOrQingDanOneCell()
@property(nonatomic,strong)UIButton *headBt,*zanBt,*collectBt;
@property(nonatomic,strong)UILabel *contentLB,*timeLB,*nameLB,*moneyLB,*statusLB,*timeTwoLB;
@property(nonatomic,strong)UIView * ViewOne,*viewTwo,*gayV;
@end


@implementation QYZJBaoBoOrQingDanOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.font = [UIFont boldSystemFontOfSize:15];
        
        [self addSubview:self.nameLB];
        self.nameLB.frame = CGRectMake(10, 30, ScreenW - 20 -150, 20);
        
        self.moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 150, 30, 140, 20)];
        self.moneyLB.textAlignment = NSTextAlignmentRight;
        self.moneyLB.font = kFont(14);
        [self addSubview:self.moneyLB];
        
        self.contentLB = [[UILabel alloc] init];
        self.contentLB.font = kFont(14);
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        self.contentLB.frame = CGRectMake(10,60, ScreenW - 20, 20);
        
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 180, 20)];
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterBlack112;
        [self addSubview:self.timeLB];
        
        self.statusLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 160 , 90, 150, 20)];
        self.statusLB.textColor = OrangeColor;
        self.statusLB.textAlignment = NSTextAlignmentRight;
        self.statusLB.font = kFont(13);
        [self addSubview:self.statusLB];
        
        self.timeTwoLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 180, 20)];
        self.timeTwoLB.font = kFont(14);
        self.timeTwoLB.textColor = CharacterBlack112;
        [self addSubview:self.timeTwoLB];
        
        self.ViewOne = [[UIView alloc] init];
        [self addSubview:self.ViewOne];
        self.ViewOne.frame = CGRectMake(10, 140, ScreenW - 20, 10);
        
        self.viewTwo = [[UIView alloc] init];
        [self addSubview:self.viewTwo];
        self.viewTwo.frame = CGRectMake(10, 110, ScreenW - 20, 10);


        
        
    }
    return self;
}

- (void)setIs_service:(BOOL)is_service {
    _is_service = is_service;
}


- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    
    self.nameLB.text = model.nickName;
    self.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",model.price];
    
    self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:[UIColor blackColor]];
    CGFloat contentH =  [model.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 20];
    self.contentLB.mj_h = contentH;
    self.timeLB.text = model.time;
    
   
    
    if  (self.type == 1) {
        self.timeTwoLB.textColor = CharacterBlack112;
        if (model.isRepair) {
               self.timeTwoLB.text = [NSString stringWithFormat:@"保修时间: %@",@"正在保修中"];
           }else {
               if (model.isOverRepairTime) {
                   self.timeTwoLB.text = [NSString stringWithFormat:@"保修时间: %0.1f年",model.year];
               }else {
                   self.timeTwoLB.text = [NSString stringWithFormat:@"保修时间: %0.1f年",model.year];
               }
               if (model.year == 0 ) {
                   self.timeTwoLB.text = @"保修时间: 无";
               }
           }
        self.moneyLB.hidden = YES;
    }else {
        self.timeTwoLB.textColor = [UIColor blackColor];
        self.timeTwoLB.text = [NSString stringWithFormat:@"交付订单:%@",model.turnoverTitle];
        self.moneyLB.hidden = NO;
        
    }
    
    if (self.type == 1) {
        if (!model.is_service) {
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
            
            self.statusLB.text = str;
            
        }else {
            //用户
            NSInteger st = [model.status intValue];
            NSString * str = @"";
            BOOL isLayer = NO;
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
           
            self.statusLB.text = str;
        }
    }else {
        
        if (!model.is_service) {
            //服务方
            NSInteger st = [model.status intValue];
            BOOL isLayer = NO;
            NSString * str = @"";
            if (st == 1) {
                str = @"待确认";
                isLayer = YES;
            }else if (st == 2){
                str = @"保修中";
            }else if (st == 3){
                str = @"待验收";
            }else if (st == 4){
                str = @"验收通过";
            }else if (st == 5){
                str = @"待整改";
            }else if (st == 6){
                str = @"整改中";
            }else if (st == 7){
                str = @"整改完成";
            }
            
            self.statusLB.text = str;
            
        }else {
            //用户
            NSInteger st = [model.status intValue];
            NSString * str = @"";
            BOOL isLayer = NO;
            if (st == 1) {
                str = @"待服务方确认";
            }else if (st == 2){
                str = @"保修中";
                isLayer = YES;
            }else if (st == 3){
                str = @"待验收";
            }else if (st == 4){
                str = @"验收通过";
            }else if (st == 5){
                str = @"待整改";
            }else if (st == 6){
                str = @"整改中";
            }else if (st == 7){
                str = @"整改完成";
                isLayer = YES;
            }
           
            self.statusLB.text = str;
        }
        
        
    }
    
    
    self.timeLB.mj_y = CGRectGetMaxY(self.contentLB.frame) + 5;
    self.statusLB.mj_y = CGRectGetMaxY(self.contentLB.frame) + 5;
    self.timeTwoLB.mj_y = CGRectGetMaxY(self.timeLB.frame) +5;
    [self setPicWithideos:nil andPictArr:model.pictures];
    [self setVideosWithArr:model.videos];
    model.cellHeight = CGRectGetMaxY(self.viewTwo.frame) + 10;
}


- (void)setType:(NSInteger)type {
    _type = type;
}



//设置图片
- (void)setPicWithideos:(NSArray *)videArr andPictArr:(NSArray *)pictArr {
    [self.ViewOne.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 40)/3;
    CGFloat hh = ww * 3/4;
    CGFloat space = 10;
    NSMutableArray * arr = @[].mutableCopy;
    //    if (videArr.count > 0) {
    //        for (NSString *str in videArr) {
    //            [arr addObject:[PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:str] size:CGSizeMake(ww, hh)]];
    //        }
    //    }
    if (pictArr.count>0) {
        [arr addObjectsFromArray:pictArr];
    }
    if (arr.count==0) {
        self.ViewOne.mj_y = CGRectGetMaxY(self.timeTwoLB.frame);
        self.ViewOne.mj_h = 0;
    }else {
        
        NSInteger number = arr.count / 3 + (arr.count % 3>0?1:0);
        CGFloat imgH = number * (hh + 10);
        self.ViewOne.mj_y = CGRectGetMaxY(self.timeTwoLB.frame) + 10;
        self.ViewOne.mj_h = imgH;
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
            //无视频
            [imageView sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:arr[i]]]  placeholderImage:[UIImage imageNamed:@"789"]];
        }
        
        
    }
}

//设置视频
- (void)setVideosWithArr:(NSArray *)videArr {
    [self.viewTwo.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 20);
    CGFloat hh = ww * 9/16;
    CGFloat space = 10;
    NSMutableArray * arr = @[].mutableCopy;
    if (videArr.count > 0) {
        for (NSString *str in videArr) {
            [arr addObject:[PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] size:CGSizeMake(ww, hh)]];
        }
    }
    
    if (arr.count==0) {
        self.viewTwo.mj_y = CGRectGetMaxY(self.ViewOne.frame);
        self.viewTwo.mj_h = 0;
    }else {
        
        NSInteger number = arr.count / 3 + (arr.count % 3>0?1:0);
        CGFloat imgH = number * (hh + 10);
        self.viewTwo.mj_y = CGRectGetMaxY(self.ViewOne.frame) + 10;
        self.viewTwo.mj_h = imgH;
        
        for (int i = 0; i<arr.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ww + 10)* (i%3), space +( hh + space) * (i/3), ww, hh)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVideosInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.viewTwo addSubview:imageView];
            //有视频
            imageView.image = arr[i];
            UIButton * button = [[UIButton alloc]init];
            button.frame = CGRectMake(ww/2 - 25, hh/2-25, 50, 50);
            [button setBackgroundImage:[UIImage imageNamed:@"29"] forState:UIControlStateNormal];
            [imageView addSubview:button];
            button.alpha = 0.8;
            button.userInteractionEnabled = NO;
            
        }
        
        
        
        
    }
    
    
}




//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    //无视频
    NSArray * arr = self.model.pictures;
    NSMutableArray * picArr = @[].mutableCopy;
    for (NSString * str  in arr) {
        [picArr addObject:[NSString stringWithFormat:@"%@",[QYZJURLDefineTool getImgURLWithStr:str]]];
    }
    [[zkPhotoShowVC alloc] initWithArray:picArr index:tag];
}
//点击视频
- (void)tapVideosInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    //视频
    [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.model.article.videos[tag]] isBenDiPath:NO];
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
