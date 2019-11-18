//
//  QYZJZengZhiFWCell.m
//  QYZJAPP
//
//  Created by zk on 2019/11/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJZengZhiFWCell.h"
@interface QYZJZengZhiFWCell()
@property(nonatomic,strong)UIView *whiteV;
@end

@implementation QYZJZengZhiFWCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.whiteV = [[UIView alloc] init];
        self.whiteV.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteV];
        
        [self.whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);;
        }];
    
        
        
    }
    return self;
}

- (void)setDataArray:(NSArray<QYZJMoneyModel *> *)dataArray {
     _dataArray = dataArray;
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat space = 15;
    CGFloat ww = (ScreenW - 4*space)/3;
    CGFloat hh = ww*4/3;
    
    for (int i = 0 ; i<dataArray.count; i++) {
        QYZJZengZhiFuWuNeiView * view1 = [[QYZJZengZhiFuWuNeiView alloc] initWithFrame:CGRectMake(space + (ww + space) * (i%3), space + (hh + space) * (i/3), ww, hh)];
        view1.bt.tag = 100+i;
        view1.tag = 100+i;
        view1.model = dataArray[i];
        [view1.bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:view1];
    }
}

- (void)click:(UIButton *)button {
    [self selectAction:button.tag];
}

- (void)selectAction:(NSInteger)index{
    QYZJMoneyModel * model = self.dataArray[index-100];
    if (model.isSelect) {
        model.isSelect = NO;
        QYZJZengZhiFuWuNeiView * view = [self.whiteV viewWithTag:index];
        view.model = model;
    }else {
        model.isSelect = YES;
        QYZJZengZhiFuWuNeiView * view = [self.whiteV viewWithTag:index];
        view.model = model;
        for (int i = 0 ; i<self.dataArray.count;i++  ) {
             QYZJMoneyModel * modelN = self.dataArray[i];
            if (i+100 != index && modelN.isSelect) {
                modelN.isSelect = NO;
                QYZJZengZhiFuWuNeiView * view = [self.whiteV viewWithTag:i+100];
                view.model = modelN;
            }
        }
        
    }
    
    
    
    
}



@end


@implementation QYZJZengZhiFuWuNeiView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
 
        self.userInteractionEnabled = YES;
        self.bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 7.5, frame.size.width, frame.size.height - 8)];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"bg_2"] forState:UIControlStateNormal];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"bg_3"] forState:UIControlStateSelected];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"bg_3"] forState:UIControlStateHighlighted];
        [self addSubview:self.bt];

//        [self.bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    
        
        self.tuiJianLB = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 35, 0, 35, 15)];
        self.tuiJianLB.font = kFont(12);
        self.tuiJianLB.backgroundColor = [UIColor redColor];
        self.tuiJianLB.textColor = WhiteColor;
        self.tuiJianLB.textAlignment = NSTextAlignmentCenter;
        self.tuiJianLB.text = @"推荐";
        [self addSubview:self.tuiJianLB];
        
        self.tuiJianLB.layer.mask = [self getBezierWithFrome:self.tuiJianLB andRadi:7.5];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height - 8) / 2 - 25, frame.size.width,   20)];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.font = kFont(13);
        [self addSubview:self.titleLB];
        
        self.moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height - 8) / 2 + 10 , frame.size.width, 30)];
        self.moneyLB.textAlignment = NSTextAlignmentCenter;
        self.moneyLB.font = kFont(15);
        self.moneyLB.textColor= OrangeColor;
        [self addSubview:self.moneyLB];

        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)clickAction:(UIButton *)button {
    if (self.clickTuiJianBlock != nil) {
        self.clickTuiJianBlock(button.superview.tag);
    }
}


- (void)setModel:(QYZJMoneyModel *)model {
    _model = model;
    self.titleLB.text = model.name;
    self.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",model.money];
    self.bt.selected = model.isSelect;
}


- (CAShapeLayer *)getBezierWithFrome:(UIView * )view andRadi:(CGFloat)radi {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(radi, radi)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
    
}


@end

