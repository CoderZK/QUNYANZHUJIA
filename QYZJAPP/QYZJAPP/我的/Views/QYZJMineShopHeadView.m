//
//  QYZJMineShopHeadView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineShopHeadView.h"

@interface QYZJMineShopHeadView()
@property(nonatomic,strong)UIButton *backBt,*shareBt,*headBt,*editBt,*leftBt,*centerBt,*rightBt;
@property(nonatomic,strong)UILabel *titelLB;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIView *gayV,*redV,*lineV,*whiteOneV,*whiteTwoView;

@end

@implementation QYZJMineShopHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {

        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100+sstatusHeight)];
        self.imgV.backgroundColor = [UIColor greenColor];
        [self addSubview:self.imgV];
        
        self.backBt = [[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2, 40, 40)];
        self.backBt.tag = 0;
        [self.backBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.backBt setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self addSubview:self.backBt];
        
        
        self.titelLB = [[UILabel alloc] initWithFrame:CGRectMake(100, sstatusHeight +2, ScreenW - 200,  40)];
        self.titelLB.textColor = WhiteColor;
        self.titelLB.font = kFont(18);
        self.titelLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titelLB];
        
        self.shareBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, sstatusHeight + 2, 40, 40)];
        self.shareBt.tag = 1;
        [self.shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.shareBt setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self addSubview:self.shareBt];
        
        self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgV.frame), ScreenW, 40)];
        self.whiteOneV.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteOneV];
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.imgV.frame) - 35 , 70, 70)];
        self.headBt.layer.cornerRadius = 35;
        self.headBt.clipsToBounds = YES;
        self.headBt.tag = 2;
        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headBt];
        self.headBt.backgroundColor = [UIColor redColor];
        
        self.editBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 75, 10, 60, 20)];
        self.editBt.layer.cornerRadius = 3;
        self.clipsToBounds  = YES;
        self.editBt.layer.borderColor = OrangeColor.CGColor;
        self.editBt.layer.borderWidth = 1.0f;
        [self.editBt setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.editBt.titleLabel.font = kFont(14);
        [self.whiteOneV addSubview:self.editBt];
        self.editBt.tag = 3;
        [self.editBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.gayV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteOneV.frame), ScreenW, 10)];
        self.gayV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.gayV];
        

        self.whiteTwoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.gayV.frame), ScreenW, 50)];
        self.whiteTwoView.backgroundColor  = WhiteColor;
        [self addSubview:self.whiteTwoView];
        
        self.lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 49.4, ScreenW, 0.6)];
        self.lineV.backgroundColor = lineBackColor;
        [self.whiteTwoView addSubview:self.lineV];
        
        self.redV = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 50, 2)];
        self.redV.backgroundColor = OrangeColor;
        [self.whiteTwoView addSubview:self.redV];
        
        NSArray * arr = @[@"已上架",@"待审核",@"已下架"];
        CGFloat w = 80;
        CGFloat space = (ScreenW - 3*w)/5;
        for (int i = 0 ; i<arr.count; i++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(space + (space + w)*i, 5, w, 38)];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = kFont(14);
            
            button.tag = i+4;
            if (i == 0) {
                self.redV.centerX = button.centerX;
            }
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.whiteTwoView addSubview:button];

        }

        
        self.headHeight = CGRectGetMaxY(self.whiteTwoView.frame);
        
    }
    return self;
}

- (void)clickAction:(UIButton *)button {
    
    if (button.tag >3) {
        self.redV.centerX = button.centerX;
    }
    
    if (self.clickShopHeadBlock != nil) {
        self.clickShopHeadBlock(button.tag);
    }
}

- (void)setDataModel:(QYZJUserModel *)dataModel {
    _dataModel = dataModel;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:dataModel.pic]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"369"]];
    self.titelLB.text = dataModel.name;
    
}

@end
