//
//  QYZJSearchView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJSearchView.h"

@implementation QYZJSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {


    }
    return self;
}

- (void)clickaction:(UIButton *)button {
    NSLog(@"%@",@"点击了阿里");

}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = ScreenW / dataArray.count;
    for (int i = 0 ; i< dataArray.count; i++) {

        QYZJSeNeiView * view = [[QYZJSeNeiView alloc] initWithFrame:CGRectMake(ww * i, 0, ww, self.frame.size.height-1)];
        view.tag = 100+i;
        [self addSubview:view];
        Weak(weakSelf);
        view.clickNeiBlock = ^(NSInteger index) {
            [weakSelf clickAction:index];
        };
        view.titleStr = dataArray[i];;
        if (i == 0) {
            view.isSelect = YES;
        }


    }
    
}

- (void)setIsCanChange:(BOOL)isCanChange {
    _isCanChange = isCanChange;
}

- (void)clickAction:(NSInteger)index {
    if (self.isCanChange) {
        
         QYZJSeNeiView * vv = [self viewWithTag:index];
         vv.isSelect = !vv.isSelect;
        self.clickHeadBlock(index-100,vv.isSelect);
        
    }else {
        for (int i = 0 ; i < self.dataArray.count; i++) {
               QYZJSeNeiView * vv = [self viewWithTag:100+i];
               if (i + 100 == index) {
                   vv.isSelect = YES;
               }else {
                   vv.isSelect = NO;
               }
               
           }
           self.clickHeadBlock(index-100,NO);
    }
    
}


@end



@interface QYZJSeNeiView()
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *bt;
@property(nonatomic,strong)UIImageView *imgV;
@end

@implementation QYZJSeNeiView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
      
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(14);
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.textColor = CharacterColor80;
        [self addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.centerX.equalTo(self.mas_centerX).offset(-15);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@1);
        }];

        self.imgV = [[UIImageView alloc] init];
        self.imgV.image = [UIImage imageNamed:@"7"];
        [self addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {

            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.titleLB.mas_right).offset(10);
            make.height.width.equalTo(@15);

        }];
        
        self.bt = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:self.bt];
        [self.bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLB.text = titleStr;
    CGFloat ww = [titleStr getWidhtWithFontSize:14];
    [self.titleLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ww+3));
    }];
    
    
}

- (void)clickAction:(UIButton *)button {
    if (self.clickNeiBlock != nil) {
        self.clickNeiBlock(button.superview.tag);
    }
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (isSelect) {
        self.imgV.image = [UIImage imageNamed:@"8"];
    }else {
        self.imgV.image = [UIImage imageNamed:@"7"];
    }
}



@end



