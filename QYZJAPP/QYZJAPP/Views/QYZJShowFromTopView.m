//
//  QYZJShowFromTopView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJShowFromTopView.h"

@interface QYZJShowFromTopView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSearchArr;
@property(nonatomic,assign)BOOL isSearch;

@end



@implementation QYZJShowFromTopView


- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.dataSearchArr = @[].mutableCopy;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
               
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, -250, ScreenW, 250)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        UIButton * bb = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, ScreenW, ScreenH - 250)];
        [self addSubview:bb];
        [bb addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
        lb.text = @"施工阶段";
        lb.font = kFont(14);
        [self.whiteV addSubview:lb];
        
        self.TF = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, ScreenW - 110, 30)];
        self.TF.font = kFont(14);
        self.TF.placeholder = @"请输入施工阶段";
        @weakify(self);
        [[self.TF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            if (x.length == 0) {
                self.isSearch = NO;
                [self.tableView reloadData];
            }else {
                self.isSearch = YES;
                for (NSString * str  in self.dataArray) {
                    if ([str containsString:x]) {
                        [self.dataSearchArr addObject:str];
                    }
                }
                [self.tableView reloadData];
                
            }
            
        }];
        [self.whiteV addSubview:self.TF];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 200)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.whiteV addSubview:self.tableView];
        
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:backV];
        
    }
    return self;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearch) {
        return self.dataSearchArr.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.isSearch) {
      cell.textLabel.text = self.dataSearchArr[indexPath.row];
    }else {
      cell.textLabel.text = self.dataArray[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.subject != nil) {
        if (self.isSearch) {
            [self.subject sendNext:[NSString stringWithFormat:@"%@",self.dataSearchArr[indexPath.row]]];
        }else {
            [self.subject sendNext:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]]];
        }
        
        [self diss];
    }
    
}


- (void)show {
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.whiteV.mj_y = 0;
    }];
    
}

- (void)diss {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.whiteV.mj_y = - 250;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
