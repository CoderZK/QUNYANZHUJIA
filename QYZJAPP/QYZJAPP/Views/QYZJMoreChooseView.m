//
//  QYZJMoreChooseView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMoreChooseView.h"

@interface QYZJMoreChooseView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *wihteV;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView * topV;
@end

@implementation QYZJMoreChooseView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.frame;
        [button addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.wihteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 200)];
        [self addSubview:self.wihteV];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 150)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[QYZJMoreChooseCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.wihteV addSubview:self.tableView];
        
        
        
        [button addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        self.topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        self.topV.backgroundColor = WhiteColor;
        [self addSubview: self.topV];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake((ScreenW/2 - 100)/2, 0, 100, 49);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = kFont(15);
        [cancelBtn addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        [ self.topV addSubview:cancelBtn];
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake((ScreenW/2 - 100)/2 + ScreenW / 2, 0, 100, 49);
        [yesBtn setTitle:@"确定" forState:UIControlStateNormal];
        [yesBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        yesBtn.titleLabel.font = kFont(15);
        [self.topV addSubview:yesBtn];
        [self.wihteV addSubview:self.topV];
        
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.4, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self.wihteV addSubview:backV];
        

        
        
    }
    return self;
}

- (void)diss {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.wihteV.mj_y = ScreenH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.wihteV.mj_y = ScreenH - 200;
        
    }];
    
    
}

- (void)setDataArray:(NSMutableArray<QYZJTongYongModel *> *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMoreChooseCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QYZJTongYongModel * model = self.dataArray[indexPath.row];
    model.isSelect = !model.isSelect;
    [self.tableView reloadData];
}

@end



@implementation QYZJMoreChooseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        self.leftLB = [[UILabel alloc] init];
        self.leftLB.font = kFont(14);
        [self addSubview:self.leftLB];
        [self.leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self).offset(-80);
            make.height.equalTo(@20);
            
        }];
        
        self.rightImgV = [[UIImageView alloc] init];
        [self addSubview:self.rightImgV];
        [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@16);
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self).offset(-15);
        }];
        
    }
    return self;
}


- (void)setModel:(QYZJTongYongModel *)model {
    _model = model;
    
    if (model.isSelect) {
        self.rightImgV.image = [UIImage imageNamed:@"xuanze_2"];
    }else {
        self.rightImgV.image = [UIImage imageNamed:@"xuanze_1"];
    }
    self.leftLB.text = model.name;
    
    
}

@end
