//
//  QYZJQingDanPingJiaVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJQingDanPingJiaVC.h"

@interface QYZJQingDanPingJiaVC ()
@property(nonatomic,strong)IQTextView *TV;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,assign)NSInteger selectTag;
@end

@implementation QYZJQingDanPingJiaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价";
    
    [self setFootV];
    
    [self setheadV];
    
}

- (void)setheadV {
    
    UIView * headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-200)];
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(10, 10, ScreenW-20, 150)];
    self.TV.placeholder = @"请输入评价内容";
    [headV addSubview:self.TV];
    self.TV.font = kFont(14);
    self.headV = headV;
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 150, ScreenW, 10)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [headV addSubview:backV];
    
    
    

    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 60, 20)];
    lab.text = @"满意度";
    [headV addSubview:lab];
    
    NSArray * arr = @[@"不满意",@"一般",@"满意"];
    NSArray * colorArr =@[[UIColor redColor],[UIColor orangeColor],[UIColor blueColor]];
    CGFloat mx = ScreenW-10;
    for (int i = 0 ; i < arr.count; i++) {
        
        CGFloat ww = [arr[i] getWidhtWithFontSize:14] + 20;
        mx = mx - 10 - (20 + ww);
        UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(mx, 165, ww+30, 30)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:colorArr[i] forState:UIControlStateNormal];
        button.tag = 100+i;
        button.titleLabel.font = kFont(14);
        [button setImage:[UIImage imageNamed:@"37"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"38"] forState:UIControlStateSelected];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 2) {
            button.selected = YES;
            self.selectTag = 102;
        }
        [headV addSubview:button];
        
    }
    
    
    
    
    
    
    self.tableView.tableHeaderView = headV;
}

- (void)clickAction:(UIButton *)button {
    self.selectTag = button.tag;
    for (int i = 100; i<103; i++) {
        UIButton * buttonNei = (UIButton *)[self.headV viewWithTag:i];
        if (button.tag == buttonNei.tag) {
            buttonNei.selected = YES;
        }else {
            buttonNei.selected = NO;
        }
    }
    
    
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"提交" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        [weakSelf.tableView endEditing:YES];
        
        [weakSelf getData];
        
    };
    [self.view addSubview:view];
}

- (void)getData {
    
    if (self.TV.text == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return;
    }
    [self.tableView endEditing:YES];
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"evaluateLevel"] = @(103 - self.selectTag);
    dict[@"id"] = self.ID;
    dict[@"evaluateCon"] = self.TV.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_turnoverStageEvalURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"阶段评价成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



@end
