//
//  QYZJBaoXiuDetailCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJBaoXiuDetailCell.h"

@interface QYZJBaoXiuDetailCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UILabel *titleLB,*timeLB,*contentLB;
@property(nonatomic,strong)UIView *ViewOne,*viewTwo;

@end

@implementation QYZJBaoXiuDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
            
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 120, 20)];
        self.titleLB.font = kFont(14);
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 180, 15, 170,20)];
        self.timeLB.textColor = CharacterBlack112;
        self.timeLB.font = kFont(14);
        [self addSubview:self.timeLB];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, ScreenW - 20, 20)];
        self.contentLB.textColor = CharacterBlack112;
        self.contentLB.numberOfLines = 0;
        self.contentLB.font = kFont(14);
        [self addSubview:self.contentLB];
        
        self.ViewOne = [[UIView alloc] initWithFrame:CGRectMake(10, 20, ScreenW - 20, 20)];
        self.ViewOne.backgroundColor = WhiteColor;
        [self addSubview:self.ViewOne];
        
        self.viewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 40)];
        self.viewTwo.backgroundColor = WhiteColor;
        [self addSubview:self.viewTwo];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60, 0 , 50,40)];
        [button setTitle:@"回复" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        button.tag = 100;
        self.fuHuiBt = button;
        [self.viewTwo addSubview:button];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 50, 0 , 50,40)];
        [button1 setTitle:@"删除" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.titleLabel.font = kFont(14);
        button1.tag = 101;
        self.deleteBt = button1;
        [self.viewTwo addSubview:button1];
        [button1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
         self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 150)];
         self.tableView.dataSource = self;
         self.tableView.delegate = self;
         self.tableView.scrollEnabled = NO;
         [self.tableView registerClass:[QYZJBaoXiuDetailNeiCell class] forCellReuseIdentifier:@"cell"];
         self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
         [self addSubview:self.tableView];
        
        
    }    
    return self;
}

//点击删除或者回复
- (void)clickAction:(UIButton *)button {
    
    
    
    
}


- (void)setIsServer:(BOOL)isServer {
    _isServer = isServer;
    if (isServer) {
        self.deleteBt.hidden = NO;
    }else {
        self.deleteBt.hidden = YES;
    }
}

- (void)setWaiModel:(QYZJFindModel *)waiModel {
    _waiModel = waiModel;
    CGFloat tW = [waiModel.title getWidhtWithFontSize:14];
    CGFloat timeW = [waiModel.time getWidhtWithFontSize:14];
    self.timeLB.mj_w = timeW;
    self.timeLB.mj_x = ScreenW - timeW - 10;
    self.timeLB.text = waiModel.time;
    if (tW + timeW + 30 > ScreenW) {
        
        self.titleLB.mj_w = ScreenW - 20;
        CGFloat th = [waiModel.title getHeigtWithFontSize:14 lineSpace:2 width:ScreenW - 20];
        if (th<20) {
            th = 20;
        }
        self.titleLB.attributedText = [waiModel.title getMutableAttributeStringWithFont:14 lineSpace:2 textColor:[UIColor blackColor]];
        self.titleLB.mj_h = th;
        self.timeLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 5;
    }else {
         self.titleLB.attributedText = [waiModel.title getMutableAttributeStringWithFont:14 lineSpace:2 textColor:[UIColor blackColor]];
        self.timeLB.mj_y = 15;
        self.titleLB.mj_y = 15;
        self.titleLB.mj_w = tW;
        self.titleLB.mj_h  = 20;
    }
    
    self.contentLB.mj_y = CGRectGetMaxY(self.timeLB.frame) + 10;
    self.contentLB.attributedText = [waiModel.content getMutableAttributeStringWithFont:14 lineSpace:2 textColor:CharacterBlack112];
    self.ViewOne.mj_y = CGRectGetMaxY(self.contentLB.frame);
    if (waiModel.picUrl.length > 0) {
          [self setPicWithideos:waiModel.videos andPictArr:[waiModel.picUrl componentsSeparatedByString:@","]];
    }else {
         [self setPicWithideos:waiModel.videos andPictArr:@[]];
    }
  
    CGFloat hh = 0;
    for (QYZJFindModel * model  in waiModel.broadcastReply) {
        CGFloat hnei = [[NSString stringWithFormat:@"回复内容: %@",model.contents] getHeigtWithFontSize:14 lineSpace:2.8 width:ScreenW - 20] + 8;
        hh = hh + hnei;
    }
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.ViewOne.frame) + 5, ScreenW, hh);
    if (waiModel.broadcastReply.count == 0) {
        self.viewTwo.mj_y = CGRectGetMaxY(self.ViewOne.frame);
        
    }else {
        self.viewTwo.mj_y = CGRectGetMaxY(self.tableView.frame);
    }
    
    waiModel.cellHeight = CGRectGetMaxY(self.viewTwo.frame);
    [self.tableView reloadData];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiModel.broadcastReply.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.waiModel.broadcastReply[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJBaoXiuDetailNeiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.waiModel.broadcastReply[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//设置图片
- (void)setPicWithideos:(NSArray *)videArr andPictArr:(NSArray *)pictArr {
    [self.ViewOne.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 40)/3;
    CGFloat hh = ww * 3/4;
    CGFloat space = 10;
    NSMutableArray * arr = @[].mutableCopy;
       
    if (pictArr.count>0) {
        [arr addObjectsFromArray:pictArr];
    }
    if (videArr.count > 0) {
            for (NSString *str in videArr) {
                [arr addObject:[PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] size:CGSizeMake(ww, hh)]];
            }
        }
    if (arr.count==0) {
        self.ViewOne.mj_y = CGRectGetMaxY(self.contentLB.frame);
        self.ViewOne.mj_h = 0;
    }else {
        
        NSInteger number = arr.count / 3 + (arr.count % 3>0?1:0);
        CGFloat imgH = number * (hh + 10);
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
            if (i >=pictArr.count ) {
                //有视频
                imageView.image = arr[i];
                UIButton * button = [[UIButton alloc]init];
                button.frame = CGRectMake(ww/2 - 25, hh/2-25, 50, 50);
                [button setBackgroundImage:[UIImage imageNamed:@"29"] forState:UIControlStateNormal];
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
    
    if (tag >= [self.waiModel.picUrl componentsSeparatedByString:@","].count) {
        //有视频
        [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.waiModel.videos[tag - [self.waiModel.picUrl componentsSeparatedByString:@","].count]] isBenDiPath:NO];
        
    }else {
        //无视频
        NSArray * arr = [self.waiModel.picUrl componentsSeparatedByString:@","];
        NSMutableArray * picArr = @[].mutableCopy;
        for (NSString * str  in arr) {
            [picArr addObject:[NSString stringWithFormat:@"%@",[QYZJURLDefineTool getImgURLWithStr:str]]];
        }
        [[zkPhotoShowVC alloc] initWithArray:picArr index:tag];
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




//内部的cell
@implementation QYZJBaoXiuDetailNeiCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, ScreenW - 20, 1)];
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        
    }
    return self;
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    
    self.titleLB.attributedText = [[NSString stringWithFormat:@"%@: %@",model.nickName,model.content] getMutableAttributeStringWithFont:14 lineSpace:2.8 textColor:CharacterBlack112 textColorTwo:OrangeColor nsrange:NSMakeRange(0, model.nickName.length + 1)];
    CGFloat hh = [[NSString stringWithFormat:@"%@: %@",model.nickName,model.content] getHeigtWithIsBlodFontSize:14 lineSpace:3 width:ScreenW - 20];
    self.titleLB.mj_h = hh;
    model.cellHeight = hh+8;
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
