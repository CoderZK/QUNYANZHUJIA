//
//  QYZJMineQuestCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineQuestCell.h"

@interface QYZJMineQuestCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *tieltLB,*rightLB,*LB2;
@property(nonatomic,strong)UITableView *tableView;



@end

@implementation QYZJMineQuestCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tieltLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, ScreenW - 20, 20)];
        self.tieltLB.font = [UIFont boldSystemFontOfSize:15];
        self.tieltLB.numberOfLines = 0;
        
        [self addSubview:self.tieltLB];
        
        self.rightLB = [[UILabel alloc] init];
        self.rightLB.font = kFont(13);
        self.rightLB.textColor = CharacterBlack112;
        self.rightLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.rightLB];
        
        _tableView=[[UITableView alloc] init];
        //        _tableView.backgroundColor = [UIColor greenColor];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.userInteractionEnabled = NO;
        [self addSubview:_tableView];
        [self.tableView registerClass:[QYZJMineQuestNeiCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        self.LB2 = [[UILabel alloc] init];
        self.LB2.textColor= CharacterBlack112;
        self.LB2.text = @"回复答人: ";
        self.LB2.font = kFont(13);
        [self addSubview:self.LB2];
        [self.LB2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightLB.mas_bottom).offset(15);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@70);
            make.height.equalTo(@20);
        }];
        
    }
    return self;
}

- (void)setIsServer:(BOOL)isServer {
    _isServer = isServer;
}

- (void)setWaiModel:(QYZJFindModel *)waiModel {
    _waiModel = waiModel;
    
    CGFloat ww = ScreenW - 110;
    if (self.isServer) {
        ScreenW - 20;
    }
    NSString * str = @"";
    if ([waiModel.status intValue]== 1) {
        str = @"待回复";
    }else if ([waiModel.status intValue]== 2) {
        str = @"已回复";
    } else {
        str = @"待支付";
    }
    
    if (waiModel.is_open ) {
       str = [NSString stringWithFormat:@"%@·%@·%ld人旁听",str,@"公开",waiModel.sit_on_num];
    }else {
         str = [NSString stringWithFormat:@"%@·%@·%ld人旁听",str,@"不公开",waiModel.sit_on_num];
        
    }
    self.rightLB.text = str;
    CGFloat rW = [self.rightLB.text getWidhtWithFontSize:13];
    CGFloat lW = [waiModel.title getWidhtWithFontSize:16];
    CGFloat lH = [waiModel.title getHeigtWithIsBlodFontSize:15 lineSpace:0 width:ww];
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
    self.tableView.mj_w = ww;
    [self.tableView reloadData];
    
    if (self.isServer) {
        CGFloat hh = 0;
        for (QYZJFindModel * model  in waiModel.mediaList) {
            CGFloat hnei = [[NSString stringWithFormat:@"回复内容: %@",model.contents] getHeigtWithFontSize:14 lineSpace:3 width:ww] + 10;
            if (model.media_url.length > 0) {
                hnei = hnei + 30;
            }
            if (model.contents.length == 0) {
                hnei = 35;
            }
            hh = hh + hnei;
        }
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.rightLB.frame) + 5, ScreenW, hh);
        self.LB2.hidden = YES;
        if (waiModel.mediaList.count == 0) {
            waiModel.cellHeight = CGRectGetMaxY(self.rightLB.frame) + 15;
        }
    }else {
        
        CGFloat hh = 0;
        
        for (QYZJFindModel * anModel in waiModel.answerList) {
            
            for (QYZJFindModel * model  in anModel.mediaList) {
                CGFloat hnei = [[NSString stringWithFormat:@"回复内容: %@",model.contents] getHeigtWithFontSize:14 lineSpace:3 width:ww] + 10;
                if (model.media_url.length > 0) {
                    hnei = hnei + 30;
                }
                if (model.contents.length == 0) {
                    hnei = 35;
                }
                hh = hh + hnei ;
            }
            
        }
        hh = hh + waiModel.answerList.count * 40;
        self.tableView.frame = CGRectMake(90, CGRectGetMaxY(self.rightLB.frame) + 5, ScreenW - 90, hh);
        if (waiModel.answerList.count == 0) {
            waiModel.cellHeight = CGRectGetMaxY(self.rightLB.frame) + 15;
        }
        self.LB2.hidden = NO;
        if (waiModel.answerList.count == 0) {
            self.LB2.hidden = YES;
        }
    }
    waiModel.cellHeight = CGRectGetMaxY(self.tableView.frame) + 15;
    
    NSLog(@"\n ---titleLBHeight ---%@",NSStringFromCGRect(self.tieltLB.frame));
    NSLog(@"\n--=-=-%f",waiModel.cellHeight);
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isServer) {
        return 1;
    }else {
        return self.waiModel.answerList.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isServer) {
        return self.waiModel.mediaList.count;
    }else {
        return self.waiModel.answerList[section].mediaList.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.isServer) {
        return 0.01;
    }else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.isServer) {
        return nil;
    }
    
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 100, 40)];
        
        UIButton *  headBt = [[UIButton alloc] init];
        [view addSubview:headBt];
        [headBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@35);
            make.left.equalTo(view).offset(10);
            make.centerY.equalTo(view.mas_centerY);
        }];
        headBt.layer.cornerRadius = 17.5;
        headBt.clipsToBounds = YES;
        headBt.tag = 100;
        
        UILabel * roleNameLB = [[UILabel alloc] init];
        roleNameLB.layer.cornerRadius = 3;
        roleNameLB.layer.borderColor = OrangeColor.CGColor;
        roleNameLB.layer.borderWidth = 1;
        roleNameLB.textColor = OrangeColor;
        roleNameLB.font = kFont(13);
        roleNameLB.textAlignment = NSTextAlignmentCenter;
        [view addSubview:roleNameLB];
        [roleNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.width.equalTo(@70);
            make.height.equalTo(@20);
            make.right.equalTo(view.mas_right).offset(-15);
        }];
        roleNameLB.tag = 101;
        
        UILabel * nameLB = [[UILabel alloc] init];
        nameLB.font = [UIFont boldSystemFontOfSize:14];
        [view addSubview:nameLB];
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.height.equalTo(@20);
            make.left.equalTo(headBt.mas_right).offset(10);
            make.right.equalTo(roleNameLB.mas_left).offset(-10);
        }];
        nameLB.tag = 102;
        
    }
    QYZJFindModel * model = self.waiModel.answerList[section];
    UIButton * headBt = (UIButton *)[view viewWithTag:100];
    UILabel *nameLB = (UILabel *)[view viewWithTag:102];
    UILabel * roleLB = (UILabel *)[view viewWithTag:101];
    [headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.a_head_img]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"963"] options:SDWebImageRetryFailed];
    if (model.a_role.length > 0) {
        roleLB.text = [[model.a_role componentsSeparatedByString:@","] firstObject];
        CGFloat ww = [roleLB.text getWidhtWithFontSize:13] + 10;
        [roleLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(ww));
        }];
    }else {
        [roleLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(0));
        }];
        roleLB.hidden = YES;
    }
    nameLB.text = model.a_nick_name;
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isServer) {
        return self.waiModel.mediaList[indexPath.row].cellHeight;
    }else {
        return self.waiModel.answerList[indexPath.section].mediaList[indexPath.row].cellHeight;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineQuestNeiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.isServer = self.isServer;
    if (self.isServer) {
        cell.model = self.waiModel.mediaList[indexPath.row];
    }else {
        cell.model = self.waiModel.answerList[indexPath.section].mediaList[indexPath.row];
    }
    NSLog(@"\n titleLBFrme %@",NSStringFromCGRect(cell.titelLB.frame));
    
    cell.clipsToBounds = YES;
    cell.listBt.tag = indexPath.row;
    [cell.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.cellClickBlock != nil) {
        self.cellClickBlock(self);
    }
    
    
}

