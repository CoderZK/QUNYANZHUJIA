//
//  QYZJSetBaoXiuTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/18.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJSetBaoXiuTVC.h"
#import "QYZJBaoXiuYearCell.h"
@interface QYZJSetBaoXiuTVC ()<UITextFieldDelegate>

@end

@implementation QYZJSetBaoXiuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置保修时间";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJBaoXiuYearCell" bundle:nil] forCellReuseIdentifier:@"cell"];

   
    [self addFootV];
    
}

- (void)addFootV {
    
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
       if (sstatusHeight > 20) {
           self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
       }
       
       KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"提交" andImgaeName:@""];
        Weak(weakSelf);
           view.footViewClickBlock = ^(UIButton *button) {
                    NSLog(@"\n\n%@",@"完成");
               [weakSelf clickAction:button];
          };
       [self.view addSubview:view];
   

}

- (void)clickAction:(UIButton *)button {
    
    
    [self.tableView endEditing:YES];
    
    NSMutableArray * arr = @[].mutableCopy;
    for (QYZJWorkModel * model  in self.dataArray) {
        NSMutableDictionary  * dict = @{}.mutableCopy;
        dict[@"id"] = model.ID;
        if (model.year.length == 0) {
            dict[@"year"] = @"0";
        }else {
            dict[@"year"] = model.year;
        }
        [arr addObject:dict];
    }
    NSString * str = [NSString convertToJsonDataWithDict:arr];
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"stageRepairTime"] = str;
    dict[@"turnoverId"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_setStageRepairTimeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"设置保修时间成功"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJBaoXiuYearCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.numberTF.delegate = self;
    cell.numberTF.text = self.dataArray[indexPath.row].year;
    cell.leftLB.text = self.dataArray[indexPath.row].stageName;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    QYZJBaoXiuYearCell * cell = (QYZJBaoXiuYearCell *)textField.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    self.dataArray[indexPath.row].year = textField.text;
    
}




@end
