//
//  QYZJMineCaiPanCell.m
//  QYZJAPP
//
//  Created by zk on 2019/12/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineCaiPanCell.h"

@interface QYZJMineCaiPanCell()
@property(nonatomic,strong)UILabel *titleLB,*contentLB,*phoneLB;
@property(nonatomic,strong)UIButton *listBt,*playBt;
@property(nonatomic,strong)UIImageView *imgVpic,*imgVideo;
@end




@implementation QYZJMineCaiPanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, ScreenW-20, 10)];
        self.titleLB.numberOfLines = 0;
        self.titleLB.font = kFont(15);
        [self addSubview:self.titleLB];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, ScreenW-20, 10)];
        self.contentLB.numberOfLines = 0;
        self.contentLB.font = kFont(13);
        self.contentLB.textColor = CharacterBlack112;
        [self addSubview:self.contentLB];
        
        self.phoneLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, ScreenW-20, 16)];
        self.phoneLB.numberOfLines = 0;
        self.phoneLB.font = kFont(13);
        self.phoneLB.textColor = CharacterBlack112;
        [self addSubview:self.phoneLB];
        
        
        self.listBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 95, 200, 25)];
        [self.listBt setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
        [self.listBt setImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
        [self.listBt setTitle:@"32" forState:UIControlStateNormal];
        self.listBt.titleLabel.font = kFont(14);
        self.listBt.layer.cornerRadius = 12.5;
        self.listBt.clipsToBounds = YES;
        self.listBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.listBt setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        [self.listBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0,  0)];
        [self.listBt addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.listBt];
        
        
        self.imgVpic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, ScreenW- 120, (ScreenW- 120) * 4/3)];
        [self addSubview:self.imgVpic];
//        self.imgVpic.contentMode = UIViewContentModeScaleAspectFit;
        self.imgVpic.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
        tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
        [self.imgVpic addGestureRecognizer:tap];
        
        self.imgVideo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, ScreenW- 100, (ScreenW- 120) * 3/4)];
        [self addSubview:self.imgVideo];
        self.imgVideo.userInteractionEnabled = YES;
        self.imgVideo.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIButton * button = [[UIButton alloc]init];
        button.frame = CGRectMake(self.imgVideo.frame.size.width/2 - 25, self.imgVideo.frame.size.height/2 -25, 50, 50);
        [button setBackgroundImage:[UIImage imageNamed:@"29"] forState:UIControlStateNormal];
        [self.imgVideo addSubview:button];
        button.alpha = 0.8;
        [button addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        button.userInteractionEnabled = YES;
        
        
    }
    return self;
}

- (void)setModel:(QYZJFindModel *)model {
    _model = model;
    
    CGFloat hh = 0;
    
    self.titleLB.attributedText = [model.title  getMutableAttributeStringWithFont:15 lineSpace:3 textColor:[UIColor blackColor]];
    self.titleLB.mj_h = [model.title getHeigtWithFontSize:15 lineSpace:3 width:ScreenW- 20];
    self.contentLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 10;
    self.contentLB.attributedText = [model.context getMutableAttributeStringWithFont:13 lineSpace:2 textColor:CharacterBlack112];
    self.contentLB.mj_h = [model.context getHeigtWithFontSize:13 lineSpace:2 width:ScreenW-20];
    hh = CGRectGetMaxY(self.contentLB.frame) + 10;
    
    self.phoneLB.mj_y = hh;
    if (model.telphone.length == 0) {
        self.phoneLB.hidden = YES;
    }else {
        self.phoneLB.hidden = NO;
        hh = hh+26;
    }

    self.listBt.mj_y = hh;
    if (model.mediaUrl.length == 0) {
        self.listBt.hidden = YES;
    }else {
        self.listBt.hidden = NO;
        [self.listBt setTitle:@"点击播放" forState:UIControlStateNormal];
        hh = hh + 35;
    }
    self.imgVpic.mj_y = hh;
    if (model.picUrl.length == 0) {
        self.imgVpic.hidden = YES;
    }else {
        self.imgVpic.hidden = NO;
        hh = hh+(ScreenW- 120) * 4/3 + 10;
        [self.imgVpic sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.picUrl]] placeholderImage:[UIImage imageNamed:@"789"]];
    }
    self.imgVideo.mj_y = hh;
    if (model.videoUrl.length == 0) {
        self.imgVideo.hidden = YES;
    }else {
        hh = hh+ (ScreenW- 120) * 3/4 + 20;
        self.imgVideo.hidden = NO;
//        self.imgVideo.image = [PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:[QYZJURLDefineTool getVideoURLWithStr:model.videoUrl]] size:CGSizeMake((ScreenW- 100) , (ScreenW- 120) * 3/4)];
        if (model.videoImg == nil) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                // 这里放异步执行任务代码
              model.videoImg =  [PublicFuntionTool firstFrameWithVideoURL:[NSURL URLWithString:[QYZJURLDefineTool getVideoURLWithStr:model.videoUrl]] size:CGSizeMake((ScreenW- 100) , (ScreenW- 120) * 3/4)];
            });
        }else {
            self.imgVideo.image = model.videoImg;
        }
        
        
    }
    model.cellHeight = hh;
    
}

//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    [[zkPhotoShowVC alloc] initWithArray:@[[QYZJURLDefineTool getImgURLWithStr:self.model.picUrl]] index:0];
}

- (void)playAction:(UIButton *)button {
    [PublicFuntionTool presentVideoVCWithNSString:[QYZJURLDefineTool getVideoURLWithStr:self.model.videoUrl] isBenDiPath:NO];
}

- (void)listAction:(UIButton *)button {
     [button setTitle:@"正在播放..." forState:UIControlStateNormal];
    [[PublicFuntionTool shareTool] palyMp3WithNSSting:self.model.mediaUrl isLocality:NO];
    [PublicFuntionTool shareTool].findPlayBlock = ^{
        [button setTitle:@"点击播放" forState:UIControlStateNormal];
    };
    
    
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