- (void)listAction:(UIButton *)button {
    
    QYZJMineQuestNeiCell * cell = (QYZJMineQuestNeiCell *)button.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (self.isServer) {
        QYZJFindModel * model = self.waiModel.mediaList[button.tag];
        if (model.media_url.length > 0) {
            [[PublicFuntionTool shareTool] palyMp3WithNSSting:model.media_url isLocality:NO];
            model.isPlaying = YES;
            [self.tableView reloadData];
            Weak(weakSelf);
            [PublicFuntionTool shareTool].findPlayBlock = ^{
                model.isPlaying = NO;
                [weakSelf.tableView reloadData];
            };
        }
    }else {
        
        QYZJFindModel * model = self.waiModel.answerList[indexPath.section].mediaList[indexPath.row];
        if (model.media_url.length > 0) {
            [[PublicFuntionTool shareTool] palyMp3WithNSSting:model.media_url isLocality:NO];
            model.isPlaying = YES;
            [self.tableView reloadData];
            Weak(weakSelf);
            [PublicFuntionTool shareTool].findPlayBlock = ^{
                model.isPlaying = NO;
                [weakSelf.tableView reloadData];
            };
        }
    }
}


@end


@implementation QYZJMineQuestNeiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
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
        
        
        self.titelLB = [[UILabel alloc] init];
        self.titelLB.numberOfLines = 0;
        //        self.titelLB.backgroundColor =[UIColor redColor];
        [self addSubview:self.titelLB];
        [self.titelLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.listBt.mas_bottom).offset(5);
            make.bottom.equalTo(self).offset(-5);
        }];
        
    }
    return self;
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    
    CGFloat ww = ScreenW - 110;
    if (self.isServer) {
        ScreenW - 20;
    }
    
    self.titelLB.attributedText = [[NSString stringWithFormat:@"回复内容: %@",model.contents] getMutableAttributeStringWithFont:14 lineSpace:2.8 textColor:CharacterColor80 textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 5)];
    
    if (model.isPlaying) {
        [self.listBt setTitle:@"播放中..." forState:UIControlStateNormal];
    }else {
        [self.listBt setTitle:@"回复语音" forState:UIControlStateNormal];
    }
    
    if (model.media_url.length > 0) {
        self.listBt.hidden = NO;
        
        CGFloat conH =  [[NSString stringWithFormat:@"回复内容: %@",model.contents] getHeigtWithFontSize:14 lineSpace:3 width:ww];
        [self.titelLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.listBt.mas_bottom).offset(5);
            //            make.height.equalTo(@(conH));
        }];
        NSLog(@"\n111111====%@---%f",model.contents,conH);
        
        model.cellHeight = conH + 15 + 25;
        if (model.contents.length == 0) {
            model.cellHeight = 10+25;
            self.titelLB.hidden = YES;
        }else {
            self.titelLB.hidden = NO;
        }
    }else {
        self.listBt.hidden = YES;
        CGFloat conH =  [[NSString stringWithFormat:@"回复内容: %@",model.contents] getHeigtWithFontSize:14 lineSpace:3 width:ww] ;
        [self.titelLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            //             make.height.equalTo(@(conH));
        }];
        model.cellHeight = conH + 10;
        
        NSLog(@"\n111111====%@---%f",model.contents,conH);
        
    }
    NSLog(@"\n+++++++%f",model.cellHeight);
    
}


@end
