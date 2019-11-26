//
//  QYZJConstructionListCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJConstructionListCell.h"

@interface QYZJConstructionListCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *titleLB,*contentLB,*timeLB,*moneyLB,*statusLB;
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
        
        self.moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 150, 10, 140, 20)];
        self.moneyLB.font = [UIFont boldSystemFontOfSize:14];
        self.moneyLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.moneyLB];
        
        self.statusLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 150, 40, 140, 20)];
        self.statusLB.textAlignment = NSTextAlignmentRight;
        self.statusLB.textColor = OrangeColor;
        self.statusLB.font = kFont(14);
        self.statusLB.text = @"已验收";
        [self addSubview:self.statusLB];
        
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

- (void)setModel:(QYZJWorkModel *)model {
    _model = model;
    
    self.titleLB.attributedText = [model.stageName getMutableAttributeStringWithFont:14 withBlood:YES lineSpace:3 textColor:[UIColor blackColor]];
    self.titleLB.mj_h = [model.stageName getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW - 20 - 150];
    if (self.timeLB.mj_h < 20) {
        self.timeLB.mj_h = 20;
    }
    
    self.moneyLB.text = [NSString stringWithFormat:@"￥%0.0f",model.price];
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
            CGFloat contentH = [modelNei.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40] < 20?20:[modelNei.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40];
            tvH = tvH + (titelH + contentH + 20 + 20);
//            tvH = tvH + modelNei.cellHeight;
        }
        self.tableView.mj_h = tvH;
        model.cellHeight = CGRectGetMaxY(self.timeLB.frame) + 10 + tvH;
    }
   
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.selfStage.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
    return self.model.selfStage[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJConstructionListNeiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.model.selfStage[indexPath.row];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    
}
return self;
}

- (void)setModel:(QYZJWorkModel *)model {
    _model = model;
    self.titleLB.attributedText = [model.stageName getMutableAttributeStringWithFont:14 withBlood:YES lineSpace:3 textColor:[UIColor blackColor]];
    self.titleLB.mj_h = [model.stageName getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW - 40];
    if (self.timeLB.mj_h < 20) {
        self.timeLB.mj_h = 20;
    }
    
    self.contentLB.attributedText = [model.des getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack112];
    self.contentLB.mj_h = [model.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-40];
    if (self.contentLB.mj_h < 20) {
        self.contentLB.mj_h = 20;
    }
    self.timeLB.text = model.time;
    self.contentLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 5;
    self.timeLB.mj_y = CGRectGetMaxY(self.contentLB.frame) + 5;

    model.cellHeight = CGRectGetMaxY(self.timeLB.frame)+5;

    
    
    
}

@end
