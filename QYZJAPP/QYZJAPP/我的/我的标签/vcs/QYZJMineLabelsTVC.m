//
//  QYZJMineLabelsTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineLabelsTVC.h"
#import "QYZJCityChooseTVC.h"
#import "QYZJAddMineLabelsVC.h"
@interface QYZJMineLabelsTVC ()
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIButton *editBt;
@property(nonatomic,strong)KKKKFootView *footV;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSMutableArray *idsArr;
@property(nonatomic,strong)NSMutableArray<QYZJTongYongModel *> *leiXingArr;
@end

@implementation QYZJMineLabelsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArr = [self.labelsStr componentsSeparatedByString:@","].mutableCopy;
    self.idsArr = [self.labelsId componentsSeparatedByString:@","].mutableCopy;
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.01)];

    
    [self setLabels];
    
    self.editBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 75, 10, 60, 20)];
//    self.editBt.layer.cornerRadius = 3;
//    self.editBt.layer.borderColor = OrangeColor.CGColor;
//    self.editBt.layer.borderWidth = 1.0f;
    [self.editBt setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBt setTitle:@"编辑" forState:UIControlStateSelected];
    [self.editBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.editBt.titleLabel.font = kFont(14);
    self.editBt.tag = 3;
    [self.editBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editBt];
    
    

    
    
    self.footV = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    Weak(weakSelf);
    self.footV.footViewClickBlock = ^(UIButton *button) {
        NSLog(@"\n\n%@",@"完成");
        weakSelf.editBt.selected = NO;
        [weakSelf setfootV];
        [weakSelf setLabels];
        [weakSelf editUserInfoWithDict:nil];
    };
    [self.view addSubview:self.footV];
    self.footV.hidden = YES;
    self.leiXingArr = @[].mutableCopy;
    
    
}

- (void)getLeiXingData {

    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findLabelByTypeListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {

            self.leiXingArr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            NSArray * arr = [self.labelsStr componentsSeparatedByString:@","];
            for (QYZJTongYongModel * model in self.leiXingArr) {
                if ([arr containsObject:model.name]) {
                    model.isSelect = YES;
                    [self.idsArr addObject:model.ID];
                }
            }

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];

}



- (void)setfootV {
    if (self.editBt.selected) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
         if (sstatusHeight > 20) {
             self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
         }
        self.footV.hidden = NO;
    }else {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH );
        self.footV.hidden = YES;
    }
    
    
}

- (void)setLabels {
    
    [self.headV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat space = 25;
    CGFloat ww = (ScreenW - 6* space)/4;
    CGFloat hh = 35;
    
    for (int i = 0 ; i < self.titleArr.count + 1; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(space + (space + ww) * (i % 4), space + (space + hh) * (i/4), ww, hh)];
        button.titleLabel.font = kFont(14);
        button.layer.cornerRadius = 4;
        button.clipsToBounds = YES;
        [self.headV addSubview:button];

        
        if (i < self.titleArr.count) {
            [button setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
            [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
            [button setTitleColor:WhiteColor forState:UIControlStateNormal];
            if (self.editBt.selected) {
                //编辑状态
                UIButton * delectBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) - 10, CGRectGetMinY(button.frame) - 10, 20, 20)];
                delectBt.tag = 100+i;
                [delectBt addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
                [delectBt setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
                [self.headV addSubview:delectBt];
                
            }
        }else {
            [button setBackgroundImage:[UIImage imageNamed:@"bg_1"] forState:UIControlStateNormal];
            [button setTitle:@"新增" forState:UIControlStateNormal];
            button.layer.borderColor = OrangeColor.CGColor;
            [button setTitleColor:OrangeColor forState:UIControlStateNormal];
            button.layer.borderWidth = 1;
            [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
            CGFloat headH  = CGRectGetMaxY(button.frame) + 30;
            self.headV.mj_h = headH;
            self.tableView.tableHeaderView = self.headV;
        }
        
          
    }
    

}

- (void)clickAction:(UIButton *)button {
    
    button.selected = !button.selected;
    [self setfootV];
    [self setLabels];
    
}


- (void)delectAction:(UIButton *)button {
//    QYZJTongYongModel * model = self.leiXingArr[button.tag - 100];
//    model.isSelect = NO;
    [self.titleArr removeObjectAtIndex:button.tag -100];
    [self.idsArr removeObjectAtIndex:button.tag-100];
    [self setLabels];
    
}

- (void)add {
    QYZJAddMineLabelsVC * vc =[[QYZJAddMineLabelsVC alloc] init];
    vc.leiXingArr = self.leiXingArr;
    Weak(weakSelf);
    vc.sendLabelsBlock = ^(NSString * _Nonnull labelsID, NSString * _Nonnull labelsStr) {
        weakSelf.idsArr = [labelsID componentsSeparatedByString:@","].mutableCopy;
        weakSelf.titleArr = [labelsStr componentsSeparatedByString:@","].mutableCopy;
        [weakSelf setLabels];
    };
    vc.role_id = self.role_id;
    vc.hidesBottomBarWhenPushed = YES;
    vc.labelsStr = [self.titleArr componentsJoinedByString:@","];
    vc.labelsID = [self.idsArr componentsJoinedByString:@","];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editUserInfoWithDict:(NSDictionary*)dict {
    
    [SVProgressHUD show];
    NSMutableDictionary * dictTwo = @{}.mutableCopy;
    dictTwo[@"label_ids"] = [self.idsArr componentsJoinedByString:@","];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editInfoURL] parameters:dictTwo success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"标签修改成功"];
            self.editBt.selected = YES;
            [self setfootV];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
   
        
    }];
    
}

@end
