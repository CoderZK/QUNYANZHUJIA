//
//  QYZJMineQuestCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineQuestCell.h"

@interface QYZJMineQuestCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *tieltLB,*rightLB;
@property(nonatomic,strong)UITableView *tableView;


@end

@implementation QYZJMineQuestCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tieltLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];
        self.tieltLB.font = [UIFont systemFontOfSize:14];
        self.tieltLB.numberOfLines = 0;
        
        [self addSubview:self.tieltLB];
        
        self.rightLB = [[UILabel alloc] init];
        self.rightLB.font = kFont(13);
        self.rightLB.textColor = CharacterBlack112;
        self.rightLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.rightLB];
        
        _tableView=[[UITableView alloc] init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_tableView];
        [self.tableView registerClass:[QYZJMineQuestNeiCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return self;
}

- (void)setWaiModel:(QYZJFindModel *)waiModel {
    _waiModel = waiModel;

    if (waiModel.mediaList.count == 0) {
        self.rightLB.text = @"待回复·公开";
        if (!waiModel.isOpen) {
            self.rightLB.text = @"待回复";
        }
    }else {
        self.rightLB.text = [NSString stringWithFormat:@"已答复·公开·%@人旁听",waiModel.sit_on_num];
    }
    
    
    CGFloat rW = [self.rightLB.text getWidhtWithFontSize:13];
    CGFloat lW = [waiModel.title getWidhtWithFontSize:14];
    CGFloat lH = [waiModel.title getHeigtWithFontSize:14 lineSpace:1 width:ScreenW - 30];
    if (lH < 20) {
        lH = 20;
    }
    self.tieltLB.text = waiModel.title;
    
    if (rW + lW <= ScreenW - 40) {
        self.tieltLB.mj_w = lW;
        self.rightLB.frame = CGRectMake(ScreenW - 15 - rW, 15, rW, 20);
    }else {
        self.tieltLB.mj_h = lH;
        self.tieltLB.width = ScreenW - 30;
        self.rightLB.frame = CGRectMake(15, CGRectGetMaxY(self.tieltLB.frame) + 5, ScreenW - 30, 20);
    }

    [self.tableView reloadData];
    
    CGFloat hh = 0;
    for (QYZJFindModel * model  in waiModel.mediaList) {
        CGFloat hnei = [[NSString stringWithFormat:@"回复内容: %@",model.contents] getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 20] + 10;
        hh = hh + hnei;
    }
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.rightLB.frame) + 5, ScreenW, hh);
    


    
    waiModel.cellHeight = CGRectGetMaxY(self.tableView.frame);
    if (waiModel.mediaList.count == 0) {
        
        waiModel.cellHeight = CGRectGetMaxY(self.rightLB.frame) + 15;
    }
    
    NSLog(@"\n--=-=-%f",waiModel.cellHeight);
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiModel.mediaList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.waiModel.mediaList[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineQuestNeiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.waiModel.mediaList[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end


@implementation QYZJMineQuestNeiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titelLB = [[UILabel alloc] init];
        [self addSubview:self.titelLB];
        [self.titelLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(5);
        }];
        
    }
    return self;
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    self.titelLB.attributedText = [[NSString stringWithFormat:@"回复内容: %@",model.contents] getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor80 textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 5)];
    
    model.cellHeight = [[NSString stringWithFormat:@"回复内容: %@",model.contents] getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 20] + 10;
    
     NSLog(@"\n+++++++%f",model.cellHeight);
    
}


@end
