//
//  QYZJAddMineLabelsVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddMineLabelsVC.h"

@interface QYZJAddMineLabelsVC ()
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property (weak, nonatomic) IBOutlet UITextField *TF;

@property(nonatomic,strong)QYZJMoreChooseView *moreChooseV;

@end

@implementation QYZJAddMineLabelsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增标签";
    self.moreChooseV = [[QYZJMoreChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self getLeiXingData];
    self.TF.text = self.labelsStr;
}

- (IBAction)chooseAction:(UIButton *)sender {
    
    [self showView];
    
    
}

- (void)showView  {
    
    self.moreChooseV.dataArray = self.leiXingArr;
    Weak(weakSelf);
    self.moreChooseV.chooseViewMoreBlockFinsh = ^{
        NSMutableArray * idsArr = @[].mutableCopy;
        NSMutableArray * titlesArr = @[].mutableCopy;
        for (QYZJTongYongModel * mm  in weakSelf.leiXingArr) {
            if (mm.isSelect) {
                [idsArr addObject:mm.ID];
                [titlesArr addObject:mm.name];
            }
        }
        weakSelf.labelsID = [idsArr componentsJoinedByString:@","];
        weakSelf.labelsStr = [titlesArr componentsJoinedByString:@","];
        weakSelf.TF.text = weakSelf.labelsStr;
    };
    [self.moreChooseV show];
    
}

- (IBAction)confirmAction:(UIButton *)sender {
    
    if (self.labelsID.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"至少选择一个标签"];
        return;
    }

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"label_ids"] = self.labelsID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
   
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (self.sendLabelsBlock != nil) {
                self.sendLabelsBlock(self.labelsID,self.labelsStr);
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
    
   
    

    
    
}




- (void)getLeiXingData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"role_id"] = self.role_id;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findLabelByTypeListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            
            self.leiXingArr = [QYZJTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            NSArray * arr = [self.labelsID componentsSeparatedByString:@","];
            for (QYZJTongYongModel * mm  in self.leiXingArr) {
                if ([arr containsObject:mm.ID]) {
                    mm.isSelect = YES;
                }
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


@end
